//
//  PayConst.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/21.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
//NSString const *AWPaySuccess = @"支付成功";
//NSString const *AWPayIng = @"正在处理中";
//NSString const *AWPayFail = @"订单支付失败";
//NSString const *AWPayCancel = @"用户中途取消";
//NSString const *AWPayUnSupportWX = @"微信不支持支付";
//NSString const *AWPayAuthDeny = @"授权失败";
//NSString const *AWPayNetDeny =@"网络连接出错";

#define AWPaySuccess   @"支付成功"
#define AWPayIng  @"正在处理中"
#define AWPayFail  @"订单支付失败" 
#define AWPayCancel @"用户中途取消"
#define AWPayUnSupportWX @"微信不支持支付"
#define AWPayAuthDeny  @"授权失败"
#define AWPayNetDeny  @"网络连接出错"

typedef enum {
    YJAlipayFromBalance=100, //从余额进行支付
    YJAlipayFromRechargeHis //从充值记录（待支付订单）进行支付
} YJAlipayFrom;

@interface PayConst : NSObject

@end
