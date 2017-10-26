//
//  YJMenuModel.m
//  CreditPlatform
//
//  Created by yj on 2017/6/30.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import "YJMenuModel.h"

@interface YJMenuModel ()

@end

@implementation YJMenuModel

+ (instancetype)menuModelWith:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        _title = title;
    }
    return self;
}



@end
