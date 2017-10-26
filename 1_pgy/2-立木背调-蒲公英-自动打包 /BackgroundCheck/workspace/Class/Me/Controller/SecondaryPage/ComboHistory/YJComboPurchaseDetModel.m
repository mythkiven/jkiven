//
//  YJComboPurchaseDetModel.m
//  CreditPlatform
//
//  Created by yj on 2016/10/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJComboPurchaseDetModel.h"

@implementation YJComboPurchaseDetRow
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"statisMap" : [YJComboPurchaseItem class]};
}

@end

@implementation YJComboPurchaseItem

@end

@implementation YJComboPurchaseDetModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"rows" : [YJComboPurchaseDetRow class]};
}
@end
