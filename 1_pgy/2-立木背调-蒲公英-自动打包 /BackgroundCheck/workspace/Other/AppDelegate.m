//
//  AppDelegate.m
//  inZhua
//
//  Created by yj on 16/5/25.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "AppDelegate.h"
#import "YJTabBarController.h"
#import "YJChooseRootVCTool.h"
#import "YJNewFeatureViewController.h"

#import "WXApi.h"
#import "WeChatPayManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YJAlipayManager.h"
#import "YJAlertView.h"
#import "YJCompanyDetailManager.h"

#import "LMBaseReportViewController.h"

#import "JDeviceInfo.h"


#import "WeChatPayManager.h"

#define APPID_TalkingData @"420032A3978B879DCEC83AC9D0519943"
#define Channel_TalkingData @"AppStore"

@interface AppDelegate ()
{
    BOOL _showAllows;//总是请求升级
    YJAlertView *_alertView;
    
//    int _checkUser;

}
@end

@implementation AppDelegate



 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
   
    
 

#warning test
    LMBaseReportViewController *YY= [[LMBaseReportViewController alloc]init];
// 标准版
//    YY.reportType = LMReportTypeStandardType;
//    YY.samepleUrl = @"http://192.168.117.36:8080/BackData/backDemo.do";
// 基础班
//    YY.reportType = LMReportTypeBasicType;
//    YY.samepleUrl = @"http://192.168.117.36:8080/BackData/app/basicsRecord";
//    self.window.rootViewController = [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:YY];
    
     //新特性
    [YJChooseRootVCTool chooseRootViewController];
#warning test
    
    
    // 启用微信支付
    [[WeChatPayManager shareWeChatPay] applicationDidFinishLaunchingAndBeginWechatPay];
    
    // 校验是否登录
    [self checkLogin];
    
    
    _showAllows = YES;
    
    // 启动统计
//    //错误收集
//    [TalkingData sessionStarted:APPID_TalkingData withChannelId:Channel_TalkingData];
//#ifdef DEBUG
//
//#else
//    [TalkingData setExceptionReportEnabled:YES];
//
//#endif
    
    
//    // 立木征信
//    [LMZXSDK registerLMZXSDK];
//    [LMZXSDK shared].channel = kChannelSDK;
//    [[LMZXSDK shared] unlockLog];
    
   
//    [self creatShortcutItem];
    
//    UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
//    
//    if (<#condition#>) {
//        <#statements#>
//    }
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:appWillResignActiveJ object:@"1"];
    [_alertView removeFromSuperview];

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    MYLog(@"---------进入前台");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    MYLog(@"---------app激活");
    // 每次重新打开APP，以及强制更新的时候，每次都检测。斗则不是。
    if (_showAllows) {
        [self checkVersion];
    }
    
}




- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

}



#pragma mark - 程序启动 检测是否登录
- (void)checkLogin {
    
    [Tool setBool:NO forKey:baozheng_duoci_qingqiu_meici_tanchu_yige_yemian];
    
    //  本地登录信息,出错 ==> 清空登录信息 注意,本地密码保存为@" ",传到服务端也是@" ".
    MYLog(@"是否登录：%d=====%@",kUserManagerTool.isLogin, kUserManagerTool.userPwd);
    if (kUserManagerTool.isLogin && (kUserManagerTool.userPwd == nil || [kUserManagerTool.userPwd isEqualToString:@""])) {
        [YJUserManagerTool clearUserInfo];
    }

    // 校验登录 session 有效性
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 如果有登录手机号, 就会校验登录有效性
        if (kUserManagerTool.mobile) {
            NSDictionary *dicParams =@{
                                       @"method" : urlJK_checkUserLogin,
                                       @"appVersion":ConnectPortVersion_1_0_0
                                       };
            [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_checkUserLogin] params:dicParams success:^(id responseObj) {
                MYLog(@"登录信息: %@",responseObj);
                NSString * code =[NSString stringWithFormat:@"%@",responseObj[@"success"] ];
                if ([code isEqualToString:@"1"] || [responseObj[@"msg"] isEqualToString:@"已登录"]) {
                    // 已登录
                    if (![kUserManagerTool.authStatus isEqualToString:@"20"]) {
                        // 更新认证信息
                        [YJCompanyDetailManager getCompanyInfoFromNet];
                    }
                }else{
                    // 未登录
                    [YJUserManagerTool clearUserInfo];
                }
                
            } failure:^(NSError *error) {
                 MYLog(@"_");
            }];
        }else{// 没有手机号信息, 进一步清除信息.
            [YJUserManagerTool clearUserInfo];
        }
    });

}

