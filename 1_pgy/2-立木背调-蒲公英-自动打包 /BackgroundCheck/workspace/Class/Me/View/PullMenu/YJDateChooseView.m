//
//  YJDateChooseView.m
//  下拉菜单
//
//  Created by yj on 16/9/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJDateChooseView.h"
#import "UIImage+Extension.h"
#import "YJDatePickerView.h"


@interface YJDateChooseView ()

@property (weak, nonatomic) IBOutlet UIButton *todayBtn;
@property (weak, nonatomic) IBOutlet UIButton *weekBtn;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeMonthBtn;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property (weak, nonatomic) IBOutlet UIButton *endBtn;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic, weak) UIButton *selectedBtn;

@property (nonatomic, weak) UIButton *selectedDateBtn;

@end

@implementation YJDateChooseView

- (YJDatePickerView *)picker {
    if (_picker == nil) {
        _picker = [[YJDatePickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kDatePickerViewHeight)];
        
        _picker.maximumDate = [NSDate date];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setMonth:-3];//设置最小时间为：当前时间前推1个月
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        _picker.minimumDate = minDate;
        
    }
    return _picker;
}

+(instancetype)dateChooseViewHasToday:(BOOL)isHasToday {
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"YJDateChooseView" owner:nil options:nil];
    
    if (isHasToday) {
        return arr[0];
    }
    return arr[1];
    
}

+(instancetype)dateChooseView{
    return  [[[NSBundle mainBundle] loadNibNamed:@"YJDateChooseView" owner:nil options:nil] firstObject];;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupBtnStyle:self.todayBtn];
    [self setupBtnStyle:self.weekBtn];
    [self setupBtnStyle:self.monthBtn];
    [self setupBtnStyle:self.threeMonthBtn];
    
    [self setupBtnStyle:self.startBtn];
    [self setupBtnStyle:self.endBtn];
    
    // 默认选中三个月
    [self clickBtnChooseDate:self.threeMonthBtn];
    
    
//    [self setupBtnBorderStyle:self.startBtn];
//    [self setupBtnBorderStyle:self.endBtn];

}


- (void)setupBtnBorderStyle:(UIButton *)btn {
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor = RGB_grayLine.CGColor;
    btn.layer.borderWidth = 0.5;
    btn.layer.masksToBounds = YES;
    
    
    [btn setBackgroundImage:[UIImage imageWithColor:RGB(247, 247, 247)] forState:(UIControlStateNormal)];
    [btn setBackgroundImage:[UIImage imageWithColor:RGB_white] forState:(UIControlStateHighlighted)];
}

- (void)setupBtnStyle:(UIButton *)btn {

    [self setupBtnBorderStyle:btn];
    
    [btn setTitleColor:RGB_black forState:UIControlStateNormal];
    
    [btn setTitleColor:RGB_blueText forState:UIControlStateSelected];
    
   
    
    [btn setBackgroundImage:[UIImage imageWithColor:RGB_white] forState:(UIControlStateSelected)];
    
    
    
}



- (void)clearSelectedDateBtnStyle {
    // 清空时间的选中效果
    if (self.selectedDateBtn) {
        self.selectedDateBtn.selected = NO;
        self.selectedDateBtn.layer.borderColor = RGB_grayLine.CGColor;
        self.selectedDateBtn = nil;

    }
}


- (IBAction)clickBtnChooseDate:(UIButton *)sender {
    // 清空时间的选中效果
    [self clearSelectedDateBtnStyle];
    
    self.selectedBtn.selected = NO;
    self.selectedBtn.layer.borderColor = RGB_grayLine.CGColor;
    
    sender.selected = YES;
    sender.layer.borderColor = RGB_blueText.CGColor;

    self.selectedBtn = sender;
    
    NSDate *now = [NSDate date];

    
    [self.endBtn setTitle:[self dateStrWith:now] forState:(UIControlStateNormal)];

    
    [self.picker hidden];

    
    
   
    switch (sender.tag) {
        case 11: // 今天
            
            [self.startBtn setTitle:[self dateStrWith:now] forState:(UIControlStateNormal)];
            
            break;
        case 12: // 最近一周
        {
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            //    [comps setWeekday:-7];
            [comps setDay:-7];
            NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDate *mDate = [calender dateByAddingComponents:comps toDate:now options:0];
            
            [self.startBtn setTitle:[self dateStrWith:mDate] forState:(UIControlStateNormal)];
            break;

        }
        case 13: // 最近一月
            [self.startBtn setTitle:[self dateStrWithMonthSinceNow:-1] forState:(UIControlStateNormal)];

            
            break;
        case 14: // 最近三月
            [self.startBtn setTitle:[self dateStrWithMonthSinceNow:-3] forState:(UIControlStateNormal)];

            break;
            
        default:
            break;
    }
    
    
    
}

