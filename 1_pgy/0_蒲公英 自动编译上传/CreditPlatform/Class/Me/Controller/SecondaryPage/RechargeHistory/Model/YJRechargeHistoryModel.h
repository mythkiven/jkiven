//
//  YJRechargeHistoryModel.h
//  CreditPlatform
//
//  Created by yj on 2017/5/18.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJPageBaseModel.h"
@interface YJRechargeHistoryListModel : NSObject
@property (copy,nonatomic) NSString      *id ; //id.用于定位订单
@property (copy,nonatomic) NSString      *rechangeDate; //消费时间
@property (copy,nonatomic) NSString      *rechangeDateStr;
// 2支付宝 1微信 3红包 4银行卡
@property (copy,nonatomic) NSString      *rechangeType ; //充值类别 代号
@property (copy,nonatomic) NSString      *rechangeTypeName; //充值类别 名称
@property (copy,nonatomic) NSString      *serialNo ; //流水号
@property (copy,nonatomic) NSString      *rechangeAmt; //充值金额
@property (copy,nonatomic) NSString      *rechangeState; //充值状态 0 失败 1 赛支付 2 OK
@property (copy,nonatomic) NSString      *rechangeStateStr;//状态名字

@end

@interface YJRechargeHistoryPageModel : YJPageBaseModel

@end

@interface YJRechargeHistoryModel : NSObject

/**
 充值总金额
 */
@property (nonatomic, copy) NSString *rechargeAllAmt;

/**
 充值数量
 */
@property (nonatomic, copy) NSString *rechargeCount;

/**
 分页数据
 */
@property (nonatomic, strong) NSDictionary *page;

/**
 分页模型
 */
@property (nonatomic, strong) YJRechargeHistoryPageModel *pageModel;


@end
