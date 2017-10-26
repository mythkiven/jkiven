//
//  YJCentralBankModel.h
//  CreditPlatform
//
//  Created by yj on 16/8/18.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJBaseSearchDataModel.h"
/************** 1基本信息 **************/
@interface YJCentralBankBasicInfoModel : NSObject
/**
 *  报告编号
 */
@property (nonatomic, copy) NSString *no;
/**
 *  查询时间
 */
@property (nonatomic, copy) NSString *sTime;
/**
 *  报告时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  姓名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  证件类型
 */
@property (nonatomic, copy) NSString *cardType;
/**
 *  证件号码
 */
@property (nonatomic, copy) NSString *cardNo;
/**
 *  婚姻状态
 */
@property (nonatomic, copy) NSString *maritalStatus;

@end
/************** 2信贷记录 **************/
@interface YJCentralBankCreditRecordModel : NSObject
/**
 *  信贷记录描述
 */
@property (nonatomic, copy) NSString *descrip;

/**
 *  信贷记录详细
 */
@property (nonatomic, strong) NSArray *detail;
/**
 *  信贷记录备注
 */
@property (nonatomic, strong) NSArray *comment;

@end

/************** 2.2信贷记录详细 **************/
@interface YJCentralBankDetail: NSObject
/**
 *  类别【信用卡、购房贷款、其他贷款】
 */
@property (nonatomic, copy) NSString *type;
/**
 *  信贷记录详细信息
 */
@property (nonatomic, copy) NSString *headTitle;
/**
 *  信贷记录项
 */
@property (nonatomic, strong) NSArray *item;

@end



/************** 3公共记录描述 **************/
@interface YJCentralBankPublicRecordModel : NSObject
/**
 *  公共记录描述
 */
@property (nonatomic, copy) NSString *descrip;
@end

/******* 4查询记录(个人查询、机构查询) ********/
@interface YJCentralBankSearchRecordModel : NSObject
/**
 *  查询记录描述
 */
@property (nonatomic, copy) NSString *descrip;
/**
 *  查询记录明细(个人/机构)
 */
@property (nonatomic, strong) NSArray *searchRecordDet;

@end

/******* 4.1查询记录明细 ********/
@interface YJCentralBankSearchRecordDet : NSObject
/**
 *  查询记录描述
 */
@property (nonatomic, copy) NSString *type;
/**
 *  查询详细
 */
@property (nonatomic, strong) NSArray *item;

@end
/******* 4.2查询详细 ********/
@interface YJCentralBankSearchRecordDetItem : NSObject
/**
 *  编号
 */
@property (nonatomic, copy) NSString *no;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  查询用户
 */
@property (nonatomic, copy) NSString *user;
/**
 *  查询原因
 */
@property (nonatomic, copy) NSString *reason;

@end





/************** 央行征信数据结果集 **************/
@interface YJCentralBankModel : NSObject
/**
 *  1个人信息
 */
@property (nonatomic, strong) NSDictionary *basicInfo;
/**
 *  2信贷记录
 */
@property (nonatomic, strong) NSDictionary *creditRecord;
/**
 *  3公共记录描述
 */
@property (nonatomic, strong) NSDictionary *publicRecord;
/**
 *  4查询记录(个人查询、机构查询)
 */
@property (nonatomic, strong) NSDictionary *searchRecord;


/**
 *  1个人信息
 */
@property (nonatomic, strong) YJCentralBankBasicInfoModel *basicInfoModel;
/**
 *  2信贷记录
 */
@property (nonatomic, strong) YJCentralBankCreditRecordModel *creditRecordModel;
/**
 *  3公共记录描述
 */
@property (nonatomic, strong) YJCentralBankPublicRecordModel *publicRecordModel;
/**
 *  4查询记录(个人查询、机构查询)
 */
@property (nonatomic, strong) YJCentralBankSearchRecordModel *searchRecordModel;


/**
 *  信用卡数
 */
@property (nonatomic, strong) NSArray *dataCreditRecordSummary;

@end




/************** 2信贷记录概要 **************/
@interface YJCentralBankSummary : NSObject

/**
 *  信用度量【账户数、未结清/未销户账户数、发生过逾期的账户数、发生过逾
 *  期的账户数、发生过90天以上逾期的账户数、为他人担保笔数】
 */
@property (nonatomic, copy) NSString *var;
/**
 *  信用卡数量
 */
@property (nonatomic, copy) NSString *creditCount;
/**
 *  房贷数量
 */
@property (nonatomic, copy) NSString *houseLoanCount;
/**
 *  其它数量
 */
@property (nonatomic, copy) NSString *otherLoanCount;

@end


