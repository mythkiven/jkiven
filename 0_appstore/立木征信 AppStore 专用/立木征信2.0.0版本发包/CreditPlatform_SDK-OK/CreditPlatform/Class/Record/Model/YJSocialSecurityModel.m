//
//  YJSocialSecurityModel.m
//  CreditPlatform
//
//  Created by yj on 16/8/3.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJSocialSecurityModel.h"


/***********社保模型*************/
@implementation YJSocialSecurityModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"insurances" : [YJInsurances class],
             @"pensionDetails" : [YJBaseInsurance class],
             @"medicareDetails" : [YJBaseInsurance class],
             @"jobSecurityDetails" : [YJBaseInsurance class],
             @"employmentInjuryDetails" : [YJBaseInsurance class],
             @"maternityDetails" : [YJBaseInsurance class]};
}


@end

@implementation YJBaseInsurance

@end

/***********社保险种信息*************/
@implementation YJInsurances

@end




