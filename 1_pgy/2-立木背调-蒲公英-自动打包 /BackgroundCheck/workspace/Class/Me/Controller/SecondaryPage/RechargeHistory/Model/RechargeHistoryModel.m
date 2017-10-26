//
//  RechargeHistoryModel.m
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/9/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "RechargeHistoryModel.h"

@implementation RechargeHistoryModel

@end


@implementation RechargeHistoryOutModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":[RechargeHistoryModel class]};
}
- (void)setData:(NSDictionary *)data{
    _data = data;
    _allCost = [RechargeHistoryInsort mj_objectWithKeyValues:data];
    
}


@end

@implementation RechargeHistoryInsort




@end