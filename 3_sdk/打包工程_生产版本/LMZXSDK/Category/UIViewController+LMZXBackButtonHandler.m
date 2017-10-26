//
//  UIViewController+LMZXBackButtonHandler.m
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/3/6.
//  Copyright © 2017年 lmzx. All rights reserved.
//

//#import "UIViewController+LMZXBackButtonHandler.h"
//
//@implementation UIViewController (LMZXBackButtonHandler)
//
//@end
#import "UIViewController+LMZXBackButtonHandler.h"


#define LM_ErrorDelay 1.0


@interface UIViewController (LMZXVCExtend)

@end


@implementation UIViewController (LMZXVCExtend)


#pragma mark 自动退出
//退出
-(void)jOutSelf{
    [self jPopSelfWith:LM_ErrorDelay];
    [self jDismissOutSelfWith:LM_ErrorDelay];
}
-(void)jPopSelf{
    [self jPopSelfWith:LM_ErrorDelay];
}
-(void)jDismissSelf{
    [self jDismissOutSelfWith:LM_ErrorDelay];
}
//自动pop退出
-(void)jPopSelfWith:(CGFloat)delay{
    if (!delay) {
        delay =LM_ErrorDelay;
    }
    [self performSelector:@selector(outSelfWith:) withObject:@"11" afterDelay:delay];
}
//自动present退出
-(void)jDismissOutSelfWith:(CGFloat)delay{
    if (!delay) {
        delay =LM_ErrorDelay;
    }
    [self performSelector:@selector(outSelfWith:) withObject:@"12" afterDelay:delay];
}
-(void)outSelfWith:(NSString*)index{
    if (self) {
        if (self.navigationController &&[index isEqualToString:@"11"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([index isEqualToString:@"12"]) {
            [self dismissViewControllerAnimated:YES completion:^{ }];
        }
    }
    
}


#pragma mark 控制器是否在显示。
-(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController {
    if (viewController.isViewLoaded && viewController.view.window) {
        return YES;
    }
    return NO;
}


+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


@end













@interface UINavigationController (LMZXBackButtonHandler)

@end

@implementation UINavigationController (LMZXBackButtonHandler)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem*)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        
        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    
    return NO;
}

@end



