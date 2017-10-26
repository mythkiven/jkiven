
//
//  CompanyDetailModel.m
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/8/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "CompanyDetailModel.h"

@implementation CompanyDetailModel


- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.auditDate = [aDecoder decodeObjectForKey:@"auditDate"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.busiLicenseCode = [aDecoder decodeObjectForKey:@"busiLicenseCode"];
        self.busiLicenseFileid = [aDecoder decodeObjectForKey:@"busiLicenseFileid"];
        self.busiLicensePicture = [aDecoder decodeObjectForKey:@"busiLicensePicture"];
        self.certiType = [aDecoder decodeObjectForKey:@"certiType"];
        self.certiTypestr = [aDecoder decodeObjectForKey:@"certiTypestr"];
        self.companyAddress = [aDecoder decodeObjectForKey:@"companyAddress"];
        self.companyCity = [aDecoder decodeObjectForKey:@"companyCity"];
        self.companyName = [aDecoder decodeObjectForKey:@"companyName"];
        self.companyProvince = [aDecoder decodeObjectForKey:@"companyProvince"];
        self.createDate = [aDecoder decodeObjectForKey:@"createDate"];
        self.remark = [aDecoder decodeObjectForKey:@"remark"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.statusStr = [aDecoder decodeObjectForKey:@"statusStr"];
        self.updateDate = [aDecoder decodeObjectForKey:@"updateDate"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.auditDate forKey:@"auditDate"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.busiLicenseCode forKey:@"busiLicenseCode"];
    [aCoder encodeObject:self.busiLicenseFileid forKey:@"busiLicenseFileid"];
    [aCoder encodeObject:self.busiLicensePicture forKey:@"busiLicensePicture"];
    [aCoder encodeObject:self.certiType forKey:@"certiType"];
    [aCoder encodeObject:self.certiTypestr forKey:@"certiTypestr"];
    [aCoder encodeObject:self.companyAddress forKey:@"companyAddress"];
    [aCoder encodeObject:self.companyCity forKey:@"companyCity"];
    [aCoder encodeObject:self.companyName forKey:@"companyName"];
    [aCoder encodeObject:self.companyProvince forKey:@"companyProvince"];
    [aCoder encodeBool:self.createDate forKey:@"createDate"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.statusStr forKey:@"statusStr"];
    [aCoder encodeObject:self.updateDate forKey:@"updateDate"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
}
@end
