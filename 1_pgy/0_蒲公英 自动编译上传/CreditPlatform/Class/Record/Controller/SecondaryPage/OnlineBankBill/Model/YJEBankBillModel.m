//
//  YJEBankBillModel.m
//  CreditPlatform
//
//  Created by yj on 2016/11/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJEBankBillModel.h"

@implementation YJEBankBill


@end


@implementation YJEBankCards
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"bills" : [YJEBankBill class]};
}

@end


@implementation YJEBankBillModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"cards" : [YJEBankCards class]};
}
@end
