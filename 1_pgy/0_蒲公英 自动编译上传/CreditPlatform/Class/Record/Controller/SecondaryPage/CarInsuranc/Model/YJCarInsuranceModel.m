//
//  YJCarInsuranceModel.m
//  CreditPlatform
//
//  Created by yj on 2016/11/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCarInsuranceModel.h"

@implementation YJCarInsuranceModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"policyDetails" : [YJCarInsurancePolicyDetails class]};
}

- (void)setBasicInfo:(NSDictionary *)basicInfo {
    _basicInfo = basicInfo;
    
    _basicInfoModel = [YJCarInsuranceBasicInfo mj_objectWithKeyValues:basicInfo];
}
@end


@implementation YJCarInsuranceBasicInfo


@end

@implementation YJCarInsurancePolicyDetails

- (void)setVehicleInfo:(NSDictionary *)vehicleInfo {
    _vehicleInfo = vehicleInfo;
    
    _vehicleInfoModel = [YJCarInsuranceVehicleInfo mj_objectWithKeyValues:vehicleInfo];
}

- (void)setVehicleVesselTax:(NSDictionary *)vehicleVesselTax {
    _vehicleVesselTax = vehicleVesselTax;
    
    _vehicleVesselTaxModel = [YJCarInsuranceVehicleVesselTax mj_objectWithKeyValues:vehicleVesselTax];
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"insurances" : [YJCarInsuranceInsurance class]};
}

@end


@implementation YJCarInsuranceVehicleVesselTax

@end

@implementation YJCarInsuranceInsurance

@end

@implementation YJCarInsuranceVehicleInfo

@end

