//
//  YJAlipayManager.m
//  CreditPlatform
//
//  Created by yj on 16/9/18.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJAlipayManager.h"
#import "YJAlipayOrder.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YJRechargeSuccessVC.h"
#import "DataVerifier.h"

#define kAlipayAPPID @"2017092808976914" //新
#define kAlipaySellerID @"2088421751343211" //旧

@implementation YJAlipayManager
#pragma mark   ==============点击订单 支付行为==============

+ (void)alipayWithTotalAmount:(NSString *)total_amount outTradeNo:(NSString *)out_trade_no viewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from creatAlipayOrder:(AlipayOrder)alipayOrder {
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timestampStr = [formatter stringFromDate:[NSDate date]];
    
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        // 订单
//        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_orderPaySignWithAlipay,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd,
                               @"appVersion":@"1.0.0",
                               
                               @"app_id":kAlipayAPPID,
                               @"timestamp":timestampStr,
                               @"version":@"1.0",
                               @"body":@"立木征信账户余额充值",
                               @"subject":@"立木征信账户余额充值",
                               @"timeout_express":@"30m",
                               @"total_amount":total_amount,
                               @"seller_id":kAlipaySellerID,
                               @"product_code":@"QUICK_MSECURITY_PAY",
                               @"out_trade_no":out_trade_no
                               };
        
        
        
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_orderPaySignWithAlipay] params:dict success:^(id responseObj) {
            
            MYLog(@"提交订单信息---%@",responseObj);
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                YJAlipayOrder* order = [YJAlipayOrder mj_objectWithKeyValues:responseObj[@"data"]];
                
                NSString *orderInfo = [order orderInfoEncoded:NO];
                NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
                
                MYLog(@"orderInfo = %@",orderInfo);
                MYLog(@"orderInfoEncoded = %@",orderInfoEncoded);
                
                NSString *signedString = [order encodeValue:order.sign];
                if (alipayOrder) {
                    alipayOrder(order.bizcontent.out_trade_no);
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:order.bizcontent.out_trade_no forKey:@"Alipay_out_trade_no"];
                
                [[NSUserDefaults standardUserDefaults] setObject:order.bizcontent.total_amount forKey:@"Alipay_total_amount"];
                [[NSUserDefaults standardUserDefaults] setInteger:from forKey:@"Alipay_from"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                MYLog(@"后台signedString----%@",signedString);
                
                // NOTE: 如果加签成功，则继续执行支付
                if ( signedString!= nil) {
                    //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
                    NSString *appScheme = @"LIMUBEIDIAOAlipay";
                    
                    // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
                    NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                             orderInfoEncoded, signedString];
                    
                    // NOTE: 调用支付结果开始支付
                    __weak typeof(self) weakSelf = self;
                    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                        //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
                        
                        NSLog(@"callback - reslut = %@",resultDic);
                        [weakSelf dealAlipayResult:resultDic viewcontroller:vc from:from];
                        
                    }];
                }
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
                
            }
        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            MYLog(@"提交订单信息---%@",error);
            
        }];
    }

}


+ (void)alipayWithTotalAmount:(NSString *)total_amount outTradeNo:(NSString *)out_trade_no viewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from {
    
    if ([out_trade_no isEqualToString:@""]) {
        
    } else {
        
    }
    
    
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timestampStr = [formatter stringFromDate:[NSDate date]];
    
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        // 订单
//        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_orderPaySignWithAlipay,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd,
                               @"appVersion":@"1.0.0",
                               @"app_id":kAlipayAPPID,
                               @"timestamp":timestampStr,
                               @"version":@"1.0",
                               @"body":@"立木征信账户余额充值",
                               @"subject":@"立木征信账户余额充值",
                               @"timeout_express":@"30m",
                               @"total_amount":total_amount,
                               @"seller_id":kAlipaySellerID,
                               @"product_code":@"QUICK_MSECURITY_PAY",
                               @"out_trade_no":out_trade_no
                               };
        
        
        
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_orderPaySignWithAlipay] params:dict success:^(id responseObj) {
            
            MYLog(@"提交订单信息---%@",responseObj);
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                YJAlipayOrder* order = [YJAlipayOrder mj_objectWithKeyValues:responseObj[@"data"]];
                
                NSString *orderInfo = [order orderInfoEncoded:NO];
                NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
                
                MYLog(@"orderInfo = %@",orderInfo);
                MYLog(@"orderInfoEncoded = %@",orderInfoEncoded);
                
                NSString *signedString = [order encodeValue:order.sign];
                
                [[NSUserDefaults standardUserDefaults] setObject:order.bizcontent.out_trade_no forKey:@"Alipay_out_trade_no"];
                [[NSUserDefaults standardUserDefaults] setObject:order.bizcontent.total_amount forKey:@"Alipay_total_amount"];
                [[NSUserDefaults standardUserDefaults] setInteger:from forKey:@"Alipay_from"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                MYLog(@"后台signedString----%@",signedString);
                
                // NOTE: 如果加签成功，则继续执行支付
                if ( signedString!= nil) {
                    //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
                    NSString *appScheme = @"LIMUBEIDIAOAlipay";
                    
                    // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
                    NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                             orderInfoEncoded, signedString];
                    
                    // NOTE: 调用支付结果开始支付
                    __weak typeof(self) weakSelf = self;
                    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                        //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
                        
                        NSLog(@"callback - reslut = %@",resultDic);
                        
//                        int code = [[resultDic objectForKey:@"resultStatus"] intValue];
                        
                        [weakSelf dealAlipayResult:resultDic viewcontroller:vc from:from];
                        
                    }];
                }
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
                
            }
        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            MYLog(@"提交订单信息---%@",error);
            
        }];
    }
}


