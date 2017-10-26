//
//  WeChatOrder.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/20.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeChatOrder : NSObject

/**应用ID*/
@property (nonatomic, copy) NSString *appid;
/**商户号*/
@property (nonatomic, copy) NSString *partnerid;
/**预支付交易会话ID*/
@property (nonatomic, copy) NSString *prepayid;
/**扩展字段*/
@property (nonatomic, copy) NSString *package;
/**随机字符串*/
@property (nonatomic, copy) NSString *noncestr;
/**时间戳*/
@property (nonatomic, copy) NSString *timestamp;
/**签名*/
@property (nonatomic, copy) NSString *sign;

@end

//appid = wxa0ed6e0e4e61b9a8;
//noncestr = 3ZrVjCFlgFEB2ZDr;
//package = "Sign=WXPay";
//partnerid = 1386049002;
//prepayid = wx201609201800008fdafa95d30223311867;
//sign = 9B35254FE19C7A90C81A9D35B0D35866;
//timestamp = 1474365601;


//		String(32)	是	wx8888888888888888	微信开放平台审核通过的应用APPID
//		String(32)	是	1900000109	微信支付分配的商户号
//		String(32)	是	WX1217752501201407033233368018	微信返回的支付交易会话ID
//		String(128)	是	Sign=WXPay	暂填写固定值Sign=WXPay
//		String(32)	是	5K8264ILTKCH16CQ2502SI8ZNMTM67VS	随机字符串，不长于32位。推荐随机数生成算法
//		String(10)	是	1412000000	时间戳，请见接口规则-参数规定
//		String(32)	是	C380BEC2BFD727A4B6845133519F3AD6	签名，详见签名生成算法
