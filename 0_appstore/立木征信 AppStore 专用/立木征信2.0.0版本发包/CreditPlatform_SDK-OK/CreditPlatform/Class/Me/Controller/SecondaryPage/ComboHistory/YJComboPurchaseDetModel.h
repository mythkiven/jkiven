//
//  YJComboPurchaseDetModel.h
//  CreditPlatform
//
//  Created by yj on 2016/10/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJComboPurchaseItem : NSObject
/**
标题
 */
@property (nonatomic, copy) NSString *packageTitle ;
/**
 标题对应的统
 */
@property (nonatomic, copy) NSString *packageCount;

@end

@interface YJComboPurchaseDetRow : NSObject
/**
 账单号
 */
@property (nonatomic, copy) NSString *identityCardNo;
/**
 金额
 */
@property (nonatomic, copy) NSString *amt ;
/**
 消费类型及金额
 */
@property (nonatomic, strong) NSArray *statisMap ;

@end

@interface YJComboPurchaseDetModel : NSObject

/**
 账单号
 */
@property (nonatomic, copy) NSString *packageSerialNo;
/**
 消费时间
 */
@property (nonatomic, copy) NSString *consuDate;
/**
 套餐名称
 */
@property (nonatomic, copy) NSString *servicePackageName;
/**
 账单状态
 */
@property (nonatomic, copy) NSString *settleStatus;
/**
 账单id
 */
@property (nonatomic, copy) NSString *packConsuId;
/**
 时间节点
 */
@property (nonatomic, copy) NSString *spileTime;
/**
 出账时间（时分秒）
 */
@property (nonatomic, copy) NSString *createDate ;
/**
 总金额
 */
@property (nonatomic, copy) NSString *amt ;

/**
 消费类型及金额
 */
@property (nonatomic, strong) NSArray *rows;

@end
