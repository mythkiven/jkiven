//
//  LMZXHouseFundLoadingVC.m
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/2/23.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXHouseFundLoadingVC.h"

@interface LMZXHouseFundLoadingVC ()

@end

@implementation LMZXHouseFundLoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.searchType == SearchItemTypeSocialSecurity) {
        self.title = @"社保";
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self loadSocialSecurity];
//        });
        
    } else if (self.searchType == SearchItemTypeHousingFund) {
        self.title = @"公积金";
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self loadHouseFund];
//        });
    }
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.lmzxBaseSearchDataTool stopSearch];
}

#pragma mark-- 加载社保
- (void)loadSocialSecurity {
    
    self.controlView.LoginTime = 10;
    self.controlView.checkDataTime = 20;
    self.controlView.LoginValue = 20;
    
    __weak typeof(self) weakSelf = self;
    // 开启动画
    [self.controlView beginAnimationCompleteBlock:^{
        
    }];
    
    //////////// 登录成功回调:
    self.lmzxBaseSearchDataTool.loginStatus = ^(NSInteger status,NSString *token){
        if (status == 0) {
            weakSelf.controlView.isLoginSuccess =YES;
            
        
            // 如果设置了自动退出,那么此时应当停止轮训(OK), SDK 自动退出
            if ([LMZXSDK shared].lmzxQuitOnSuccess==NO) {
                // 结束动画
                [weakSelf.controlView successAnimation:^{
                    
                    // SDK 自动退出
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
                            // 回调登录状态 登录成功 + function + token
                            if ([LMZXSDK shared].lmzxResultBlock) {
                                [LMZXSDK shared].lmzxResultBlock(2,LMZXSDKFunctionSocialSecurity, nil, token);
                            }
                        }];
                    });
                }];
            }else{
                // 不自动退出,继续等待,可以继续查询
            }
        
        }
    };
    
    // 请求数据
    [self.lmzxBaseSearchDataTool searchSocialSecturityDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
        
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf.controlView successAnimation:nil];
//        });
//        
//        if ([LMZXSDK shared].lmzxResultBlock) {
//            NSString *taskID = @"" ;
//            if (dic) {
//                taskID = dic[@"taskID"];
//            }
//            [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionHousingFund, obj, taskID);
//        }
        
        // 结束动画
        [weakSelf.controlView successAnimation:^{
            
            // SDK 自动退出
            if ([LMZXSDK shared].lmzxQuitOnSuccess==YES) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
                        if ([LMZXSDK shared].lmzxResultBlock) {
                            [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionSocialSecurity, obj, dic[@"taskID"]);
                        }
                    }];
                    
                });
            }else{
                // 继续查询
                [weakSelf jPopSelf];
                if ([LMZXSDK shared].lmzxResultBlock) {
                    [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionSocialSecurity, obj, dic[@"taskID"]);
                }
            }
        }];
        
        
    } failure:^(NSString *error, NSInteger code,NSDictionary *dic) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf.controlView endAnimation];
//            
//        });
//        
//        [weakSelf.view makeToast:error];
//        
//        NSString *taskID = @"" ;
//        if (info) { taskID = info[@"taskID"]; }
//        if ([LMZXSDK shared].lmzxResultBlock) {
//            [LMZXSDK shared].lmzxResultBlock(type,LMZXSDKFunctionHousingFund, @"nil", taskID);
//        }
//        
//        [weakSelf jOutSelf];
//
        // 失败结果回调
        NSString *taskID = @"" ;
        if (dic) { taskID = dic[@"taskID"]; }
        if ([LMZXSDK shared].lmzxResultBlock) {
            [LMZXSDK shared].lmzxResultBlock(code,LMZXSDKFunctionSocialSecurity, @"nil", taskID);
        }
        
        // UI 处理
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.controlView endAnimation];
            [weakSelf.view makeToast:error];
            // 失败退出 SDK
            if ([LMZXSDK shared].lmzxQuitOnFail ) {
                [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
            }else{
                [weakSelf jPopSelf];
            }
        });
    }];
    

    
}

#pragma mark-- 加载公积金
- (void)loadHouseFund {
    __weak typeof(self) weakSelf = self;
    // 开启动画
    [self.controlView beginAnimationCompleteBlock:^{
        
    }];
    
    //////////// 登录成功回调:
    self.lmzxBaseSearchDataTool.loginStatus = ^(NSInteger status,NSString *token){
        if (status == 0) {
            weakSelf.controlView.isLoginSuccess =YES;
            
            
            // 如果设置了自动退出,那么此时应当停止轮训(OK), SDK 自动退出
            if ([LMZXSDK shared].lmzxQuitOnSuccess==NO) {
                // 结束动画
                [weakSelf.controlView successAnimation:^{
                    
                    // SDK 自动退出
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
                            // 回调登录状态 登录成功 + function + token
                            if ([LMZXSDK shared].lmzxResultBlock) {
                                [LMZXSDK shared].lmzxResultBlock(2,LMZXSDKFunctionHousingFund, nil, token);
                            }
                        }];
                    });
              }];
            }else{
                // 不自动退出,继续等待,可以继续查询
            }
            
        }
    };
    
    // 请求数据
    [self.lmzxBaseSearchDataTool searchHouseFoundDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj,NSDictionary *dic) {
       
        // 结束动画
        [weakSelf.controlView successAnimation:^{
            
            // SDK 自动退出
            if ([LMZXSDK shared].lmzxQuitOnSuccess==YES) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
                        if ([LMZXSDK shared].lmzxResultBlock) {
                            [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionHousingFund, obj, dic[@"taskID"]);
                        }
                    }];
                    
                });
            }else{
                // 继续查询
                [weakSelf jPopSelf];
                if ([LMZXSDK shared].lmzxResultBlock) {
                    [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionHousingFund, obj, dic[@"taskID"]);
                }
            }
        }];
        
        
    } failure:^(NSString*error,NSInteger code,NSDictionary *dic) {
        
        // 失败结果回调
        NSString *taskID = @"" ;
        if (dic) { taskID = dic[@"taskID"]; }
        if ([LMZXSDK shared].lmzxResultBlock) {
            [LMZXSDK shared].lmzxResultBlock(code,LMZXSDKFunctionHousingFund, @"nil", taskID);
        }
        
        // UI 处理
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.controlView endAnimation];
            [weakSelf.view makeToast:error];
            // 失败退出 SDK
            if ([LMZXSDK shared].lmzxQuitOnFail ) {
                [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
            }else{
                [weakSelf jPopSelf];
            }
        });
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 
 MID( "*"&$A1&"*" , FIND("#",SUBSTITUTE("*"&$A1&"*","*","#",COLUMN(A:A) ))+1,   		)
 
 
 
 
*/

@end
