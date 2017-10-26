//
//  UIViewController+Extend.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "UIViewController+Extend.h"
@implementation UIViewController (Extend)


#pragma mark 自动退出
//退出
-(void)jOutSelf{
    [self jPopSelfWith:errorDelay];
    [self jDismissOutSelfWith:errorDelay];
}

//自动pop退出
-(void)jPopSelfWith:(CGFloat)delay{
    if (!delay) {
        delay =errorDelay;
    }
    [self performSelector:@selector(outSelfWith:) withObject:@"11" afterDelay:delay];
}
//自动present退出
-(void)jDismissOutSelfWith:(CGFloat)delay{
    if (!delay) {
        delay =errorDelay;
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
