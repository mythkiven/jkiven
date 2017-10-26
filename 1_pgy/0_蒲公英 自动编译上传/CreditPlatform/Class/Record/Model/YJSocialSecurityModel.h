//
//  YJSocialSecurityModel.h
//  CreditPlatform
//
//  Created by yj on 16/8/3.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJBaseSearchDataModel.h"
/***********社保险种信息*************/
@interface YJInsurances : NSObject
/**
 *  险种类型  1：养老2：医疗 3：失业 4：工伤 5：生育
 */
@property (nonatomic, copy) NSString *insuranceType;

/**
 *  账户余额
 */
@property (nonatomic, copy) NSString *bal;
/**
 *  累计缴纳月数
 */
@property (nonatomic, copy) NSString *sumPayMonth;
/**
 *  余额截止年月
 */
@property (nonatomic, copy) NSString *dueToMonth;
/**
 *  账号状态
 */
@property (nonatomic, copy) NSString *accStatus;
@end


/***********五险信息*************/
@interface YJBaseInsurance : NSObject
/**
 *  日期
 */
@property (nonatomic, copy) NSString *accDate;

/**
 *  单位名称
 */
@property (nonatomic, copy) NSString *corpName;
/**
 *  缴费金额
 */
@property (nonatomic, copy) NSString *amt;
/**
 *  缴存基数
 */
@property (nonatomic, copy) NSString *baseDeposit;
/**
 *  缴费年月
 */
@property (nonatomic, copy) NSString *payMonth;
/**
 *  业务描述
 */
@property (nonatomic, copy) NSString *bizDesc;



@end




/***********《社保模型数据》*************/
@interface YJSocialSecurityModel : YJBaseSearchDataModel

/**
 *  社保险种信息
 */
@property (nonatomic, strong) NSArray *insurances;


/**
 *  养老明细信息
 */
@property (nonatomic, strong) NSArray *pensionDetails;

/**
 *  医疗明细信息
 */
@property (nonatomic, strong) NSArray *medicareDetails;

/**
 *  失业明细信息
 */
@property (nonatomic, strong) NSArray *jobSecurityDetails;

/**
 *  工伤明细信息
 */
@property (nonatomic, strong) NSArray *employmentInjuryDetails;

/**
 *  生育明细信息
 */
@property (nonatomic, strong) NSArray *maternityDetails;





@end
