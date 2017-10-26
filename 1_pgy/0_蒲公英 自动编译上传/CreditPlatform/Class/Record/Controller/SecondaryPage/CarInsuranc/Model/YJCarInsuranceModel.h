//
//  YJCarInsuranceModel.h
//  CreditPlatform
//
//  Created by yj on 2016/11/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

/**************** 2.3车船税模型 **************/
@interface YJCarInsuranceVehicleVesselTax : NSObject
/**
 纳税人标识号
 */
@property (nonatomic, copy) NSString *taxpayerNo;
/**
 完税人凭证号
 */
@property (nonatomic, copy) NSString *vouchNo;
/**
 开具税务机关
 */
@property (nonatomic, copy) NSString *taxOffice;
/**
 整备质量
 */
@property (nonatomic, copy) NSString *curbWeight;
/**
 当年应缴
 */
@property (nonatomic, copy) NSString *payableAmt;
/**
 往年补缴
 */
@property (nonatomic, copy) NSString *supplementAmt;
/**
 滞纳金
 */
@property (nonatomic, copy) NSString *lateAmt;
/**
 减税金额
 */
@property (nonatomic, copy) NSString *cutAmt;
/**
 车船税合计
 */
@property (nonatomic, copy) NSString *taxSum;

/**
 费率浮动原因
 */
@property (nonatomic, copy) NSString *feeFloatCause;
@end

/**************** 2.2责任险种信息模型 **************/
@interface YJCarInsuranceInsurance : NSObject
/**
 险种编号
 */
@property (nonatomic, copy) NSString *no;
/**
 险种名称
 */
@property (nonatomic, copy) NSString *insuranceName;
/**
 承保额
 */
@property (nonatomic, copy) NSString *coverBal;

/**
 标准保费
 */
@property (nonatomic, copy) NSString *insuranceFee;
/**
 费率系数
 */
@property (nonatomic, copy) NSString *feeRateFactor;
/**
 实付金额
 */
@property (nonatomic, copy) NSString *payAmt;

/**
 费率浮动原因
 */
@property (nonatomic, copy) NSString *feeFloatCause;

@end

/**************** 2.1车辆信息模型 **************/
@interface YJCarInsuranceVehicleInfo : NSObject
/**
 车牌号
 */
@property (nonatomic, copy) NSString *plateNo;
/**
 品牌
 */
@property (nonatomic, copy) NSString *model;
/**
 发动机号
 */
@property (nonatomic, copy) NSString *engineNo;
/**
 车架号
 */
@property (nonatomic, copy) NSString *vin;
/**
 核定座位数
 */
@property (nonatomic, copy) NSString *approvedCapacity;
/**
 核定载质量
 */
@property (nonatomic, copy) NSString *approvedLoad;

/**
 车辆类型
 */
@property (nonatomic, copy) NSString *vehicleType;

/**
 车辆使用性质
 */
@property (nonatomic, copy) NSString *useCharacter;
/**
 排量
 */
@property (nonatomic, copy) NSString *displacement;
/**
 行驶区域
 */
@property (nonatomic, copy) NSString *travelArea;
/**
 车主
 */
@property (nonatomic, copy) NSString *owner;
/**
 新车购置价
 */
@property (nonatomic, copy, getter = theNewCarPrice) NSString *newCarPrice;


/**
 初次登记日期
 */
@property (nonatomic, copy) NSString *registerDate;



@end


/**************** 2.保单信息 **************/
@interface YJCarInsurancePolicyDetails : NSObject

@property (nonatomic, assign) BOOL isSelected;

/**
 保单号
 */
@property (nonatomic, copy) NSString *policyNo;

/**
 险种别名(交强险、商业险)
 */
@property (nonatomic, copy) NSString *insuranceAlias;
/**
 险种名称
 */
@property (nonatomic, copy) NSString *insuranceName;
/**
 投保人
 */
@property (nonatomic, copy) NSString *insurer;
/**
 被保险人
 */
@property (nonatomic, copy) NSString *insured;
/**
 被保险人身份证号
 */
@property (nonatomic, copy) NSString *insuredIdentityNo;
/**
 保险有效开始时间
 */
@property (nonatomic, copy) NSString *effectivePeriodStart;
/**
 保险有效结束时间
 */
@property (nonatomic, copy) NSString *effectivePeriodEnd;
/**
 保单状态(有效/无效)
 */
@property (nonatomic, copy) NSString *status;
/**
 争议解决方式
 */
@property (nonatomic, copy) NSString *disputeSolution;
/**
 总保额
 */
@property (nonatomic, copy) NSString *insuredAmt;
/**
 总保费
 */
@property (nonatomic, copy) NSString *premiumAmt;
/**
 已缴保费
 */
@property (nonatomic, copy) NSString *paidAmt;
/**
 欠缴保费
 */
@property (nonatomic, copy) NSString *unPaidAmt;
/**
 缴费方式
 */
@property (nonatomic, copy) NSString *payType;
/**
 缴费日期
 */
@property (nonatomic, copy) NSString *payDate;

/**
 车辆信息
 */
@property (nonatomic, strong) NSDictionary *vehicleInfo;
/**
 2.1车辆信息模型
 */
@property (nonatomic, strong) YJCarInsuranceVehicleInfo *vehicleInfoModel;

/**
 2.2责任险种信息
 */
@property (nonatomic, strong) NSArray *insurances;

/**
 车船税
 */
@property (nonatomic, strong) NSDictionary *vehicleVesselTax;
/**
 2.3车船税模型
 */
@property (nonatomic, strong) YJCarInsuranceVehicleVesselTax *vehicleVesselTaxModel;


@end


/**************** 1.基本信息 **************/
@interface YJCarInsuranceBasicInfo : NSObject
/**
 用户名
 */
@property (nonatomic, copy) NSString *username;
/**
 姓名
 */
@property (nonatomic, copy) NSString *name;
/**
 身份证号
 */
@property (nonatomic, copy) NSString *identityNo;
/**
 性别
 */
@property (nonatomic, copy) NSString *gender;
/**
 出生日期
 */
@property (nonatomic, copy) NSString *birthday;
/**
 婚姻状态
 */
@property (nonatomic, copy) NSString *maritalStatus;
/**
 手机号
 */
@property (nonatomic, copy) NSString *mobile;
/**
 邮箱
 */
@property (nonatomic, copy) NSString *email;
/**
 所在城市
 */
@property (nonatomic, copy) NSString *city;
/**
 地址
 */
@property (nonatomic, copy) NSString *address;
/**
 保险公司
 */
@property (nonatomic, copy) NSString *insuranceCompany;



@end


/**************** 车险 **************/
@interface YJCarInsuranceModel : NSObject

/**
 基本信息
 */
@property (nonatomic, strong) NSDictionary *basicInfo;

/**
 基本信息模型数据
 */
@property (nonatomic, strong) YJCarInsuranceBasicInfo *basicInfoModel;

/**
 保单信息
 */
@property (nonatomic, strong) NSArray *policyDetails;

@end
