//
//  JComboPurchaseB.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/10.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "JComboPurchaseBModel.h"

@implementation JComboPurchaseBModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : [JComboPurchaseBListModel class]};
}
- (void)setData:(NSDictionary *)data {
    _data = data;
    
    _jComboPurchaseBDataModel = [JComboPurchaseBDataModel mj_objectWithKeyValues:_data];
}

@end



@implementation JComboPurchaseBDataModel

@end

@implementation JComboPurchaseBListModel

@end
