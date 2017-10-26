//
//  LMZXAutoInsuranceLoadingVC.m
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/3/8.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXBankBillLoadingVC.h"
#import "UIViewController+LMZXBackButtonHandler.h"
@interface LMZXBankBillLoadingVC ()

@end

@implementation LMZXBankBillLoadingVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadAutoInsurance];
//    });
    
    
    self.title = @"网银流水查询";
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.lmzxBaseSearchDataTool stopSearch];
}
#pragma mark-- 加载车险
- (void)loadAutoInsurance {
    __weak typeof(self) sself = self;
    // 开启动画
    [self.controlView beginAnimationCompleteBlock:^{
        
    }];
    
    //////////////// 短信回调
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
                [sself.controlView successAnimation:^{
                    // SDK 自动退出
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
                            // 回调登录状态 登录成功 + function + token
                            if ([LMZXSDK shared].lmzxResultBlock) {
                                [LMZXSDK shared].lmzxResultBlock(2,LMZXSDKFunctionEBankBill, nil, token);
                            }
                        }];
                    });
                }];
            }else{
                // 不自动退出,继续等待,可以继续查询
            }
        }
    };
    
    
    
    ///////////// 请求数据
    [self.lmzxBaseSearchDataTool searchEBankDataWithQueryInfo:self.lmQueryInfoModel searchSuccess:^(id obj, NSDictionary *dic) {
       
        // 结束动画
        [sself.controlView successAnimation:^{
            
            // SDK 自动退出
            if ([LMZXSDK shared].lmzxQuitOnSuccess==YES) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
                        if ([LMZXSDK shared].lmzxResultBlock) {
                            [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionEBankBill, obj, dic[@"taskID"]);
                        }
                    }];
                    
                });
            }else{
                // 继续查询
                [sself jPopSelf];
                if ([LMZXSDK shared].lmzxResultBlock) {
                    [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionEBankBill, obj, dic[@"taskID"]);
                }
            }
        }];

        
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        
        // 失败结果回调
        NSString *taskID = @"" ;
        if (dic) { taskID = dic[@"taskID"]; }
        if ([LMZXSDK shared].lmzxResultBlock) {
            [LMZXSDK shared].lmzxResultBlock(code,LMZXSDKFunctionEBankBill, @"nil", taskID);
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
@end
