//
//  AppDelegate+WeChatPay.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "WeChatPayManager.h"
#import "WeChatOrder.h"
#import "YJRechargeSuccessVC.h"


/**  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
 */
NSString * const WXAppId = @"wxa0ed6e0e4e61b9a8";

/**  微信开放平台和商户约定的密钥 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXAppSecret = @"3eb454c77700ed28a55e6a0e54e281f6";

/**  API key */
NSString * const WXAPIKey = @"38dceaf4592711e6879018a9054689bc";

/** 微信开放平台和商户约定的支付密钥   注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXAppKey = @" ";

/** 微信开放平台和商户约定的支付密钥   注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXPartnerKey = @" ";

/** 微信商户号
 */
NSString * const WXPartnerId = @"1386049002";

// 订单号
NSString * const AppPayOrderID;
@implementation WeChatPayManager
{
    WeChatOrder *order_;
    UIViewController *fromVC_;
    YJAlipayFrom fromCode_;
}
#pragma mark  初始化
+ (instancetype)shareWeChatPay {
    static WeChatPayManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (!manager) {
            manager = [[WeChatPayManager alloc] init];
        }
    });
    
    return manager;
}
#pragma mark  注册 微信
- (BOOL)applicationDidFinishLaunchingAndBeginWechatPay{
    // 向微信终端程序注册第三方应用
    [WXApi registerApp:WXAppId withDescription:@"CreditPlatform"];
    
    return YES;
}
#pragma mark   下单支付
- (void)weChatWithTotalAmount:(NSString *)total_amount outTradeNo:(NSString *)out_trade_no viewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from {
//   __block BOOL success;
    fromVC_ = vc;
    fromCode_ = from;
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        // 订单
        if (!out_trade_no) {
            out_trade_no = @"";
        }
        //        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_orderPaySignWithWeiXinPay,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd,
                               @"appVersion":VERSION_APP_1_3_0,
                               
                               @"total_amount":total_amount,//金额
                               @"out_trade_no":out_trade_no //订单号
                               };
        
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_orderPaySignWithWeiXinPay] params:dict success:^(id obj) {
            
            MYLog(@"提交订单信息---%@",obj);
            if (![obj[@"data"] isKindOfClass:[NSNull class]]) {
                if (obj[@"data"][@"appid"]) {
                    NSArray *arr = obj[@"list"];
                    if (arr.firstObject) {
                        [Tool setObject:arr.firstObject forKey:WeChatAppPayOrderListDetail];
                    }else{
                        [Tool setObject:@"" forKey:WeChatAppPayOrderListDetail];
                    }
                    
                    order_ = [WeChatOrder mj_objectWithKeyValues:obj[@"data"]];
                    
                    //需要创建这个支付对象
                    PayReq *req = [[PayReq alloc] init];
                    // 应用id 固定的
                    req.openID = order_.appid;
                    // 商家商户号 固定的
                    req.partnerId = order_.partnerid;
                    
                    req.prepayId =order_.prepayid;
                    // 根据财付通文档填写的数据和签名   这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
                    req.package = @"Sign=WXPay";
                    // 随机编码，为了防止重复的，在后台生成
                    req.nonceStr = order_.noncestr;
                    // 这个是时间戳，也是在后台生成的，为了验证支付的 UInt32
                    req.timeStamp = (UInt32)order_.timestamp.integerValue;
                    // 这个签名也是后台做的
                    req.sign =order_.sign;
                    //发送请求到微信，等待微信返回onResp
                    
                    //调起微信支付
                    if ([WXApi sendReq:req]) {
                        if (self.wxPay) {
                            self.wxPay(@"1");
                        }
                        
                        MYLog(@"成功调用微信");
                    }else{
                        if (self.wxPay) {
                            self.wxPay(@"4");}
                        MYLog(@"没有调用微信");
                    }
//                    success =  YES;
                    
                }
                
                
            }
            
        } failure:^(NSError *error) {
            MYLog(@"提交订单信息---%@",error);
//            success = NO;
        }];
    }
    
//    return success;
}
#pragma mark - 微信支付结果回调
- (void)onResp:(BaseResp *)resp{
    NSString *messge=nil;
    if ([resp isKindOfClass:[PayResp class]]){ //微信支付回调
        PayResp *response = (PayResp *)resp;
        if (response.errCode == WXSuccess) {
            if (self.wxPay) {
                self.wxPay(@"2");
            }
        }else{
            if (self.wxPay) {
                self.wxPay(@"3");
            }
            
        }
        switch (response.errCode) {
            case WXSuccess:{//支付成功的回调
                YJRechargeSuccessVC *successVC = [[YJRechargeSuccessVC alloc] init];
                successVC.from = fromCode_;
                [fromVC_.navigationController pushViewController:successVC animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:YJNotificationPaySuccess object:nil];
                
//                // 检查订单状态 用于统计。以及后台支付
                [self checkAlipayOrderStatusViewcontroller:fromVC_ from:fromCode_];
//                // 回调结果
                
            }
                break;
            case WXErrCodeUserCancel:{//支付取消的提醒
                messge = AWPayCancel;
            }
                break;
            case WXErrCodeCommon:{ //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                messge = AWPayFail;
            }
            break;
            case WXErrCodeSentFail:{ //发送失败
                messge = AWPayFail;
            }
            break;
            case WXErrCodeUnsupport:{ //微信不支持
                messge = AWPayUnSupportWX;
            }
            break;
            case WXErrCodeAuthDeny:{ //授权失败
                messge = AWPayAuthDeny;
            }
            break;
            default:{//支付失败的回调
                if (self.delegateWeChat&&[self.delegateWeChat respondsToSelector:@selector(WeChatPayFail)]){
                    [self.delegateWeChat WeChatPayFail];
                }
            }
               break;
        }
    }else if ([resp isKindOfClass:[SendAuthResp class]]){//微信登录回调
        
    }else if([resp isKindOfClass:[SendMessageToWXResp class]]){//微信分享回调
        
    }
    if (messge) {
        [self alertWithMessage:messge viewController:fromVC_];
    }
}
    
