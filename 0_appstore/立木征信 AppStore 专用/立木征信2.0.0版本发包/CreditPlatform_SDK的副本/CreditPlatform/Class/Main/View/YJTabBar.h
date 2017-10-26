//
//  YJTabBar.h
//  3.Lottery彩票
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJButton;
@class YJTabBar;

@protocol YJTabBarDelegate <NSObject>

- (void)tabBar:(YJTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to;

@end



@interface YJTabBar : UIView
@property (strong,nonatomic)  YJButton *selectedButton;     
@property (nonatomic, weak) id<YJTabBarDelegate> delegate;

- (void)addButtonWithTitle:(NSString *)title imageName:(NSString *)name selectedImageName:(NSString *)selName;



@end
