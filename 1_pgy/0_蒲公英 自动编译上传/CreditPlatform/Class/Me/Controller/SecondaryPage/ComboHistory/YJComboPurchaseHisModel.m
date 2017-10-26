//
//  YJComboPurchaseHisModel.m
//  CreditPlatform
//
//  Created by yj on 2016/10/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJComboPurchaseHisModel.h"

@implementation YJComboPurchaseData



@end


@implementation YJComboPurchaseList



@end

@implementation YJComboPurchaseHisModel

- (void)setData:(NSDictionary *)data {
    _data = data;
    
    _comboPurchaseData = [YJComboPurchaseData mj_objectWithKeyValues:_data];
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : [YJComboPurchaseList class]};
}


@end
