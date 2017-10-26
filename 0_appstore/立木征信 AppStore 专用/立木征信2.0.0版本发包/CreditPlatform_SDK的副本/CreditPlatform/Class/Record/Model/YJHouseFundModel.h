//
//  YJHouseFundModel.h
//  CreditPlatform
//
//  Created by yj on 16/8/3.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJBaseSearchDataModel.h"
/************** 存缴信息 **************/
@interface YJHouseFundDetails : NSObject
/**
 *  单位名称
 */
@property (nonatomic, copy) NSString *corpName;
/**
 *  业务描述
 */
@property (nonatomic, copy) NSString *bizDesc;
/**
 *  日期
 */
@property (nonatomic, copy) NSString *accDate;
/**
 *  缴费年月
 */
@property (nonatomic, copy) NSString *payMonth;

/**
 *  缴存基数
 */
@property (nonatomic, copy) NSString *baseDeposit;
/**
 *  金额
 */
@property (nonatomic, copy) NSString *amt;
/**
 *  余额
 */
@property (nonatomic, copy) NSString *bal;

@end


/************** 贷款信息 **************/
@interface YJLoadInfo : NSObject
/**
 *  贷款账号
 */
@property (nonatomic, copy) NSString *loadAccNo;
/**
 *  贷款余额
 */
@property (nonatomic, copy) NSString *loadBal;
/**
 *  末次还款年月
 */
@property (nonatomic, copy) NSString *lastPaymentDate;
/**
 *  贷款总额
 */
@property (nonatomic, copy) NSString *loadAll;
/**
 *  开户日期
 */
@property (nonatomic, copy) NSString *openDate;
/**
 *  贷款状态
 */
@property (nonatomic, copy) NSString *loadStatus;
/**
 *  还款方式
 */
@property (nonatomic, copy) NSString *paymentMethod;
/**
 *  贷款期限
 */
@property (nonatomic, copy) NSString *loadLimit;

@end



/************** 公积金模型 **************/
@interface YJHouseFundModel : YJBaseSearchDataModel


/**
 *  公积金账号
 */
@property (nonatomic, copy) NSString *acctNo;


/**
 *  月缴存
 */
@property (nonatomic, copy) NSString *monthlyDeposit;
/**
 *  账户余额
 */
@property (nonatomic, copy) NSString *bal;
/**
 *  缴存基数
 */
@property (nonatomic, copy) NSString *baseDeposit;

/**
 *  末次缴存年月
 */
@property (nonatomic, copy) NSString *lastDepostDate;


/**
 *  存缴信息
 */
@property (nonatomic, strong) NSArray *details;

/**
 *  贷款信息
 */
@property (nonatomic, strong) NSDictionary *loadInfo;

@property (nonatomic, strong) YJLoadInfo *loadMsg;
@end