#pragma mark - APP回调
#pragma mark 微信 支付宝通用APP回调
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
//    __weak typeof(self) weakSelf = self;
    YJTabBarController *tabBarVc = [YJTabBarController shareTabBarVC];
    YJNavigationController *nav = [tabBarVc.childViewControllers lastObject];
    
    if ([url.scheme isEqualToString:@"wxae3f11af6432bcad"]) {
        //        return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
        return  [WXApi handleOpenURL:url delegate:[WeChatPayManager shareWeChatPay]];
    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [YJAlipayManager alipayHandleResult:url viewcontroller:nav.topViewController from:(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"Alipay_from"]];
        
        MYLog(@"9.0以后使用新API接口：支付结果url = %@",url);
        
        
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    //微信回调
    if ([url.scheme isEqualToString:@"wxae3f11af6432bcad"]) {
        //        return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
        return  [WXApi handleOpenURL:url delegate:[WeChatPayManager shareWeChatPay]];
    }
    
    //支付宝
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        YJTabBarController *tabBarVc = [YJTabBarController shareTabBarVC];
        YJNavigationController *nav = [tabBarVc.childViewControllers lastObject];
       
        [YJAlipayManager alipayHandleResult:url viewcontroller:nav.topViewController from:(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"Alipay_from"]];
    }
    
    
    //微信支付宝通用返回YES
    return YES;
}

#pragma mark 微信
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([url.scheme isEqualToString:@"wxae3f11af6432bcad"]) {
        //        return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
        return  [WXApi handleOpenURL:url delegate:[WeChatPayManager shareWeChatPay]];
    }
    return nil;
}
+ (BOOL)sendAuthReq:(SendAuthReq*)req viewController:(UIViewController*)viewController delegate:(id<WXApiDelegate>)delegate{
    
    return YES;
}




#pragma mark ---检查版本
-(void)checkVersion{
    //  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    //    __weak typeof(self) weakSelf = self;
    //    __block typeof(_downUrl) dd_ = _downUrl;
    NSDictionary *dict = @{@"method" : urlJK_queryAppVersion,
                           @"version" :currentVersion,
                           @"deviceType" :@"IOS",
                           @"appVersion":ConnectPortVersion_1_0_0
                           };
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryAppVersion] params:dict success:^(id obj) {
        
        MYLog(@"版本信息---%@",obj);
        if ([obj[@"code"] isEqualToString:@"0000"]) {//有版本更新
            if (![obj[@"data"] isKindOfClass:[NSNull class]]) {
                NSString *message = obj[@"data"][@"remark"] ;
               message = [message stringByReplacingOccurrencesOfString:@"#" withString:@"\n"];
                
                if ([obj[@"data"][@"deviceType"] isEqualToString:@"IOS"]) {
                    
                    if ([obj[@"data"][@"updateType"] isEqualToString:@"upgrade"]) {//强制升级
                        _showAllows =YES;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            __weak typeof(self) weakSelf = self;
                                _alertView = [[YJAlertView alloc] initWithTitle:@"版本更新" message:message];

                            [_alertView addButtonWithTitle:@"确定更新"];
                            
                            _alertView.handler = ^(int index) {
                                
                                [weakSelf gotoAppStoreUpdate:obj[@"data"][@"downloadUrl"]];
                            };
                            
                            [_alertView show];
                            
                            
                        });
                    } else {//非 强制升级
                        _showAllows =NO;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            __weak typeof(self) weakSelf = self;
                                _alertView = [[YJAlertView alloc] initWithTitle:@"版本更新" message:message];
                                
                            [_alertView addButtonWithTitle:@"取消"];
                            [_alertView addButtonWithTitle:@"确定更新"];
                            
                            _alertView.handler = ^(int index) {
                                switch (index) {
                                    case 0:
                                        
                                        break;
                                    case 1:
                                        [weakSelf gotoAppStoreUpdate:obj[@"data"][@"downloadUrl"]];
                                        break;
                                    default:
                                        break;
                                }
                                
                            };
                            
                            [_alertView show];
                        });
                    }
                    
                }
            }
        }else if ([obj[@"code"] isEqualToString:@"9999"]) { //无版本更新
            _showAllows =NO;
            MYLog(@"错误---%@",obj[@"msg"]);
        }else{
            MYLog(@"错误---%@",obj[@"msg"]);
        }
    } failure:^(NSError *error) {
        
        MYLog(@"错误---%@",error);
        
    }];
    
}


- (void)gotoAppStoreUpdate:(NSString *)downUrl {
//    if ([YJUserManagerTool user]) {
//        [YJUserManagerTool clearUserInfo];
//    }
    if ( [Tool objectForKey:iphoneSave]) {
        [Tool removeObjectForKey:iphoneSave];
    }
    
    if (downUrl.length>=1) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:downUrl]];
    }else{
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/li-mu-zheng-xin/id1144090091?mt=8"];
        [[UIApplication sharedApplication]openURL:url];
    }
}

#pragma mark---3DTouch


- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    if ([shortcutItem.type isEqualToString:@"com.TanNuo.LiMuZhengXin.search"]) {
        
        // 判断是否登录状态
        // 未登录的话，先登录再跳转
        
        MYLog(@"-----------");

        
        
    }
    
    
    
}

//创建应用图标上的3D touch快捷选项
- (void)creatShortcutItem {
    //创建系统风格的icon
//    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    
    //    //创建自定义图标的icon
    //    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"分享.png"];
    
    //创建快捷选项
    UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:@"com.TanNuo.LiMuZhengXin.search" localizedTitle:@"搜索" localizedSubtitle:@"公积金" icon:icon userInfo:nil];
    
    
    //添加到快捷选项数组
    [UIApplication sharedApplication].shortcutItems = @[item];
}




-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
