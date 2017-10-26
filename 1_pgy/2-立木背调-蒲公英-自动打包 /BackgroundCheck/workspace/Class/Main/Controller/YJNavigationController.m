//
//  YJNavigationController.m
//  zhaizhanggui
//
//  Created by yj on 16/4/22.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "YJNavigationController.h"
#import "YJReportSampleVC.h"
@interface YJNavigationController ()

@end

@implementation YJNavigationController 
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent; 
}

/**
 *  当第一次使用这个类的时候调用1次
 */
+ (void)initialize
{
    // 设置UINavigationBarTheme的主
    [self setupNavigationBarTheme];
    
    // 设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transferNavigationBarAttributes = NO;
    self.navigationController.navigationBar.alpha = 1.0;
    self.navigationBar.translucent = NO;
//    self.navigationBar.tintColor = RGB_white;
//    self.navigationBar.barTintColor = RGB_white;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
 
    if (self.viewControllers.count >  0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航栏按钮
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"arrow_back"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemtarget:self action:@selector(back)];
        
    }
    
    [super pushViewController:viewController animated:animated];

}


/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme
{
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置导航栏背景
    [appearance setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
    appearance.shadowImage =[UIImage imageWithColor:[RGB_white colorWithAlphaComponent:0]];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = Font18;
    [appearance setTitleTextAttributes:textAttrs];


    
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme
{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];

    /**设置文字属性**/
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = Font17;

    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
     

}

/**
 *  能拦截所有push进来的子控制器
 */
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
//        viewController.hidesBottomBarWhenPushed = YES;
//        
//        // 设置导航栏按钮
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" highImageName:@"navigationbar_more_highlighted" target:self action:@selector(more)];
//    }
//    [super pushViewController:viewController animated:animated];
//}
//
- (void)back
{
    [self popViewControllerAnimated:YES];
}
//
//- (void)more
//{
//    [self popToRootViewControllerAnimated:YES];
//}



@end
