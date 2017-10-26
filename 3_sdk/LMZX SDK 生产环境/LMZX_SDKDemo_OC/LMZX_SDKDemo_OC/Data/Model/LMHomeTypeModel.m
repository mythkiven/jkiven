//
//  LMHomeTypeModel.m
//  LMZX_SDKDemo_OC
//
//  Created by yj on 2017/3/29.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import "LMHomeTypeModel.h"

@implementation LMHomeTypeModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)homeTypeModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setFunctions:(NSArray *)functions {
    _functions = functions;
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in functions) {
        LMHomeTypefunction *model = [LMHomeTypefunction homeTypefunctionWithDict:dict];
        [arr addObject:model];
    }
    _functionModels = arr;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}
@end


@implementation LMHomeTypefunction

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)homeTypefunctionWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
