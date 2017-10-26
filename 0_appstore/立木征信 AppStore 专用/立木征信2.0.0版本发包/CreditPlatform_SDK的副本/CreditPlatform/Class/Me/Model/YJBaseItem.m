//
//  YJBaseItem.m
//  inZhua
//
//  Created by yj on 16/5/25.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "YJBaseItem.h"

@implementation YJBaseItem


+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle {
    YJBaseItem *item = [[self alloc] init];
    item.title = title;
    item.subTitle = subTitle;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title {
    
    return [self itemWithTitle:title subTitle:nil];
    
}


+ (instancetype)itemWithIcon:(NSString *)icon Title:(NSString *)title subTitle:(NSString *)subTitle {
    YJBaseItem *item = [self itemWithTitle:title subTitle:subTitle];
    item.icon = icon;
    return item;
}
@end
