//
//  YJRecordModel.m
//  CreditPlatform
//
//  Created by yj on 2017/5/19.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import "YJRecordModel.h"
#import "ReportFirstCommonModel.h"

@implementation YJRecordModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":[ReportFirstCommonModel class]};
}

@end