/**
 *
 *  时间转字符串：yyyy-MM-dd
 */
- (NSString *)dateStrWithMonthSinceNow:(NSInteger)month {
    
    NSDate *now = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:now options:0];
    
    return [self dateStrWith:mDate];
}

/**
 *
 *  时间转字符串：yyyy-MM-dd
 */
- (NSString *)dateStrWith:(NSDate *)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [df stringFromDate:date];
    return dateStr;
}
/**
 *
 *  转日期对象：yyyy-MM-dd
 */

- (NSDate *)getDateWithStr:(NSString *)dateStr {
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:GTMzone];
    return  [dateFormatter dateFromString:dateStr];
    
}

- (IBAction)customDate:(UIButton *)sender {

    self.selectedDateBtn.selected = NO;
    self.selectedDateBtn.layer.borderColor = RGB_grayLine.CGColor;
    
    sender.selected = YES;
    sender.layer.borderColor = RGB_blueText.CGColor;
    
    self.selectedDateBtn = sender;
//
//    switch (sender.tag) {
//        case 21: // 开始时间
//            
//            break;
//        case 22: // 结束时间
//            break;
//            
//        default:
//            break;
//    }
//
    if (!self.picker.superview) {
        
        __weak typeof(self) weakSelf = self;
        UIWindow *myWindow = [[UIApplication sharedApplication].windows lastObject];
        [myWindow addSubview:self.picker];
        // 显示
        [_picker show];
       
        self.picker.resultCallBack = ^(NSDate *currentDate,int index) {
            if (index == 1) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                [weakSelf.selectedDateBtn setTitle:[formatter stringFromDate:currentDate] forState:(UIControlStateNormal)];
//                [weakSelf.dateBtn setTitleColor:RGB_black forState:(UIControlStateNormal)];
                [weakSelf clearSelectedDateBtnStyle];
                
            }else if (index == 3){//即时修改结果
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                [weakSelf.selectedDateBtn setTitle:[formatter stringFromDate:currentDate] forState:(UIControlStateNormal)];
            }else{
                [weakSelf clearSelectedDateBtnStyle];
            }
        };
    }else{
        [_picker show];
    }
}


- (IBAction)cancelAndOKBtnClcik:(UIButton *)sender {

    switch (sender.tag) {
            
        case 31: // 取消
            [self.picker hidden];
            
            break;
        case 32: // 确定
        {
            // 判断时间格式 前后顺序
            NSCalendar *calendar = [NSCalendar currentCalendar];
            int unit = NSCalendarUnitDay;
            NSDateComponents *comp =  [calendar components:unit fromDate:[self getDateWithStr:self.startBtn.titleLabel.text] toDate:[self getDateWithStr:self.endBtn.titleLabel.text] options:0];
            
            BOOL isValid = YES;
            if (comp.day<0) {
                isValid = NO;
            }
            
            // 发送通知
            if (isValid) {
                        
                [[NSNotificationCenter defaultCenter] postNotificationName:YJDateDidChangeNotification object:nil userInfo:@{@"startDate":self.startBtn.titleLabel.text,@"endDate":self.endBtn.titleLabel.text}];
                
            } else {
                MYLog(@"------时间顺序错误");
                UIWindow *myWindow = [[UIApplication sharedApplication].windows lastObject];
                
                
                [myWindow.rootViewController.view makeToast:@"起始时间顺序错误"];
                
                return;
            }
            
            
            
            
            break;
        }

            
        default:
            break;
    }
    
    [self clearSelectedDateBtnStyle];

    if (self.hideDateChooseView) {
        self.hideDateChooseView();
    }
    
}


@end
