//
//  YJPurchaseHistoryModel.m
//  CreditPlatform
//
//  Created by yj on 2017/5/18.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import "YJPurchaseHistoryModel.h"

@implementation YJPurchaseHistoryListModel

@end

@implementation YJPurchaseHistoryPageModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":[YJPurchaseHistoryListModel class]};
}

@end

@implementation YJPurchaseHistoryModel

- (void)setPage:(NSDictionary *)page {
    _page = page;
    
    _pageModel = [YJPurchaseHistoryPageModel mj_objectWithKeyValues:page];
}

@end
