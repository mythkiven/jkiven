//
//  YJArrowItem.m
//  inZhua
//
//  Created by yj on 16/5/25.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "YJArrowItem.h"

@implementation YJArrowItem
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle destVc:(Class)destVc {
    
    YJArrowItem *item = [self itemWithTitle:title subTitle:subTitle];
    item.destVC = destVc;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title destVc:(Class)destVc {
    
    YJArrowItem *item = [self itemWithTitle:title subTitle:nil destVc:destVc];
    return item;
}

+ (instancetype)itemWithIcon:(NSString *)icon Title:(NSString *)title subTitle:(NSString *)subTitle destVc:(Class)destVc {
    
    YJArrowItem *item = [self itemWithTitle:title subTitle:subTitle destVc:destVc];
    item.icon = icon;
    return item;
}


+ (instancetype)itemWithIcon:(NSString *)icon Title:(NSString *)title destVc:(Class)destVc {
    
    return [self itemWithIcon:icon Title:title subTitle:nil destVc:destVc];
}

@end
