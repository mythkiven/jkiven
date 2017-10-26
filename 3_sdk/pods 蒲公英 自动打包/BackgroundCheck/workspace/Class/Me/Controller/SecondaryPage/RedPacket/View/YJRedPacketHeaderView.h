//
//  YJRedPacketHeaderView.h
//  CreditPlatform
//
//  Created by yj on 16/9/18.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJRedPacketHeaderView : UIView


@property (nonatomic, copy) NSString *rechargeAllAmt;


@property (nonatomic, copy) NSString *rechargeRedEndDate;


+ (id)redPacketHeaderView ;

-(void)setRechargeAllAmt:(NSString *)rechargeAllAmt rechargeRedEndDate:(NSString *)rechargeRedEndDate;
@end
