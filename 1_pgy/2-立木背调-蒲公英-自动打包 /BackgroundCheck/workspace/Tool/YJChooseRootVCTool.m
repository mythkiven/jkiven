//
//  YJChooseRootVCTool.m
//  CreditPlatform
//
//  Created by yj on 16/7/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJChooseRootVCTool.h"
#import "YJNewFeatureViewController.h"
#import "YJTabBarController.h"
@implementation YJChooseRootVCTool
+ (void)chooseRootViewController
{
    // 如何知道第一次使用这个版本？比较上次的使用情况
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if ([currentVersion isEqualToString:lastVersion]) {
        // 当前版本号 == 上次使用的版本：显示HMTabBarViewController 
    YJTabBarController *YY= [YJTabBarController shareTabBarVC];
   // window.rootViewController = YY;
//     window.rootViewController = [[YJNavigationController alloc] initWithRootViewController:YY];
    window.rootViewController = [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:YY];
    
//    } else { // 当前版本号 != 上次使用的版本：显示版本新特性
//        window.rootViewController = [[YJNewFeatureViewController alloc] init];
//        
//        // 存储这次使用的软件版本
//        [defaults setObject:currentVersion forKey:versionKey];
//        [defaults synchronize];
//    }
}
@end
