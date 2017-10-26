//
//  JLoadingReportVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXMobilCarrieLoadingAnimationVC.h"

#import "UIViewController+LMZXBackButtonHandler.h"
@interface LMZXMobilCarrieLoadingAnimationVC ()

@end

@implementation LMZXMobilCarrieLoadingAnimationVC
{
    
    BOOL beginLogin;
    BOOL _searchSuccess;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"运营商查询";
    
    if ([LMZXSDK shared].lmzxPageBackgroundColor) {
        self.view.backgroundColor = [LMZXSDK shared].lmzxPageBackgroundColor;
    }else{
        self.view.backgroundColor = LM_RGB(245, 245, 245);
    }
    
    beginLogin = NO;
    
//    LMLog(@"444");
}
// 页面消失,终止轮训..否则... 再次进入可能会有多个验证框...
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.lmzxBaseSearchDataTool stopSearch];
    
}
//-(void)viewDidAppear:(BOOL)animated{
////    LMLog(@"666");
//}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _searchSuccess = NO;
    
//    LMLog(@"555");
    if (!beginLogin) {
        beginLogin = YES;
        [self.controlView beginAnimationCompleteBlock:^{ }];
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self sendNetwork];
//        });
        
    }
    
}



#pragma mark -  网络轮训查询

-(void)sendNetwork{
    
    if ([LMZXSDK shared].lmzxQuitOnSuccess==NO) {
        self.controlView.LoginTime = 40;
        self.controlView.checkDataTime = 5;
        self.controlView.LoginValue = 20;
    } else {
        self.controlView.LoginTime = 20;
        self.controlView.checkDataTime = 45;
        self.controlView.LoginValue = 20;
    }
    
    
    
    __block typeof(self) sself = self;
    self.lmzxBaseSearchDataTool.queryInfoModel = self.lmQueryInfoModel;
    if (self.lmzxBaseSearchDataTool.queryInfoModel.checkTypeForSMS == LMZXCommonSendMsgTypeJLDX) {
    } else {
        self.lmzxBaseSearchDataTool.queryInfoModel.checkTypeForSMS = LMZXCommonSendMsgTypePhone;
    }
    
    ///////////////  短信回调
    self.lmzxBaseSearchDataTool.smsVerification = ^(NSInteger type,NSInteger code){
//        LMLog(@"---->验证码--01--");
        // 弹出验证码 暂停动画
        if (code == 0) {
            [sself.controlView endAnimation];
        }else if (code == 1) {
        // 验证码输入完成 开始动画
            [sself.controlView reBeginAnimationCompleteBlock:^{ }];
            
        }
    };
    
    //////////// 登录成功回调:
    self.lmzxBaseSearchDataTool.loginStatus = ^(NSInteger status,NSString *token){
        if (status == 0) {
            sself.controlView.isLoginSuccess =YES;
            
                // 如果设置了自动退出,那么此时应当停止轮训(OK), SDK 自动退出
                if ([LMZXSDK shared].lmzxQuitOnSuccess==NO) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 结束动画
                        [sself.controlView successAnimation:^{
                            // SDK 自动退出
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
                                
                                // 回调登录状态 登录成功 + function + token
                                if ([LMZXSDK shared].lmzxResultBlock) {
                                    [LMZXSDK shared].lmzxResultBlock(2,LMZXSDKFunctionMobileCarrie, nil, token);
                                }
                                
                            });
                        }];
                    });
                    
                    
                }else{
                // 不自动退出,继续等待,可以继续查询
                }
            
            
        }
    };
    
    //////////// 查询成功/失败回调:
    [self.lmzxBaseSearchDataTool searchMobileDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj,NSDictionary *dic) {
        
        _searchSuccess = YES;
//        LMLog(@"ttmmie0");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 结束动画
            [sself.controlView successAnimation:^{
                // SDK 自动退出
                if ([LMZXSDK shared].lmzxQuitOnSuccess==YES) {
//                    LMLog(@"ttmmie1");
                    
                    
                    // SDK 自动退出
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // 回调登录状态 登录成功 + function + token
                            if ([LMZXSDK shared].lmzxResultBlock) {
                                [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionMobileCarrie, obj, dic[@"taskID"]);
                            }
                        });
                    });
//                    
//                    [sself dismissViewControllerAnimated:YES completion:^{
//                        LMLog(@"ttmmie2");
//                        if ([LMZXSDK shared].lmzxResultBlock) {
//                            [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionMobileCarrie, obj, dic[@"taskID"]);
//                        }
//                     }];
                    
//                    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
//                        if ([LMZXSDK shared].lmzxResultBlock) {
                   // LMLog(@"ttmmie3");
//                            [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionMobileCarrie, obj, dic[@"taskID"]);
//                        }
//                    }];
                  
                    
                }else{
                 // 继续查询
                    [sself jPopSelf];
                    if ([LMZXSDK shared].lmzxResultBlock) {
                        [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionMobileCarrie, obj, dic[@"taskID"]);
                    }
                }
                }];
            });
        
        
    } failure:^(NSString*error,NSInteger code,NSDictionary *dic) {
        
        // 失败结果回调
        NSString *taskID = @"" ;
        if (dic) { taskID = dic[@"taskID"]; }
        if ([LMZXSDK shared].lmzxResultBlock) {
            [LMZXSDK shared].lmzxResultBlock(code,LMZXSDKFunctionMobileCarrie, @"nil", taskID);
        }
        
        // UI 处理
        dispatch_async(dispatch_get_main_queue(), ^{
            [sself.controlView endAnimation];
            [sself.view makeToast:error];
            // 失败退出 SDK
            if ([LMZXSDK shared].lmzxQuitOnFail ) {
                [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
            }else{
                [sself jPopSelf];
            }
        });
        
        
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
