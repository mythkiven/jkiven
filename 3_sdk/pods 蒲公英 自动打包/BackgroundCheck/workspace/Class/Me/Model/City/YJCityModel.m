//
//  YJCityModel.m
//  CreditPlatform
//
//  Created by yj on 16/7/20.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCityModel.h"

@implementation YJCityInfoModel


-(void)setFieldItemCfg:(id)fieldItemCfg{
    _fieldItemCfg = fieldItemCfg;
    id json = [fieldItemCfg  mj_JSONString];
    _fundSocialModel = [JFundSocialSearchCellUpModel mj_objectWithKeyValues:json];
}
@end


@implementation JFundSocialSearchCellModel


@end

@implementation JFundSocialSearchCellUpModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"fieldItemCfg":[JFundSocialSearchCellModel class]};
}

@end


@implementation YJCityModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"sortList":[YJCityInfoModel class]};
}

+ (instancetype)cityModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _cityCode = dict[@"编码"];
        _cityName = dict[@"市名"];
    }
    return self;
}
@end
