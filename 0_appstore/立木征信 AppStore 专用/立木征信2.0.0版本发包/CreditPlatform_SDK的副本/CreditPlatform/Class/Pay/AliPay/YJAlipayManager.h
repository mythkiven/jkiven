//
//  YJAlipayManager.h
//  CreditPlatform
//
//  Created by yj on 16/9/18.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>




typedef void(^AlipayOrder)(NSString *out_trade_no);

@interface YJAlipayManager : NSObject

+ (void)alipayWithTotalAmount:(NSString *)total_amount outTradeNo:(NSString *)out_trade_no viewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from;
/**
 *  点击提交订单
 *
 *  @param total_amount 支付金额
 *  @param out_trade_no 订单号---{1.直接支付参数为@“”，2.在充值记录充值参数要填写订单号}
 *  @param vc           控制器
 */
+ (void)alipayWithTotalAmount:(NSString *)total_amount outTradeNo:(NSString *)out_trade_no viewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from creatAlipayOrder:(AlipayOrder)alipayOrder;

/**
 *  处理支付结果
 *
 */
+ (void)alipayHandleResult:(NSURL *)url  viewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from;

@end
