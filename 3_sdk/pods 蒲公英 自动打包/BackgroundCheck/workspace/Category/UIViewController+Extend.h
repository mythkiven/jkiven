//
//  UIViewController+Extend.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extend)

//自动退出
-(void)jOutSelf;
//自动pop退出
-(void)jPopSelfWith:(CGFloat)delay;
//自动dismiss退出
-(void)jDismissOutSelfWith:(CGFloat)delay;

//视图是否显示
-(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;
//获取vc
+ (UIViewController *)getCurrentVC;
@end
