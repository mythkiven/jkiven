//
//  OperationModel.h
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/8/3.
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



@interface OperationMainModel : NSObject
/** 基本信息 */
@property (copy,nonatomic) NSArray * basicInfo;
/** 上网 */
@property (copy,nonatomic) NSArray * netInfo;
/** 通话记录 */
@property (copy,nonatomic) NSArray * callRecordInfo;
/** 业务 */
@property (copy,nonatomic) NSArray * businessInfo;
/**  前十通话 */
@property (copy,nonatomic) NSArray * stati;
/** 账单 */
@property (copy,nonatomic) NSArray * bill;
/** 短信 */
@property (copy,nonatomic) NSArray * smsInfo;
@property (copy,nonatomic) NSString *code;
@property (copy,nonatomic) NSString *msg;
@property (copy,nonatomic) NSString *realName;
@property (copy,nonatomic) NSString *token;
@end

/** 基本信息 */
@interface OperationModel : NSObject
@property (copy,nonatomic) NSString *realName;//姓名
@property (copy,nonatomic) NSString *mobileNo;//本机号
@property (copy,nonatomic) NSString *registerDate;//入网时间
@property (copy,nonatomic) NSString *idCard;//身份证号码
@property (copy,nonatomic) NSString *address;//地址
@property (copy,nonatomic) NSString *vipLevelstr;//星级
@property (copy,nonatomic) NSString *email;//邮件
@property (copy,nonatomic) NSString *pointsValuestr;//可用积分
@property (copy,nonatomic) NSString *amount;//可用余额





@end

/** 6个月通话 */
@interface OperationCallSix : NSObject

@property (copy,nonatomic) NSString *callAddress;//通话地点
@property (copy,nonatomic) NSString *callDateTime;//通话时间
@property (copy,nonatomic) NSString *callTimeLength;//时长
@property (copy,nonatomic) NSString *callType;//类型
@property (copy,nonatomic) NSString *mobileNo;//通话号码
@end


/** 前10次通话 */
@interface OperationCallTen : NSObject
@property (copy,nonatomic) NSString *mobileNo;//手机号
@property (copy,nonatomic) NSString *callCount;//次数

@end


/** 6个月账单 */
@interface OperationBillSix : NSObject
@property (copy,nonatomic) NSString *mobileNo;//本机号
@property (copy,nonatomic) NSString *startTime;//月
@property (copy,nonatomic) NSString *comboCost;//套餐消费
@property (copy,nonatomic) NSString *sumCost;//总金额
@property (copy,nonatomic) NSString *realCost;//实际费用

@end

/** 6个月短信 */
@interface OperationMessageSix : NSObject
@property (copy,nonatomic) NSString *mobileNo;// 本机
@property (copy,nonatomic) NSString *sendSmsToTelCode;//号码
@property (copy,nonatomic) NSString *sendSmsAddress;//发送地
@property (copy,nonatomic) NSString *sendSmsTime;//发送时间
@property (copy,nonatomic) NSString *sendType;//发送类型

@end


/** 6个月上网 */
@interface OperationNetworkSix : NSObject
@property (copy,nonatomic) NSString *mobileNo;//本机
@property (copy,nonatomic) NSString *place;//地点
@property (copy,nonatomic) NSString *netTime;//时间
@property (copy,nonatomic) NSString *onlineTime;//在线时长
@property (copy,nonatomic) NSString *netType;//上网类型

@end


/** 6个月办理业务 */
@interface OperationBanliSix : NSObject
@property (copy,nonatomic) NSString *mobileNo;//本机
@property (copy,nonatomic) NSString *businessName;//业务类型
@property (copy,nonatomic) NSString *beginTime;//开始时间
@property (copy,nonatomic) NSString *cost;//消费

@end





















