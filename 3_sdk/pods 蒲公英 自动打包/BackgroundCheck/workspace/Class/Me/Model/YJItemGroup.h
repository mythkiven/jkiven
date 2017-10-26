//
//  YJItemGroup.h
//  zhaizhanggui
//
//  Created by yj on 16/5/4.
//  Copyright © 2016年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJItemGroup : NSObject

@property (nonatomic, copy) NSString *headerTitle;

@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, strong) NSArray *groups;

+ (instancetype)group;

@end
