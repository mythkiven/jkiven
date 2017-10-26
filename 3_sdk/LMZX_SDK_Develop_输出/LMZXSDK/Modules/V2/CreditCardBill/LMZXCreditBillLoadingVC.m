//
//  LMZXCentralBankLoadingVC.m
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/3/10.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXCreditBillLoadingVC.h"

@interface LMZXCreditBillLoadingVC ()

@end

@implementation LMZXCreditBillLoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadCentralBank];
//    });
    
    
    
    switch (self.type) {
        case LMZXCreditCardBillMailTypeQQ:{
            self.title = @"QQ邮箱账单查询";
            break;
        }case LMZXCreditCardBillMailType126:{
            self.title = @"126邮箱账单查询";
            break;
        }case LMZXCreditCardBillMailType163:{
            self.title = @"163邮箱账单查询";
            break;
        }case LMZXCreditCardBillMailType139:{
            self.title = @"139邮箱账单查询";
            break;
        }case LMZXCreditCardBillMailTypesina:{
            self.title = @"新浪邮箱账单查询";
            break;
        }case LMZXCreditCardBillMailTypealiyun:{
            self.title = @"阿里云邮箱账单查询";
            break;
        }
        default:
            break;
    }
    
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.lmzxBaseSearchDataTool stopSearch];
}


#pragma mark -  加载 H5
- (void)loadCentralBank {
    __weak typeof(self) sself = self;
    
    self.lmzxBaseSearchDataTool.queryInfoModel = self.lmQueryInfoModel;
    if (self.type == LMZXCreditCardBillMailTypeQQ){ // 验证码可能是独立密码
       self.lmzxBaseSearchDataTool.queryInfoModel.checkTypeForSMS = LMZXCommonSendMsgTypeQQCredit;
    }else{
        self.lmzxBaseSearchDataTool.queryInfoModel.checkTypeForSMS = LMZXCommonSendMsgTypeNormal;
    }
            
    self.controlView.LoginTime = 10;
    self.controlView.checkDataTime = 100;
    self.controlView.LoginValue = 20;
    
    //////////// 开启动画
    [self.controlView beginAnimationCompleteBlock:^{}];
    
    //////////// 短信回调
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
            sself.controlView.isLoginSuccess =YES;
            // 如果设置了自动退出,那么此时应当停止轮训(OK), SDK 自动退出
            if ([LMZXSDK shared].lmzxQuitOnSuccess==NO) {
                [sself.controlView successAnimation:^{
                    // SDK 自动退出
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
                            // 回调登录状态 登录成功 + function + token
                            if ([LMZXSDK shared].lmzxResultBlock) {
                                [LMZXSDK shared].lmzxResultBlock(2,LMZXSDKFunctionCreditCardBill, nil, token);
                            }
                        }];
                    });
                }];
            }
           
        }
    };
    
    [self.lmzxBaseSearchDataTool searchCreditCardDataWithQueryInfo:self.lmQueryInfoModel  searchSuccess:^(id obj, NSDictionary *dic) {
        
        // 结束动画
        [sself.controlView successAnimation:^{
            
            // SDK 自动退出
            if ([LMZXSDK shared].lmzxQuitOnSuccess==YES) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:^{
                        
                        if ([LMZXSDK shared].lmzxResultBlock) {
                            [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionCreditCardBill, obj, dic[@"taskID"]);
                        }
                    }];
                    
                });
            }else{// 继续查询
                [sself jPopSelf];
                if ([LMZXSDK shared].lmzxResultBlock) {
                    [LMZXSDK shared].lmzxResultBlock(0,LMZXSDKFunctionCreditCardBill, obj, dic[@"taskID"]);
                }
            }
        }];
        
    } failure:^(NSString *error, NSInteger code, NSDictionary *dic) {
        // 失败结果回调
        NSString *taskID = @"" ;
        if (dic) { taskID = dic[@"taskID"]; }
        if ([LMZXSDK shared].lmzxResultBlock) {
            [LMZXSDK shared].lmzxResultBlock(code,LMZXSDKFunctionCreditCardBill, @"nil", taskID);
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
