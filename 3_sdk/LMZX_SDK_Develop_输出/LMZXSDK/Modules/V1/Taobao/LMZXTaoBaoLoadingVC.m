//
//  JLoadingReportVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXTaoBaoLoadingVC.h"

#import "UIViewController+LMZXBackButtonHandler.h"

@interface LMZXTaoBaoLoadingVC ()

@end

@implementation LMZXTaoBaoLoadingVC
{
    
//    LMZXPopTextFiledView *_jPopTextFiledView;
    BOOL beginLogin;
//    id copySelf;
    BOOL _searchSuccess;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.type) {
        case 1:
            self.title = @"淘宝查询";
            break;
        case 2:
            self.title = @"京东查询";
            break;
            
        default:
            break;
    }
    
    
    
    
}
// 页面消失,终止轮训..否则... 再次进入可能会有多个验证框...
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    if (!_searchSuccess && self.lmzxBaseSearchDataTool.isSearch) {
    if (!_searchSuccess) {
        [self.lmzxBaseSearchDataTool stopSearch];
    }
    
    //    [_operatorsDataTool removeTimer];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _searchSuccess = NO;
    
    
    if (!beginLogin) {
        beginLogin = YES;
//        self.controlView.title = @"账户登录中";
        [self.controlView beginAnimationCompleteBlock:^{ }];
        //#warning  test
        //        [self testAPI];
        
        switch (self.type) {
            case 1:{
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self sendNetwork];
//                });
                
                break;
            }case 2:{
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self sendJDNetwork];
//                });
                
                break;
                
            }default:
                break;
        }
        
        
    }
    
}

#pragma mark -  网络轮训查询

-(void)sendJDNetwork{
    
    
    self.controlView.LoginTime = 15;
    self.controlView.checkDataTime = 20;
    self.controlView.LoginValue = 20;
    
    __block typeof(self) sself = self;
    self.lmzxBaseSearchDataTool.queryInfoModel = self.lmQueryInfoModel;
    
    ////////////////// 短信回调
    self.lmzxBaseSearchDataTool.smsVerification = ^(NSInteger type,NSInteger code){
        
        // 验证码:
        if (code == 0) {
            [sself.controlView endAnimation];
            
        }else if (code == 1) {
            [sself.controlView reBeginAnimationCompleteBlock:^{ }];
            
        }
    };
    
    //////////// 登录成功回调:
    self.lmzxBaseSearchDataTool.loginStatus = ^(NSInteger status,NSString *token){
         
        if (status == 0) {
            sself.controlView.isLoginSuccess = YES;
            // 如果设置了自动退出,那么此时应当停止轮训(OK), SDK 自动退出
            if ([LMZXSDK shared].lmzxQuitOnSuccess==NO) {
                
                // 结束动画
                [sself.controlView successAnimation:^{
                    // SDK 自动退出
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
                            // 回调登录状态 登录成功 + function + token
                            if ([LMZXSDK shared].lmzxResultBlock) {
                                [LMZXSDK shared].lmzxResultBlock(2,LMZXSDKFunctionJD, nil, token);
                            }
                        }];
                    });
                    
                }];

               
                
            }else{
                // 不自动退出,继续等待,可以继续查询
            }
        }
    };
    
    
    //////////// 查询成功/失败回调:
    [self.lmzxBaseSearchDataTool searchJdDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj,NSDictionary *dic) {
        
        // 结束动画
        [sself.controlView successAnimation:^{
            
            // SDK 自动退出
            if ([LMZXSDK shared].lmzxQuitOnSuccess==YES) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
                        if ([LMZXSDK shared].lmzxResultBlock) {
                            [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionJD, obj, dic[@"taskID"]);
                        }
                    }];
                    
                });
            }else{
                // 继续查询
                [sself jPopSelf];
                if ([LMZXSDK shared].lmzxResultBlock) {
                    [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionJD, obj, dic[@"taskID"]);
                }
            }
        }];
        
    } failure:^(NSString*error,NSInteger code,NSDictionary *dic) {
        
        // 失败结果回调
        NSString *taskID = @"" ;
        if (dic) { taskID = dic[@"taskID"]; }
        if ([LMZXSDK shared].lmzxResultBlock) {
            [LMZXSDK shared].lmzxResultBlock(code,LMZXSDKFunctionJD, @"nil", taskID);
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


#pragma mark -  网络轮训查询

-(void)sendNetwork{
    
    self.controlView.LoginTime = 15;
    self.controlView.checkDataTime = 45;
    self.controlView.LoginValue = 20;
    
    __block typeof(self) sself = self;
    self.lmzxBaseSearchDataTool.queryInfoModel = self.lmQueryInfoModel;
    
    // 短信回调
    self.lmzxBaseSearchDataTool.smsVerification = ^(NSInteger type,NSInteger code){
        
        // 验证码:
        if (code == 0) {
            [sself.controlView endAnimation];
            
        }else if (code == 1) {
            [sself.controlView reBeginAnimationCompleteBlock:^{ }];
            
        }
    };
    
    
    //////////// 登录成功回调:
    self.lmzxBaseSearchDataTool.loginStatus = ^(NSInteger status,NSString *token){
        if (status == 0) {
            sself.controlView.isLoginSuccess = YES;
            
            // 如果设置了自动退出,那么此时应当停止轮训(OK), SDK 自动退出
            if ([LMZXSDK shared].lmzxQuitOnSuccess==NO) {
                
                
                // 结束动画
                [sself.controlView successAnimation:^{
                    // SDK 自动退出
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // 回调登录状态 登录成功 + function + token
                            if ([LMZXSDK shared].lmzxResultBlock) {
                                [LMZXSDK shared].lmzxResultBlock(2,LMZXSDKFunctionTaoBao, nil, token);
                            }
                        });
                    });
                     
                }];
                
                
                
            }else{
                // 不自动退出,继续等待,可以继续查询
            }
        }
    };

    
    [self.lmzxBaseSearchDataTool searchTaobaoDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj,NSDictionary *dic) {

        // 结束动画
        [sself.controlView successAnimation:^{
            
            // SDK 自动退出
            if ([LMZXSDK shared].lmzxQuitOnSuccess==YES) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
                        if ([LMZXSDK shared].lmzxResultBlock) {
                            [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionTaoBao, obj, dic[@"taskID"]);
                        }
                    }];
                    
                });
            }else{
                // 继续查询
                [sself jPopSelf];
                if ([LMZXSDK shared].lmzxResultBlock) {
                    [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionTaoBao, obj, dic[@"taskID"]);
                }
            }
        }];
        
    } failure:^(NSString*error,NSInteger code,NSDictionary *dic) {
        
        // 失败结果回调
        NSString *taskID = @"" ;
        if (dic) { taskID = dic[@"taskID"]; }
        if ([LMZXSDK shared].lmzxResultBlock) {
            [LMZXSDK shared].lmzxResultBlock(code,LMZXSDKFunctionTaoBao, @"nil", taskID);
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
