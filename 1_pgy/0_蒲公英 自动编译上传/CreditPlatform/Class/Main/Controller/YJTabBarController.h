//
//  YJTabBarController.h
//  3.Lottery彩票
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJTabBar;
@interface YJTabBarController : UITabBarController
//@property (assign,nonatomic) BOOL      isShow;
+ (instancetype)shareTabBarVC;

@property (strong,nonatomic) YJTabBar  *tabBarr;

@end
