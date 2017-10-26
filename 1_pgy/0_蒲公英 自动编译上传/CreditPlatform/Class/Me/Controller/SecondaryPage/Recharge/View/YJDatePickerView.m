//
//  YJDatePickerView.m
//  CreditPlatform
//
//  Created by yj on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJDatePickerView.h"


@interface YJDatePickerView ()
{
    UIView *_line;
    UIView *_line1;
    UIButton  *_cancelBtn;
    UIButton   *_commitBtn;
    UIDatePicker *_datePicker;
    
    
}

@end

@implementation YJDatePickerView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        self.backgroundColor = RGB_grayBar;
    }
    return self;
}

- (void)commonInit
{

    
    _line = [[UIView alloc] init];
    _line.backgroundColor = RGB_grayLine;
    [self addSubview:_line];
    
    _line1 = [[UIView alloc] init];
    _line1.backgroundColor = RGB_grayLine;
    [self addSubview:_line1];
    
    _cancelBtn = [self setupBtnTitle:@"取消" tag:0];
    _commitBtn = [self setupBtnTitle:@"确定" tag:1];
    _commitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.backgroundColor = RGB_lightGray;
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
//    NSDate *maxDate = [NSDate date];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDate *currentDate = [NSDate date];
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    [comps setMonth:-1];//设置最小时间为：当前时间前推1个月
//    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
//
//    
//    [_datePicker setMaximumDate:maxDate];
//    [_datePicker setMinimumDate:minDate];
    
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];

    _datePicker.date = [NSDate date];
    [self addSubview:_datePicker];

    
}

#pragma mark 实时改变日期
-(void)dateChanged:(id)sender {
    if (self.resultCallBack) {
        self.resultCallBack(_datePicker.date,3);
    }
    
    
}


- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    
    //    NSDate *maxDate = [NSDate date];
    
    [_datePicker setMaximumDate:_maximumDate];
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    //    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //    NSDate *currentDate = [NSDate date];
    //    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //    [comps setMonth:-1];//设置最小时间为：当前时间前推1个月
    //    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [_datePicker setMinimumDate:_minimumDate];
    
    
    
}

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


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat supWidth = self.frame.size.width;
//    CGFloat supHeight = self.frame.size.height;
    
    _line.frame = CGRectMake(0, 0, supWidth, 0.5);
    _line1.frame = CGRectMake(0, kToolBarH-.5, supWidth, 0.5);

    CGFloat btnW = (supWidth - kMargin_15*2) * .5;
    
    _cancelBtn.frame = CGRectMake(kMargin_15, 0, btnW, kToolBarH);
    _commitBtn.frame = CGRectMake(kMargin_15+btnW, 0, btnW, kToolBarH);

    _datePicker.frame = CGRectMake(0, kToolBarH, supWidth, kDatePickerH);

}

- (void)headerViewButtonClick:(UIButton*)button
{
    if (self.resultCallBack) {
        self.resultCallBack(_datePicker.date,(int)button.tag);
    }
    [self hidden];
    
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