+ (void)alipayHandleResult:(NSURL *)url  viewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from {
    __weak typeof(self) weakSelf = self;
   
    // 支付跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        MYLog(@"支付结果result = %@",resultDic);
        
        
        [weakSelf dealAlipayResult:resultDic  viewcontroller:vc from:from];
    }];
}


#pragma mark -- 私有方法

/**
 *  处理支付宝返回的code
 *
 */
+ (void)dealAlipayResult:(NSDictionary *)resultDic viewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from  {
    NSString *messge = nil;
    
    int code = [[resultDic objectForKey:@"resultStatus"] intValue];

    if(code == 9000){
        messge = @"支付成功";
        
        // 1.同步通知验证
        // 支付宝公钥
         NSString* public_key_string = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB";
        NSString *result = [resultDic objectForKey:@"result"];
        NSString *tempStr1 = [result componentsSeparatedByString:@",\"sign\":\""][0];
        NSString *verifyString = [tempStr1 componentsSeparatedByString:@"alipay_trade_app_pay_response\":"][1] ;
        
        NSString *tempStr2 = [result componentsSeparatedByString:@",\"sign\":\""][1] ;
        NSString *signString = [tempStr2 componentsSeparatedByString:@"\",\"sign_type\":"][0];
        
        
        MYLog(@"verifyString-------:%@",verifyString);
        MYLog(@"signString-------:%@",signString);
        id<DataVerifier> signer = CreateRSADataVerifier(public_key_string);
        
        BOOL isSign = [signer verifyString:verifyString withSign:signString];
        
        MYLog(@"同步验签--------:%d",isSign);
        
        if (isSign) { // 同步验签成功
            
             // 2.校验通知参数的合法性
            NSString *outTradeNo = [[NSUserDefaults standardUserDefaults] objectForKey:@"Alipay_out_trade_no"];
            NSString *total_amount = [[NSUserDefaults standardUserDefaults] objectForKey:@"Alipay_total_amount"];
            
            if ([result hasStr:outTradeNo] && [result hasStr:total_amount] && [result hasStr:kAlipayAPPID] && [result hasStr:kAlipaySellerID]) {
                
                
                //  检查订单状态 用于统计。以及后台支付
                [self checkAlipayOrderStatusViewcontroller:vc from:from];
                
                //解决体验：闪一下支付前的页面
                // 3.校验通过，进入成功页面
                if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay:"]]) {
                    //            YJRechargeSuccessVC *successVC = [[YJRechargeSuccessVC alloc] init];
                    //            successVC.from = from;
                    //            [vc.navigationController pushViewController:successVC animated:YES];
                    //            [self alertWithMessage:messge  viewcontroller:vc];
                    [[NSNotificationCenter defaultCenter] postNotificationName:YJNotificationPaySuccessALi object:nil];
                } else {
                    
                    YJRechargeSuccessVC *successVC = [[YJRechargeSuccessVC alloc] init];
                    successVC.from = from;
                    [vc.navigationController pushViewController:successVC animated:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:YJNotificationPaySuccess object:nil];
                }
                
            }

        }

        return;

        
    }else if (code == 8000){
        messge = AWPayIng ;
        
    }else if (code == 4000){
        messge = AWPayFail;
        
    }else if (code == 6001){
        messge = AWPayCancel;
        [[NSNotificationCenter defaultCenter] postNotificationName:appWillResignActiveJ object:@"1"];
    }else if (code == 6002){
        messge = AWPayNetDeny;
    }
    [self alertWithMessage:messge  viewcontroller:vc];
}

+ (void)alertWithMessage:(NSString *)message  viewcontroller:(UIViewController *)vc {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVc addAction:action];
    [vc presentViewController:alertVc animated:YES completion:nil];
}


/**
 *  确认订单状态
 */

+ (void)checkAlipayOrderStatusViewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from   {
    
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        // 订单
//        __weak typeof(self) weakSelf = self;
        
        // 对订单号加密
        NSString *outTradeNo = [[NSUserDefaults standardUserDefaults] objectForKey:@"Alipay_out_trade_no"];
        HBRSAHandler* handler = [HBRSAHandler new];
        [handler importKeyWithType:KeyTypePublic andkeyString:kPublicKey];
        outTradeNo = [handler encryptWithPublicKey:outTradeNo];

        NSDictionary *dict = @{@"method" : urlJK_checkOrderPayStatusWithAlipay,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd,
                               @"appVersion":@"1.0.0",
                               @"app_id":kAlipayAPPID,
                               @"outTradeNo":outTradeNo,
                               @"payType" : @"2"
                               };
        
        
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_checkOrderPayStatusWithAlipay] params:dict success:^(id responseObj) {
            
            MYLog(@"支付宝确认订单状态---%@",responseObj);
//            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            
                if ([responseObj[@"code"] isEqualToString:@"0000"]) {
                    [TalkingData trackEvent:@"充值成功" label:@"支付宝"];
                    MYLog(@"-------支付宝确认订单状态成功");
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                    });
                }
 
//            }
            
        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            MYLog(@"确认订单状态error---%@",error);
            
        }];
        
    }
}

@end
