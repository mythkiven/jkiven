//
//  AppDelegate+WeChatPay.h
//  CreditPlatform
//
//  Created by gyjrong on 16/8/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
//支付结果回调
// 4打开微信失败 1 下单调用SDK成功 2 支付成功  3 支付失败
typedef void(^WXPay)(id);

//typedef void(^SuccessPrePay)(PayReq*);

// 微信支付逻辑
@protocol WeChatSuccessDelegate <NSObject>
- (void)LoginWeChatSuccessDic:(NSDictionary *)dic;
- (void)WeChatPaySuccess;
- (void)WeChatPayFail;

//-(void) onReqWX:(BaseReq*)req;
//
//-(void) onRespWX:(BaseResp*)resp;

@end


typedef void(^WeChatPayOrder)(NSString *out_trade_no);

@interface WeChatPayManager : NSObject  <WXApiDelegate>
// 4打开微信失败 1 下单调用SDK成功 2 支付成功  3 支付失败
@property (strong,nonatomic) WXPay   wxPay;
@property (weak, nonatomic) id <WeChatSuccessDelegate> delegateWeChat;
// 初始化
+(instancetype)shareWeChatPay;
// 微信注册
-(BOOL)applicationDidFinishLaunchingAndBeginWechatPay;
// 是否安装微信 1:没安装 2不支持打开 3OK的
-(NSInteger)isInstallWeChat;

// 下单
- (void)weChatWithTotalAmount:(NSString *)total_amount outTradeNo:(NSString *)out_trade_no viewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from;

// 下单
- (void)weChatWithTotalAmount:(NSString *)total_amount outTradeNo:(NSString *)out_trade_no viewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from  creatAlipayOrder:(WeChatPayOrder)weChatPayOrder;

////已经获取到微信支付信息
//- (void)weChatWithTotalAmount:(NSString *)total_amount outTradeNo:(NSString *)out_trade_no;
//- (BOOL)weChatPayWith:(PayReq*)req ViewController:(UIViewController *)vc from:(YJAlipayFrom)from;

///**
// *  处理支付结果
// *
// */
//+ (void)weChatHandleResult:(NSURL *)url  viewcontroller:(UIViewController *)vc from:(YJAlipayFrom)from;
//

    


@end
