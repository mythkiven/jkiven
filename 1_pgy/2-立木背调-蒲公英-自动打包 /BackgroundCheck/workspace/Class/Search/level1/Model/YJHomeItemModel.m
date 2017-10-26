//
//  YJHomeItemModel.m
//  CreditPlatform
//
//  Created by yj on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJHomeItemModel.h"

@implementation YJHomeItemModel

- (void)setIntro:(NSDictionary *)intro {
    _intro = intro;
    _introModel = [YJHomeItemModel mj_objectWithKeyValues:intro];
}


@end
