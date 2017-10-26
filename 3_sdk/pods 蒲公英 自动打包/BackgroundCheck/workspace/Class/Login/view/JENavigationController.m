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

//+ (void)initialize{
//    
//    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
//    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
//    
//    /**设置文字属性**/
//    // 设置普通状态的文字属性
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    textAttrs[NSFontAttributeName] = Font17;
//    
//    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    
//    // 设置高亮状态的文字属性
//    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
//    highTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
//    
//    
//    UINavigationBar *appearance2 = [UINavigationBar appearance];
//    [appearance2 setBackgroundImage:[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]]  forBarMetrics:UIBarMetricsDefault];
//    appearance2.shadowImage = [UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]];
//    NSMutableDictionary *textAttrs2 = [NSMutableDictionary dictionary];
//    textAttrs2[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    textAttrs2[NSFontAttributeName] = Font18;
//    [appearance2 setTitleTextAttributes:textAttrs2];
//
//    
//}

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
