//
//  YJDatePickerView.m
//  CreditPlatform
//
//  Created by yj on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "DatePickerManager.h"


@interface DatePickerManager ()
{
    UIView *_line;
    UIButton  *_cancelBtn;
    UIButton   *_commitBtn;
    UIDatePicker *_datePicker;
    
    
}

@end

@implementation DatePickerManager
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        self.backgroundColor = RGB(247, 247, 247);
    }
    return self;
}
#pragma mark 初始化控件
- (void)commonInit {
    
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = RGB_grayLine;
    [self addSubview:_line];
    
    _cancelBtn = [self setupBtnTitle:@"取消" tag:11];
    
    _commitBtn = [self setupBtnTitle:@"完成" tag:12];
    _commitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.backgroundColor = RGB(237, 240, 243);
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
    _datePicker.date = [NSDate date];
    [self addSubview:_datePicker];
    
    _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    //当前时间创建NSDate
    NSDate *localDate = [NSDate date];
    _datePicker.maximumDate = localDate;
    NSDate *date4  = [CalendarManger getPriousorLaterDateFromDate:[NSDate date] withMonth:-3];
//    NSDate *date4 = [[NSDate alloc] initWithTimeInterval:(-90*24*60*60+8*60*60) sinceDate:[NSDate date]];
    _datePicker.minimumDate = date4;
    
    _datePicker.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _datePicker.contentHorizontalAlignment =UIControlContentVerticalAlignmentCenter;
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    //重点：UIControlEventValueChanged
    
    self.hidden = YES;
}

#pragma mark 实时改变日期
-(void)dateChanged:(id)sender {
//    UIDatePicker *control = (UIDatePicker*)sender;
//    NSDate* date = control.date;
    
    NSDate *pickerDate = [_datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    if (self.resultCallBack) {
        self.resultCallBack(dateString,nil);
    }
    if ([self.delegate respondsToSelector:@selector(didSelectedDate:WithIndex:)]) {
        [self.delegate didSelectedDate:dateString WithIndex:nil];
    }

}
#pragma mark 点选按钮
- (UIButton *)setupBtnTitle:(NSString *)title tag:(int)index {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = Font15;
    btn.backgroundColor = [UIColor clearColor];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:RGB_navBar forState:UIControlStateNormal];
    btn.tag = index;
    [btn addTarget:self action:@selector(headerViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat supWidth = self.frame.size.width;
    //    CGFloat supHeight = self.frame.size.height;
    
    _line.frame = CGRectMake(0, 0, supWidth, 0.5);
    
    CGFloat btnW = (supWidth - kMargin_15*2) * .5;
    
    _cancelBtn.frame = CGRectMake(kMargin_15, 0, btnW, kToolBarH);
    _commitBtn.frame = CGRectMake(kMargin_15+btnW, 0, btnW, kToolBarH);
    
    _datePicker.frame = CGRectMake(0, kToolBarH, supWidth, kDatePickerH);
    if (iPhone4s) {
        _datePicker.frame = CGRectMake(0, kToolBarH,  supWidth, 45+185);
    }
}

- (void)headerViewButtonClick:(UIButton*)button {
    NSDate *pickerDate = [_datePicker date];
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init]; 
    [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    
    if (self.resultCallBack) {
        self.resultCallBack(dateString, [NSString  stringWithFormat:@"%ld",button.tag]);
    }
    if ([self.delegate respondsToSelector:@selector(didSelectedDate:WithIndex:)]) {
        [self.delegate didSelectedDate:dateString WithIndex:[NSString  stringWithFormat:@"%ld",button.tag]];
    }
//    [self hidden];
    
    
    
}


-(void)setOriginal{
   _datePicker.date = [NSDate date];
}

-(void)setOriginalOld{
    NSDate *date4  = [CalendarManger getPriousorLaterDateFromDate:[NSDate date] withMonth:-3];
    
//    NSDate *date4 = [[NSDate alloc] initWithTimeInterval:(-90*24*60*60+8*60*60) sinceDate:[NSDate date]];
    _datePicker.date = date4;
}


- (void)show
{
    self.hidden = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, 0, -kDatePickerViewHeight);
        
    }];
    
}
- (void)hidden
{
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


//- (void)setFrame:(CGRect)frame {
//
//    frame.size.width = SCREEN_WIDTH;
//    frame.size.height = kDatePickerViewHeight;
//    [super setFrame:frame];
//}

@end
