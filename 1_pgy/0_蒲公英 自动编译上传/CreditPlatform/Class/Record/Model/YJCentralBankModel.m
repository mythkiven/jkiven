//
//  YJCentralBankModel.m
//  CreditPlatform
//
//  Created by yj on 16/8/18.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCentralBankModel.h"

/************** 1基本信息 **************/
@implementation YJCentralBankBasicInfoModel


@end
/************** 2信贷记录 **************/
@implementation YJCentralBankCreditRecordModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"summary" : [YJCentralBankSummary class],
             @"detail" : [YJCentralBankDetail class]};
}
@end

/************** 2.1信贷记录概要 **************/
@implementation YJCentralBankSummary

@end
/************** 2.2信贷记录详细 **************/
@implementation YJCentralBankDetail

@end

/************** 3公共记录描述 **************/
@implementation YJCentralBankPublicRecordModel
@end

/******* 4查询记录(个人查询、机构查询) ********/
@implementation YJCentralBankSearchRecordModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"searchRecordDet" : [YJCentralBankSearchRecordDet class]};
}
@end

/******* 4.1查询记录明细 ********/
@implementation YJCentralBankSearchRecordDet
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"item" : [YJCentralBankSearchRecordDetItem class]};
}

@end
/******* 4.2查询详细 ********/
@implementation YJCentralBankSearchRecordDetItem
@end


/************** 央行征信数据结果集 **************/
@implementation YJCentralBankModel

- (void)setBasicInfo:(NSDictionary *)basicInfo {
    _basicInfo = basicInfo;
    _basicInfoModel = [YJCentralBankBasicInfoModel mj_objectWithKeyValues:basicInfo];

}

- (void)setCreditRecord:(NSDictionary *)creditRecord {
    _creditRecord = creditRecord;
    _creditRecordModel = [YJCentralBankCreditRecordModel mj_objectWithKeyValues:creditRecord];
}

- (void)setPublicRecord:(NSDictionary *)publicRecord {
    _publicRecord = publicRecord;
    _publicRecordModel = [YJCentralBankPublicRecordModel mj_objectWithKeyValues:publicRecord];
}

- (void)setSearchRecord:(NSDictionary *)searchRecord {
    _searchRecord = searchRecord;
    _searchRecordModel = [YJCentralBankSearchRecordModel mj_objectWithKeyValues:searchRecord];
    
}


+ (NSDictionary *)mj_objectClassInArray {
    return @{@"dataCreditRecordSummary" : [YJCentralBankSummary class]};
}

@end




