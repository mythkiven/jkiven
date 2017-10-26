//
//  UIViewController+BackButtonHandler.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/14.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "UIViewController+BackButtonHandler.h"

@interface UINavigationController (ShouldPopOnBackButton)

@end

@implementation UINavigationController (ShouldPopOnBackButton)

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
