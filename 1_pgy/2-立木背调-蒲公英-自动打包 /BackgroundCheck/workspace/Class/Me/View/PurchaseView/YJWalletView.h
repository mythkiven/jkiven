//
//  YJWalletView.h
//  CreditPlatform
//
//  Created by yj on 16/9/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  点击钱包
 *
 *  @param index   1：余额 2：红包
 */
typedef void(^PacketOption)(int index);

@interface YJWalletView : UIView
/**
 *  余额
 */
@property (nonatomic, copy) NSString *balance;
/**
 *  红包
 */
@property (nonatomic, copy) NSString *redPackets;

@property (nonatomic, copy) PacketOption packetOption;

+ (instancetype)walletView ;
@end
