//
//  PurchaseHistoryModel.m
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/9/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "PurchaseHistoryModel.h"

@implementation PurchaseHistoryModel

@end


@implementation PurchaseHistoryOutModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":[PurchaseHistoryModel class]};
}
- (void)setData:(NSDictionary *)data{
    _data = data;
    _allCost = [PurchaseHistoryInsort mj_objectWithKeyValues:data];
    
}


@end




@implementation PurchaseHistoryInsort




@end