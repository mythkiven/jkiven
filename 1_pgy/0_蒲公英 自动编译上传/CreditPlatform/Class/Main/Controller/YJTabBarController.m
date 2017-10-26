//
//  YJTabBarController.m
//  3.Lottery彩票
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "YJTabBarController.h"
#import "YJTabBar.h"
//#import "AppDelegate.h"
#import "YJNavigationController.h"
#import "MyNavigationController.h"


#import "YJSearchViewController.h"
#import "YJRecordViewController.h"
#import "YJPodfileViewController.h"

@interface YJTabBarController ()<YJTabBarDelegate>

@end


@implementation YJTabBarController
{
   CGFloat _tabbarHeight;
}
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


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titles = @[@"首页", @"报告", @"我"];
    [self addChildViewControllers:titles];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti) name:NSNotificationCenter_inputSrearchBar object:nil];
    _tabbarHeight = self.tabBar.frame.origin.y;
}


-(void)noti {
    if(iPhoneX){
        [self performSelector:@selector(remove:) withObject:@YES afterDelay:1];
    }
}

-(void)remove:(BOOL)info{
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
    if (iPhoneX&&info) {
         [self viewWillLayoutSubviews];
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self remove:NO];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(iOS11){
         [self remove:NO];
    }
}
- (void)addChildViewControllers:(NSArray *)titles {
    
    // 首页-搜索页面
    YJSearchViewController *searchVC = [[YJSearchViewController alloc] init];
//    if(iOS11){
//    }else{
        searchVC.title = titles[0];
//    }
    
    YJNavigationController *navc1 = [[YJNavigationController alloc] initWithRootViewController:searchVC];
    
//    RTRootNavigationController *navc1 = [[RTRootNavigationController alloc] initWithRootViewController:searchVC];
    
    // 查询记录 自定义nav
    YJRecordViewController *recordVC = [[YJRecordViewController alloc] init];
//    if(iOS11){
//    }else{
        recordVC.title = titles[1];
//    }
    YJNavigationController *navc2 = [[YJNavigationController alloc] initWithRootViewController:recordVC];
//    RTRootNavigationController *navc2 = [[RTRootNavigationController alloc] initWithRootViewController:recordVC];
    
    // 个人
    YJPodfileViewController *meVC = [[YJPodfileViewController alloc] init];
//    if(iOS11){
//    }else{
        meVC.title = titles[2];
//    }
    YJNavigationController *navc3 = [[YJNavigationController alloc] initWithRootViewController:meVC];
//    RTRootNavigationController *navc3 = [[RTRootNavigationController alloc] initWithRootViewController:meVC];
    
    
    self.viewControllers = @[navc1, navc2, navc3];
    
    [self creatTabBarWithTitles:titles];
    
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    UIGraphicsBeginImageContextWithOptions(reSize, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;}

/**
 *  自定义TabBar
 */
- (void)creatTabBarWithTitles:(NSArray *)titles {
    
    
    _tabBarr = [[YJTabBar alloc] initWithFrame:self.tabBar.bounds];
    if(iPhoneX){
        _tabBarr.frame = CGRectMake(0,
                                    -12,
                                    self.tabBar.frame.size.width,
                                    self.tabBar.frame.size.height);
    }
    _tabBarr.delegate = self;
    [_tabBarr addButtonWithTitle:@"首页" imageName:@"tabbar_home_nor" selectedImageName:@"tabbar_home_sel"];
    [_tabBarr addButtonWithTitle:@"报告" imageName:@"tabbar_record_nor" selectedImageName:@"tabbar_record_sel"];
    [_tabBarr addButtonWithTitle:@"我" imageName:@"tabbar_me_nor" selectedImageName:@"tabbar_me_sel"];
    self.tabBar.backgroundColor = [UIColor clearColor];
    [self.tabBar addSubview:_tabBarr];
    [self.tabBar bringSubviewToFront:_tabBarr];
    
}

- (void)viewWillLayoutSubviews{
    if(iPhoneX){
        self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x,
                                       _tabbarHeight+12,
                                       self.tabBar.frame.size.width,
                                       self.tabBar.frame.size.height);
    }
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    if(iOS11){
        
    }
}

#pragma mark YJTabBarDelegate代理
- (void)tabBar:(YJTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to {
 
    self.selectedIndex = to;
    
}


@end
