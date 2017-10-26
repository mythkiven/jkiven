//
//  YJHouseFundModel.m
//  CreditPlatform
//
//  Created by yj on 16/8/3.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJHouseFundModel.h"

@implementation YJHouseFundDetails




@end

@implementation YJLoadInfo


@end

@implementation YJHouseFundModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"details" : [YJHouseFundDetails class]};
}


- (void)setLoadInfo:(NSDictionary *)loadInfo {
    _loadInfo = loadInfo;
    _loadMsg = [YJLoadInfo mj_objectWithKeyValues:loadInfo];
    
}


@end
