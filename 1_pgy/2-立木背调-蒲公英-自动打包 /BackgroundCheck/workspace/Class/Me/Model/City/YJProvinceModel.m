//
//  YJProvinceModel.m
//  CreditPlatform
//
//  Created by yj on 16/7/20.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJProvinceModel.h"
#import "YJCityModel.h"
@implementation YJProvinceModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"cities" : [YJCityModel class]};
}

+ (instancetype)provinceModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _province = dict[@"省"];
        _cities = dict[@"市"];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in _cities) {
            YJCityModel *cityModel = [YJCityModel cityModelWithDict:dict];
            [arr addObject:cityModel];
        }
        _cities = arr;
    }
    return self;
}


@end
