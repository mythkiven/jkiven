//
//  YJRedPacketModel.h
//  CreditPlatform
//
//  Created by yj on 16/9/18.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 id = 6ada7b4f7e3547789decfe264dca05d1,
	rechangeAmt = 20,
	mobile = <null>,
	createDate = 1474164691000,
	rechangeTypeStr = 红包,
	rechangeDate = 1474164691000,
	rechangeTypeName = 红包,
	serialNo = 160918000132351031,
	endDate = <null>,
	userId = 5a643ef748394453b0b67f14d2e7f753,
	rechangeStateStr = 交易成功,
	remark = 9月20到期20元,
	updateDate = 1474164691000,
	rechangeDateStr = 2016-09-18 10:11:31,
	rechangeState = 2,
	rechangeType = 3,
	status = <null>
 */


@interface YJRedPacketModel : NSObject

@property (nonatomic, copy) NSString *rechangeAmt;
@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *rechangeTypeStr;

@property (nonatomic, copy) NSString *rechangeDate;
@property (nonatomic, copy) NSString *rechangeStateStr;


@property (nonatomic, copy) NSString *rechangeTypeName;

@property (nonatomic, copy) NSString *serialNo;

@property (nonatomic, copy) NSString *rechangeDateStr;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *rechangeState;

@property (nonatomic, copy) NSString *rechangeType;



@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *redAmt;

@property (nonatomic, copy) NSString *id;

@end
