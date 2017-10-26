//
//  PurchaseHistoryTopPullView.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "PurchaseHistoryTopPullTime.h"
@interface PurchaseHistoryTopPullTime ()
@property (weak, nonatomic) IBOutlet UIButton *todayBtn;
@property (weak, nonatomic) IBOutlet UIButton *weekBtn;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeMonthBtn;



@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation PurchaseHistoryTopPullTime
{
    PurchaseHistoryTimeType type_;
    
}
+(instancetype)initPurchaseHistoryTopPullTime{
    return  [[[NSBundle mainBundle] loadNibNamed:@"PurchaseHistoryTopPullTime" owner:nil options:nil] firstObject];;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self cornerBtn:_todayBtn blue:NO black:NO];
    [self cornerBtn:_weekBtn blue:NO black:NO];
    [self cornerBtn:_monthBtn blue:NO black:NO];
    [self cornerBtn:_threeMonthBtn blue:NO black:NO];
    [self cornerBtn:_beginBtn blue:NO black:NO];
    [self cornerBtn:_endBtn blue:NO black:NO];
    
    
    [self setupBtnBgImage:_todayBtn];
    [self setupBtnBgImage:_weekBtn];
    [self setupBtnBgImage:_monthBtn];
    [self setupBtnBgImage:_threeMonthBtn];

    
}

/*
 * 设置按钮的背景颜色
 */
- (void)setupBtnBgImage:(UIButton *)btn {
    [btn setBackgroundImage:[UIImage imageWithColor:RGB(247, 247, 247)] forState:(UIControlStateNormal)];
    [btn setBackgroundImage:[UIImage imageWithColor:RGB_white] forState:(UIControlStateHighlighted)];

    [btn setBackgroundImage:[UIImage imageWithColor:RGB_white] forState:(UIControlStateSelected)];
}

-(void)cornerBtn:(UIButton*)btn blue:(BOOL)yes black:(BOOL)no{
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor = RGB_grayLine.CGColor;
    btn.layer.borderWidth = 0.5;
    btn.layer.masksToBounds = YES;
    if (no) {
       [btn setTitleColor:RGB_black forState:UIControlStateNormal];
    }
    if (yes) {
        btn.layer.borderColor = RGB_blueText.CGColor;
        [btn setTitleColor:RGB_blueText forState:UIControlStateNormal];
    }
}
//取消 确定 取消 31 确定 32
- (IBAction)clickedCancelSure:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(didClickedCancelSureBtn: TimeType:)]) {
        if (sender.tag == 31) {
            [self.delegate didClickedCancelSureBtn:sender TimeType:9999];
        }else if(sender.tag == 32){
            [self.delegate didClickedCancelSureBtn:sender TimeType:type_];
        }
        
    }
    
    
    
}
//开始结束时间 开始 21 结束 22
- (IBAction)clickedBeginEndBtn:(UIButton *)sender {
    //类型互斥
    if (_todayBtn.selected|_weekBtn.selected|_monthBtn.selected|_threeMonthBtn.selected) {
        [self setSelectedNo:nil];
        type_ = 9999;
    }
    //自己互斥
    
    if ([self.delegate respondsToSelector:@selector(didClickeBeginEndTimeBtn:)]) {
        [self.delegate didClickeBeginEndTimeBtn:sender];
    }
}

// 消费时间 11\12\13\14-:今天 一周 一月 三月.
// 回调放在确定按钮里面。
- (IBAction)costTime:(UIButton *)sender {
    //自己互斥
    [self setSelectedNo:sender];
    // datepicker 互斥：
    
    if (sender.tag == 11) {
        type_ =PurchaseHistoryTimeTypeToday;
    } else if (sender.tag == 12) {
        type_ =PurchaseHistoryTimeTypeWeek;
    }  else if (sender.tag == 13) {
        type_ =PurchaseHistoryTimeTypeMonth;
    } else if (sender.tag == 14) {
        type_ =PurchaseHistoryTimeTypeThreeMonth;
    }
    
    if (sender.selected &&[self.delegate respondsToSelector:@selector(didSelectedPurchaseHistoryTimeType:)]) {
        [self.delegate didSelectedPurchaseHistoryTimeType:type_];
    }
    
    
}
-(void)setSelectedNo:(UIButton*)btn{
    BOOL yes = btn.selected;
    _todayBtn.selected = NO;
    _weekBtn.selected = NO;
    _monthBtn.selected =NO;
    _threeMonthBtn.selected =NO;
    [self cornerBtn:_threeMonthBtn blue:NO  black:YES];
    [self cornerBtn:_monthBtn blue:NO black:YES];
    [self cornerBtn:_weekBtn blue:NO black:YES];
    [self cornerBtn:_todayBtn blue:NO black:YES];
    if (yes ==YES) {
        btn.selected =NO;
    }else{
        btn.selected =YES;
        [self cornerBtn:btn blue:YES black:NO];
    }
    
}

@end




