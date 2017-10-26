//
//  YJoverdraftView.m
//  CreditPlatform
//
//  Created by yj on 16/10/12.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJoverdraftView.h"

@implementation YJoverdraftView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews {

    CGFloat overdraftViewH = 50;
    self.backgroundColor = RGB(255, 243, 184);
    
    
    UILabel *tipLB = [[UILabel alloc] init];
    tipLB.text = @"您的账户已透支，请及时充值。";
    tipLB.backgroundColor = [UIColor clearColor];
    tipLB.textColor = RGB(242,65,48);
    UIFont *tipLBFont = Font13;
    tipLB.font = tipLBFont;
    CGFloat tipLBW = [NSString calculateTextSize:CGSizeMake(MAXFLOAT, MAXFLOAT) Content:tipLB.text font:tipLBFont].width;
    //        CGFloat tipLBW = 200;
    CGFloat rechargeBtnW = 80;
    CGFloat tipLBX = (SCREEN_WIDTH - rechargeBtnW - tipLBW) * .5;
    tipLB.frame = CGRectMake(tipLBX, 0, tipLBW, overdraftViewH);
    [self addSubview:tipLB];
    
    
    CGFloat rechargeBtnH = 30;
    CGFloat rechargeBtnX = CGRectGetMaxX(tipLB.frame)+ kMargin_10;
    //        CGFloat rechargeBtnX = tipLBX + tipLBW;
    
    CGFloat rechargeBtnY = (overdraftViewH - rechargeBtnH) * .5;
    UIButton *rechargeBtn = [self rechargeButton];
    rechargeBtn.frame =CGRectMake(rechargeBtnX, rechargeBtnY, rechargeBtnW,rechargeBtnH);
    rechargeBtn.titleLabel.font = Font15;
    
    [self addSubview:rechargeBtn];
    
}

- (UIButton *)rechargeButton {
    UIButton *rechargeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    rechargeBtn.frame =CGRectMake(kMargin_15, tipLBH+(headerH - tipLBH - rechargeBtnH)*.5, SCREEN_WIDTH - kMargin_15*2,rechargeBtnH);
    [rechargeBtn setTitle:@"充值" forState:(UIControlStateNormal)];
    rechargeBtn.titleLabel.font = Font18;
    rechargeBtn.layer.cornerRadius = 2;
    rechargeBtn.layer.masksToBounds = YES;
    [rechargeBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
    [rechargeBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    [rechargeBtn setTitleColor:RGB_white forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:RGB_white forState:UIControlStateHighlighted];
    [rechargeBtn addTarget:self action:@selector(rechargeBtnClcik) forControlEvents:(UIControlEventTouchUpInside)];
    
    return rechargeBtn;
}

#pragma mark--充值跳转
- (void)rechargeBtnClcik {
    
    if (self.rechargeBlock) {
        self.rechargeBlock();
    }
    
    
//    if (![self checkUserIsLogin]) {
//        return;
//    }
//    YJBalanceVC *vc = [[YJBalanceVC alloc] init];
//    vc.balance = @"500000000.00";
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
