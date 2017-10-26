//
//  YJPurchaseHistoryModel.h
//  CreditPlatform
//
//  Created by yj on 2017/5/18.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJPageBaseModel.h"
@interface YJPurchaseHistoryListModel : NSObject

/**
 消费时间
 */
@property (nonatomic, copy) NSString *consuTimeStr;

/**
 消费时间
 */
@property (nonatomic, copy) NSString *consuTime;

/**
 服务名称
 */
@property (nonatomic, copy) NSString *serviceType;
/**
 服务名称
 */
@property (nonatomic, copy) NSString *serviceName;

/**
 用户id
 */
@property (nonatomic, copy) NSString *ID;

/**
 消费金额
 */
@property (nonatomic, copy) NSString *consuAmt;

/**
 交易状态
 */
@property (nonatomic, copy) NSString *consuStatus;

/**
 子账户
 */
@property (nonatomic, copy) NSString *userOperatorId;

/**
 子账户名称
 */
@property (nonatomic, copy) NSString *userOperatorName;
/**
 流水号
 */
@property (copy,nonatomic) NSString      *serialNo ;


@end


@interface YJPurchaseHistoryPageModel : YJPageBaseModel

@end

@interface YJPurchaseHistoryModel : NSObject

/**
 消费记录数
 */
@property (nonatomic, copy) NSString *consuCount;

/**
 总消费金额
 */
@property (nonatomic, copy) NSString *consuAllAmt;

/**
 分页详情
 */
@property (nonatomic, strong) NSDictionary *page;
/**
 分页详情模型
 */
@property (nonatomic, strong) YJPurchaseHistoryPageModel *pageModel;

@end

