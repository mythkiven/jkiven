//
//  YJWalletView.m
//  CreditPlatform
//
//  Created by yj on 16/9/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJWalletView.h"


@interface YJWalletView ()

@property (weak, nonatomic) IBOutlet UILabel *balanceLB;

@property (weak, nonatomic) IBOutlet UILabel *redPacketsLB;

@end
@implementation YJWalletView

+ (instancetype)walletView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"YJWalletView" owner:nil options:nil] firstObject];
}

/**
 *  余额
 */
- (void)setBalance:(NSString *)balance {
    _balance = [balance copy];
    UIColor *color = nil;
    if ([balance hasPrefix:@"-"]) {
        color = RGB_redText;
    } else {
        color = RGB_navBar;
    }
    self.balanceLB.attributedText = [self getAttributedString:balance color:color];
}
/**
 *  红包
 */
- (void)setRedPackets:(NSString *)redPackets {
    _redPackets = [redPackets copy];
    self.redPacketsLB.attributedText =  [self getAttributedString:redPackets color:RGB_black];
}



- (NSMutableAttributedString *)getAttributedString:(NSString *)str color:(UIColor *)color {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range = [str rangeOfString:@"元"];
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20],
                            NSForegroundColorAttributeName : color} range:NSMakeRange(0, str.length)];
    if (range.location != NSNotFound) {
        [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]} range:range];

    }
    return attStr;
}
/**
 *  点击余额
 *
 */
- (IBAction)blanceBtnClick:(UIButton *)sender {
    

    if (self.packetOption) {
        self.packetOption((int)sender.tag);
    }
    
}


@end