- (void)alertWithMessage:(NSString *)message viewController:(UIViewController *)vc {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVc addAction:action];
    [vc presentViewController:alertVc animated:YES completion:nil];
}
    

#pragma mark 自定义 后台订单状态查询
- (void)checkAlipayOrderStatusViewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from  {
    
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        // 订单
//        __weak typeof(self) sself = self;
        
        // 对订单号加密
        NSString *outTradeNo = [Tool objectForKey:WeChatAppPayOrderListDetail];
        HBRSAHandler* handler = [HBRSAHandler new];
        [handler importKeyWithType:KeyTypePublic andkeyString:kPublicKey];
        outTradeNo = [handler encryptWithPublicKey:outTradeNo];
        
        NSDictionary *dict = @{@"method" : urlJK_checkOrderPayStatusWithAlipay,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd,
                               @"appVersion":VERSION_APP_1_3_0,
                               @"outTradeNo":outTradeNo,
                               @"payType" : @"1"};
        
        MYLog(@"WWW:%@",dict);
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_checkOrderPayStatusWithAlipay] params:dict success:^(id responseObj) {
            
            MYLog(@"支付宝确认订单状态---%@",responseObj);
            if ([responseObj[@"code"] isEqualToString:@"0000"]) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
                         [TalkingData trackEvent:@"充值成功" label:@"微信"];
                        
//                        YJRechargeSuccessVC *successVC = [[YJRechargeSuccessVC alloc] init];
//                        successVC.from = from;
//                        [vc.navigationController pushViewController:successVC animated:YES];
//                        [[NSNotificationCenter defaultCenter] postNotificationName:YJNotificationPaySuccess object:nil];
                        
//                    });
            }else if ([responseObj[@"code"] isEqualToString:@"9999"]){
                
            }
            
            
       } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            MYLog(@"确认订单状态error---%@",error);
            
        }];
        
    }
}
    
    
    
#pragma mark  -  微信系统回调
    
-(NSInteger)isInstallWeChat{
    if (![WXApi isWXAppInstalled]) {
        MYLog(@"该设备没有安装微信");
        return 1;
    }
    if (![WXApi isWXAppSupportApi]) {
        MYLog(@"该设备不支持微信");
        return 2;
    }
    return 3;
}
    
+ (BOOL)sendAuthReq:(SendAuthReq*)req viewController:(UIViewController*)viewController delegate:(id<WXApiDelegate>)delegate{
    return YES;
}
-(void)onReq:(BaseReq *)req{
    MYLog(@"onReq:(BaseReq *)req");
}
-(void)initwith:(id)ID{
    fromVC_ = ID;
}


// 下单
- (void)weChatWithTotalAmount:(NSString *)total_amount outTradeNo:(NSString *)out_trade_no viewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from  creatAlipayOrder:(WeChatPayOrder)weChatPayOrder {
    
    fromVC_ = vc;
    fromCode_ = from;
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        // 订单
        if (!out_trade_no) {
            out_trade_no = @"";
        }
        //        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_orderPaySignWithWeiXinPay,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd,
                               @"appVersion":VERSION_APP_1_3_0,
                               @"total_amount":total_amount,//金额
                               @"out_trade_no":out_trade_no //订单号
                               };
        
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_orderPaySignWithWeiXinPay] params:dict success:^(id obj) {
            
            MYLog(@"提交订单信息---%@",obj);
            if (![obj[@"data"] isKindOfClass:[NSNull class]]) {
                if (obj[@"data"][@"appid"]) {
                    NSArray *arr = obj[@"list"];
                    if (arr.firstObject) {
                        [Tool setObject:arr.firstObject forKey:WeChatAppPayOrderListDetail];
                    }else{
                        [Tool setObject:@"" forKey:WeChatAppPayOrderListDetail];
                    }
                    
                    if (weChatPayOrder) {
                        weChatPayOrder(arr.firstObject);
                    }
                    
                    order_ = [WeChatOrder mj_objectWithKeyValues:obj[@"data"]];
                    
                    //需要创建这个支付对象
                    PayReq *req = [[PayReq alloc] init];
                    // 应用id 固定的
                    req.openID = order_.appid;
                    // 商家商户号 固定的
                    req.partnerId = order_.partnerid;
                    
                    req.prepayId =order_.prepayid;
                    // 根据财付通文档填写的数据和签名   这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
                    req.package = @"Sign=WXPay";
                    // 随机编码，为了防止重复的，在后台生成
                    req.nonceStr = order_.noncestr;
                    // 这个是时间戳，也是在后台生成的，为了验证支付的 UInt32
                    req.timeStamp = (UInt32)order_.timestamp.integerValue;
                    // 这个签名也是后台做的
                    req.sign =order_.sign;
                    //发送请求到微信，等待微信返回onResp
                    
                    //调起微信支付
                    if ([WXApi sendReq:req]) {
                        if (self.wxPay) {
                            self.wxPay(@"1");
                        }
                        
                        MYLog(@"成功调用微信");
                    }else{
                        if (self.wxPay) {
                            self.wxPay(@"4");}
                        MYLog(@"没有调用微信");
                    }
                    //                    success =  YES;
                    
                }
                
                
            }
            
        } failure:^(NSError *error) {
            MYLog(@"提交订单信息---%@",error);
            //            success = NO;
        }];
    }

    
    
    
}

    
@end







