//
//  RechargeHistoryModel.h
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

@interface RechargeHistoryModel : NSObject
@property (copy,nonatomic) NSString      *id ; //id.用于定位订单
@property (copy,nonatomic) NSString      *rechangeDate; //消费时间
// 2支付宝 1微信 3红包 4银行卡
@property (copy,nonatomic) NSString      *rechangeType ; //充值类别 代号
@property (copy,nonatomic) NSString      *rechangeTypeName; //充值类别 名称
@property (copy,nonatomic) NSString      *serialNo ; //流水号
@property (copy,nonatomic) NSString      *rechangeAmt; //充值金额
@property (copy,nonatomic) NSString      *rechangeState; //充值状态 0 失败 1 赛支付 2 OK
@property (copy,nonatomic) NSString      *rechangeStateStr;//状态名字
/*
 id = 4747e374722a45cf9a80127e665ac25d,
	rechangeAmt = 7,
	mobile = <null>,
	createDate = 1473762098000,
	rechangeDate = 1473762098000,
	rechangeTypeName = 支付宝,
	serialNo = 160913000101980300,
	userId = db62e25b30dd4592b0b8519f35bbe3a2,
	remark = ,
	updateDate = 1473762098000,
	rechangeDateStr = 2016-09-13 18:21:38,
	rechangeState = 2,
	rechangeType = 2,
	status = <null>
 **/
@end

// 外部
@class RechargeHistoryInsort;
@interface RechargeHistoryOutModel : NSObject
@property (copy,nonatomic) NSString      *code;
@property (copy,nonatomic) NSString      *msg ;
@property (copy,nonatomic) NSArray       *list ;
@property (copy,nonatomic) NSString      *success;
@property (copy,nonatomic) NSDictionary  *data ;
@property (strong,nonatomic) RechargeHistoryInsort *allCost;
@end

@interface RechargeHistoryInsort : NSObject
@property (copy,nonatomic) NSString      *rechargeCount;
@property (copy,nonatomic) NSString      *rechargeAllAmt;
@end



