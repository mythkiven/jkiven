//
//  CitySelectModel.m
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/7/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ListHookModel.h"

@implementation ListHookModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end

@implementation CompanyCarInsurancModel

@end

@implementation EBankListModel

@end


@implementation EBankListUpModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"list" : [EBankListModel class],};
}
@end


