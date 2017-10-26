//
//  PurchaseHistoryModel.h
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/9/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
/*
 *
 *          ┌─┐       ┌─┐
 *       ┌──┘ ┴───────┘ ┴──┐
 *       │                 │
 *       │       ───       │
 *       │  ─┬┘       └┬─  │
 *       │                 │
 *       │       ─┴─       │
 *       │                 │
 *       └───┐         ┌───┘
 *           │         │
 *           │         │
 *           │         │
 *           │         └──────────────┐
 *           │                        │
 *           │                        ├─┐
 *           │                        ┌─┘
 *           │                        │
 *           └─┐  ┐  ┌───────┬──┐  ┌──┘
 *             │ ─┤ ─┤       │ ─┤ ─┤
 *             └──┴──┘       └──┴──┘
 *                 神兽保佑
 *                 代码无BUG!
 */


#import <Foundation/Foundation.h>

@interface PurchaseHistoryModel : NSObject

@property (copy,nonatomic) NSString      *consuTime ; //消费时间
// 1支付宝 2微信 3红包 4银行卡
@property (copy,nonatomic) NSString      *serviceType  ; //消费类别 代号
@property (copy,nonatomic) NSString      *serviceName; //消费类别 名称
@property (copy,nonatomic) NSString      *id ; //
@property (copy,nonatomic) NSString      *consuAmt ; //交易金额
@property (copy,nonatomic) NSString      *consuStatus ; //交易状态
@property (copy,nonatomic) NSString      *serialNo ; //流水号

/**
 子账号ID 非空 非0
 */
@property (copy,nonatomic) NSString      *userOperatorId ;
/**
 子账号名称
 */
@property (copy,nonatomic) NSString      *userOperatorName ;


/*
 id = c748edfcb89b42749d7b500e0016152d,
	mobile = <null>,
	createDate = 1473747023000,
	consuTime = 1473747023000,
	channel = APP,
	consuStatus = 00,
	serialNo = 20160913141023000000000221272029,
	userId = db62e25b30dd4592b0b8519f35bbe3a2,
	token = a8f46d6171c04240bb2547604a42589b,
	consuAmt = 5,
	updateDate = 1473747024000,
	serviceType = jd,
	remark = jd消费,
	serviceName = 京东查询,
	channelStr =
 **/

@end

// 外部
@class PurchaseHistoryInsort;
@interface PurchaseHistoryOutModel : NSObject
@property (copy,nonatomic) NSString      *code;
@property (copy,nonatomic) NSString      *msg ;
@property (copy,nonatomic) NSArray      *list ;
@property (copy,nonatomic) NSDictionary  *data ;
@property (strong,nonatomic) PurchaseHistoryInsort *allCost;
@end

@interface PurchaseHistoryInsort : NSObject
/**
 maimai					 脉脉查询接口
 linkedin                领英查询接口
 taobao                  淘宝查询接口
 mobile                  手机查询接口
 credit                  央行征信查询
 housefund               公积金查询
 jd                      京东查询
 socialsecurity          社保查询
 education               学历查询
 */
@property (copy,nonatomic) NSString      *consuCount;
@property (copy,nonatomic) NSString      *consuAllAmt;
@end












