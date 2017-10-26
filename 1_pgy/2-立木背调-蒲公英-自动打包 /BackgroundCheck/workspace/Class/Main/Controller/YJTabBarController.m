//
//  YJTabBarController.m
//  3.Lottery彩票
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "YJTabBarController.h"
//#import "AppDelegate.h"
#import "YJNavigationController.h"
//#import "MyNavigationController.h"


#import "YJSearchViewController.h"
#import "YJRecordViewController.h"
#import "YJPodfileViewController.h"

@interface YJTabBarController ()

@end


@implementation YJTabBarController


static YJTabBarController *_instance;
+ (instancetype)shareTabBarVC {
    if (_instance == nil) {
        _instance = [[YJTabBarController alloc] init];
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    YJSearchViewController *homeVc = [[YJSearchViewController alloc] init];
    YJNavigationController *nav1 = [[YJNavigationController alloc] initWithRootViewController:homeVc];

    [self addChildViewController:nav1 title:@"立木背调" image:@"tabbar_home_nor" selectedImage:@"tabbar_home_sel"];
    
    
    YJRecordViewController *recordVc = [[YJRecordViewController alloc] init];
    YJNavigationController *nav2 = [[YJNavigationController alloc] initWithRootViewController:recordVc];
    
    [self addChildViewController:nav2 title:@"报告" image:@"tabbar_record_nor" selectedImage:@"tabbar_record_sel"];
    
    
    YJPodfileViewController *podfileVc = [[YJPodfileViewController alloc] init];
    YJNavigationController *nav3 = [[YJNavigationController alloc] initWithRootViewController:podfileVc];
    [self addChildViewController:nav3 title:@"我" image:@"tabbar_me_nor" selectedImage:@"tabbar_me_sel"];
    
    
    
    
    
    
    [self setupTabBar];
    
}

- (void)setupTabBar {
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 0, kScreenW, 0.5);
    line.backgroundColor = RGB(187, 187, 187);
    [self.tabBar addSubview:line];
     
    self.tabBar.backgroundColor = [UIColor whiteColor];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}

/**
 添加子控制器
 
 @param childController 子控制器
 @param title 标题
 @param image 图标
 @param selectedImage 选中图标
 */
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
//    childController.title = title;
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [self addChildViewController:childController];
}





@end
