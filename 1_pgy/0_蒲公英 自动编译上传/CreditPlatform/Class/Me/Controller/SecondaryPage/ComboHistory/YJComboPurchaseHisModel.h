//
//  YJComboPurchaseHisModel.h
//  CreditPlatform
//
//  Created by yj on 2016/10/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
/**套餐消费统计模型*/
@interface YJComboPurchaseData : NSObject
/**
 消费笔数
 */
@property (nonatomic, copy) NSString *consuCount;
/**
 消费金额
 */
@property (nonatomic, copy) NSString *consuAmt;
///**
// 总记录数
// */
//@property (nonatomic, copy) NSString *totalCount;
/**
 查询时间节点（加载第二页之后的页码时传参数）
 */
@property (nonatomic, copy) NSString *spileTime;
@end

/**list列表*/
@interface YJComboPurchaseList : NSObject
/**
 消费时间
 */
@property (nonatomic, copy) NSString *consuDate;
/**
 消费时间
 */
@property (nonatomic, copy) NSString *consuDateStr;
/**
 名称
 */
@property (nonatomic, copy) NSString *servicePackageName;


@property (nonatomic, copy) NSString *servicePackageId;
@property (nonatomic, copy) NSString *servicePackageType;

/**
 序号
 */
@property (nonatomic, copy) NSString *packageSerialNo;
/**
 金额(元)
 */
@property (nonatomic, copy) NSString *amt;
/**
 出账时间
 */
@property (nonatomic, copy) NSString *createDate;
/**
 状态
 */
@property (nonatomic, copy) NSString *settleStatus;
/**
 账单id
 */
@property (nonatomic, copy) NSString *id;

@end


/**套餐模型*/
@interface YJComboPurchaseHisModel : NSObject
/**
 消费统计字典
 */
@property (nonatomic, strong) NSDictionary *data;

/**
 消费统计模型
 */
@property (nonatomic, strong) YJComboPurchaseData *comboPurchaseData;

/**
 列表
 */
@property (nonatomic, strong) NSArray *list;

@end

