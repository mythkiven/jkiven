//
//  JENavigationController.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/19.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "JENavigationController.h"

@interface JENavigationController ()

@end

@implementation JENavigationController
//
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}
// 状态栏  
- (UIStatusBarStyle)preferredStatusBarStyle {
     return UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0]]  forBarMetrics:UIBarMetricsDefault];
    appearance.shadowImage = [UIImage imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0]];
    
   // self.navigationItem.backBarButtonItem = [UIBarButtonItem backBarButtonItem];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    if (self.viewControllers.count >  0) {
        viewController.hidesBottomBarWhenPushed = YES;
       // viewController.navigationItem.backBarButtonItem = [UIBarButtonItem backBarButtonItem];
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem loginBackBarButtonItemtarget:self action:@selector(back)];
        
    }
//    if (self.viewControllers.count >=2) {
//        viewController.navigationController.navigationBar.tintColor = RGB_navBar;
//        viewController.navigationController.navigationBar.barTintColor = RGB_navBar;
//    }
    
    [super pushViewController:viewController animated:animated];
    
}

#pragma mark -
- (void)back {
    [self popViewControllerAnimated:YES];
}
@end
