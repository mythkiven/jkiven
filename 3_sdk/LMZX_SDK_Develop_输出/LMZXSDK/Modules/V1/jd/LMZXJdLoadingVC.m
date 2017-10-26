//
//  LMZXJdLoadingVC.m
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/2/23.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXJdLoadingVC.h"
#import "UIViewController+LMZXBackButtonHandler.h"

@interface LMZXJdLoadingVC ()

@end

@implementation LMZXJdLoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadJD];
//    });
    
    
    
    self.title = @"京东查询";
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.lmzxBaseSearchDataTool stopSearch];
}

#pragma mark-- 加载京东
- (void)loadJD {
    __weak typeof(self) sself = self;
    // 开启动画
    [self.controlView beginAnimationCompleteBlock:^{
        
    }];
    
    // 短信回调
    self.lmzxBaseSearchDataTool.smsVerification = ^(NSInteger type,NSInteger code){
        
        // 验证码:
        if (code == 0) {
            [sself.controlView endAnimation];
            
        }else if (code == 1) {
            [sself.controlView reBeginAnimationCompleteBlock:^{
                
            }];
            
        }
    };
    //////////// 登录成功回调:
    self.lmzxBaseSearchDataTool.loginStatus = ^(NSInteger status,NSString *token){
        if (status == 0) {
            sself.controlView.isLoginSuccess =YES;
            
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
    
    // 请求数据
    [self.lmzxBaseSearchDataTool searchJdDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
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
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        
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
*/

@end
