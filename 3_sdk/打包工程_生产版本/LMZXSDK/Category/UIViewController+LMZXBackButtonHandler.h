//
//  UIViewController+LMZXBackButtonHandler.h
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/3/6.
//  Copyright © 2017年 lmzx. All rights reserved.
//

//#import <UIKit/UIKit.h>
//
//
//@interface UIViewController (LMZXBackButtonHandler)
//
//
//@end


#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>

@optional
// 重写back方法
-(BOOL)navigationShouldPopOnBackButton;
@end




@interface UIViewController (LMZXBackButtonHandler) <BackButtonHandlerProtocol>
-(void)jPopSelf;
//自动退出
-(void)jOutSelf;
-(void)jDismissSelf;
//自动pop退出
-(void)jPopSelfWith:(CGFloat)delay;
//自动dismiss退出
-(void)jDismissOutSelfWith:(CGFloat)delay;

//视图是否显示
-(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;
//获取vc
+ (UIViewController *)getCurrentVC;


@end
