//
//  YJBaseItem.h
//  inZhua
//
//  Created by yj on 16/5/25.
//  Copyright © 2016年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OptionBlock)(NSIndexPath *indexPath);

@interface YJBaseItem : NSObject

@property (nonatomic, copy) OptionBlock option;


@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;


+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;
+ (instancetype)itemWithIcon:(NSString *)icon Title:(NSString *)title subTitle:(NSString *)subTitle;

@end
