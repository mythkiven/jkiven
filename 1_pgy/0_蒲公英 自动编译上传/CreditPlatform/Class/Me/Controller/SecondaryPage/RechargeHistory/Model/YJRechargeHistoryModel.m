//
//  YJRechargeHistoryModel.m
//  CreditPlatform
//
//  Created by yj on 2017/5/18.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import "YJRechargeHistoryModel.h"

@implementation YJRechargeHistoryListModel

@end

@implementation YJRechargeHistoryPageModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":[YJRechargeHistoryListModel class]};
}

@end

@implementation YJRechargeHistoryModel
- (void)setPage:(NSDictionary *)page {
    _page = page;
    
    _pageModel = [YJRechargeHistoryPageModel mj_objectWithKeyValues:page];
}
@end
