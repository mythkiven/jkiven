//
//  OperationModel.m
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/8/3.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "OperationModel.h"

@implementation OperationMainModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"basicInfo":[OperationModel class],
             @"netInfo" : [OperationNetworkSix class],
             @"callRecordInfo" : [OperationCallSix class],
             @"businessInfo" : [OperationBanliSix class],
             @"stati" : [OperationCallTen class],
             @"bill" : [ OperationBillSix class],
             @"smsInfo" : [OperationMessageSix class],};
}

@end

@implementation OperationModel

- (void)setRealName:(NSString *)realName {
    _realName = FillSpace(realName);
}

- (void)setVipLevelstr:(NSString *)vipLevelstr {
    _vipLevelstr = FillSpace(vipLevelstr)
}

- (void)setMobileNo:(NSString *)mobileNo {
    _mobileNo = FillSpace(mobileNo);
}

- (void)setEmail:(NSString *)email {
    _email = FillSpace(email)
}

- (void)setAmount:(NSString *)amount {
    _amount = FillSpace(amount);
}

- (void)setIdCard:(NSString *)idCard {
    _idCard = FillSpace(idCard);
}

- (void)setPointsValuestr:(NSString *)pointsValuestr {
    _pointsValuestr = FillSpace(pointsValuestr);
}

- (void)setAddress:(NSString *)address {
    _address = FillSpace(address);
}

@end

@implementation OperationNetworkSix
@end

@implementation OperationCallSix
@end


@implementation OperationBanliSix
@end

@implementation OperationCallTen
@end


@implementation OperationBillSix
@end


@implementation OperationMessageSix
@end
