//
//  LMZXCityModel.m
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/2/15.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXCityModel.h"

@implementation LMZXCityLoginElement
+ (instancetype)cityLoginElementWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}


- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}



@end



@implementation LMZXCityModel
+ (instancetype)cityWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}


- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}





@end
