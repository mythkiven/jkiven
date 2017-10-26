//
//  YJTaoBaoDataTool.m
//  CreditPlatform
//
//  Created by yj on 16/10/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTaoBaoDataTool.h"
#import "CommonSendMsgVC.h"

@interface YJTaoBaoDataTool ()<UITextFieldDelegate>
{
    UIAlertAction *_action1;

}

@end

@implementation YJTaoBaoDataTool

#pragma mark--轮循
- (void)requestData {
    
    __weak typeof(self) weakSelf = self;
    NSDictionary *dict2 = @{@"mobile":[kUserManagerTool mobile],
                            @"userPwd":[kUserManagerTool userPwd],
                            @"token":_token};
    __block NSString *status = nil;
    // 2.获取状态
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryInterfaceStatus] timeoutInterval:self.timeOut params:dict2 success:^(id responseObj) {
        MYLog(@"第二步拿到-------%@",responseObj);

        
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            status = responseObj[@"data"][@"code"];
            MYLog(@"第二步状态-------%@",status);
            if ([status isEqualToString:@"0000"]) { // 0000进入第三步
                
                NSDictionary *dict3 = @{@"mobile":[kUserManagerTool mobile],
                                        @"userPwd":[kUserManagerTool userPwd],
                                        @"token":_token,
                                        @"bizType":@"taobao",
                                        @"appVersion":VERSION_APP_1_3_3};
                // 3.获取查询结果
                [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryResult] params:dict3 success:^(id responseObj) {
                    MYLog(@"淘宝--第三步拿到-------%@",responseObj);
                    
                    if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                        
                        if (responseObj[@"data"][@"taobaoRespVo"]) {

                            if ([responseObj[@"data"][@"taobaoRespVo"][@"code"] isEqualToString:@"0000"]) {
                                [TalkingData trackEvent:@"淘宝查询成功" label:TalkingDataLabel];
                                weakSelf.searchSuccess(responseObj);
                            }else{
                                NSError *error = [NSError errorWithDomain:responseObj[@"data"][@"taobaoRespVo"][@"msg"] code:0 userInfo:nil];
                                weakSelf.searchFailure(error);
                            }
                            
                        }else{
                            NSError *error = [NSError errorWithDomain:responseObj[@"data"][@"taobaoRespVo"][@"msg"] code:0 userInfo:nil];
                            weakSelf.searchFailure(error);
                        }
                        
                        
                    } else {
                        if (weakSelf.searchFailure) {
                            weakSelf.searchFailure(nil);
                        }
                    }
                    
                    [weakSelf removeTimer];
                    
                } failure:^(NSError *error) {
                    MYLog(@"第三步第获淘宝数据失败-------%@",error);
                    if (weakSelf.searchFailure) {
                        weakSelf.searchFailure(nil);
                    }
                    
                    
                }];
                
            } else if ([status isEqualToString:@"0005"] || [status isEqualToString:@""]) { // 继续循环请求
                
            }  else if ([status isEqualToString:@"0001"]) { // 停止循环请求，发送验证码
                [weakSelf removeTimer];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf writeSMScodeToTextField:@"请输入短信验证码" message:@"验证码是6位数字"];
                });
                
                
            } else {
                
                if (weakSelf.searchFailure) {
                    NSError *error = [NSError errorWithDomain:responseObj[@"data"][@"msg"] code:0 userInfo:nil];
                    weakSelf.searchFailure(error);
                    [weakSelf removeTimer];
                }
            }
        }
        
    } failure:^(NSError *error) {
        if (weakSelf.searchFailure) {
            weakSelf.searchFailure(nil);
        }
    }];
}




#pragma mark--查询入口
- (void)searchTaoBaoDataSuccesssuccess:(void (^)(id obj))success failure:(void (^)(NSError *error))failure
{
    self.searchSuccess = success;
    //    self.searchFailure = failure;
    
    __weak typeof(self) weakSelf = self;
    
    
    NSDictionary *dict = @{ @"method":@"queryTaobao",
                            @"mobile":[kUserManagerTool mobile],
                            @"userPwd":[kUserManagerTool userPwd],
                            @"username":self.searchConditionModel.account,//需要填写真实帐号，此处为造数据
                            @"password":self.searchConditionModel.passWord,//央行征信账户密码
                            @"appVersion": VERSION_APP_1_3_3
                            };
    MYLog(@"%@",dict);
    // 1.获取taken
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryTaobao] timeoutInterval:self.timeOut params:dict success:^(id responseObj) {
        MYLog(@"第一步拿到token-------%@",responseObj);
        
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            
            _token = responseObj[@"data"][@"token"];
            if (_token) {
                if ([responseObj[@"data"][@"code"] isEqualToString:@"0010"]) {
                    [weakSelf addTimer];
                }
                
                
            }else{
                if (weakSelf.searchFailure && responseObj[@"data"][@"msg"]) {
                    NSError *error = [NSError errorWithDomain:responseObj[@"data"][@"msg"] code:0 userInfo:nil];
                    weakSelf.searchFailure(error);
                }
            }
            
        } else {
            if (weakSelf.searchFailure && responseObj[@"msg"]) {
                NSError *error = [NSError errorWithDomain:responseObj[@"msg"] code:0 userInfo:nil];
                weakSelf.searchFailure(error);
            }
        }
        
        
    } failure:^(NSError *error) {
        MYLog(@"第一步拿到token失败%@",error);
        // 检查信息
        if (weakSelf.searchFailure) {
            weakSelf.searchFailure(nil);
        }
        
    }];
    
}




#pragma mrak--短信验证
- (void)writeSMScodeToTextField:(NSString *)title message:(NSString *)msg {
    __weak typeof(self) weakSelf = self;
    CommonSendMsgVC *ss = [[CommonSendMsgVC alloc]init];
    ss.sendMsgType = CommonSendMsgTypeNormal;
    if ([NSString  isMobileNumber:self.searchConditionModel.account]) {
        ss.msg = self.searchConditionModel.account;
    }else{
        ss.msg = @"手机";
    }
    
    ss.Sure=^(id obj){
        [weakSelf sendSMS:obj];
    };
    ss.Cancel = ^(id obj){
        if (weakSelf.searchFailure) {
            NSError *error = [NSError errorWithDomain:@"用户取消操作" code:0 userInfo:nil];
            weakSelf.searchFailure(error);
        }
    };
    
//    YJNavigationController *nav = (YJNavigationController *)[UIViewController getCurrentVC];
//    [nav pushViewController:ss animated:YES];
    
    [[UIViewController getCurrentVC] presentViewController:[[YJNavigationController alloc] initWithRootViewController:ss] animated:YES completion:nil];
    
    
    // 弹框。。。
//    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:(UIAlertControllerStyleAlert)];
//    
//    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        MYLog(@"-----输入验证码");
//        textField.delegate = weakSelf;
//        textField.keyboardType = UIKeyboardTypeNumberPad;
//    }];
//    
//    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
//        // 失败操作
//        if (weakSelf.searchFailure) {
//            NSError *error = [NSError errorWithDomain:@"用户取消操作" code:0 userInfo:nil];
//            weakSelf.searchFailure(error);
//        }
//    }];
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//        // 下一步验证
//        UITextField *tf = alertVc.textFields[0];
//        
//        [self sendSMS:tf.text];
//
//
//    }];
//    _action1 = action1;
//    action1.enabled = NO;
//    [alertVc addAction:action0];
//    [alertVc addAction:action1];
//    
//    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//    
//    [window.rootViewController presentViewController:alertVc animated:YES completion:nil];
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    
    NSString * newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    MYLog(@"-------%d",[self isPureInt:textField.text]);
    
    
    if (newStr.length >= 6 && [self isPureInt:textField.text] ) {
        _action1.enabled = YES;
        
    }else {
        _action1.enabled = NO;
        
    }
    
    if (newStr.length>6) {
        return NO;
    }
    
    return YES;
}
/**
 *  是否为纯数字
 */
- (BOOL)isPureInt:(NSString *)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
    
}

#pragma mark--短信验证接口
- (void)sendSMS:(NSString *)smsCode {
    __weak typeof(self) weakSelf = self;
    

    NSDictionary *dic = @{  @"method":@"mobileSmsCheck",
                            @"mobile":[kUserManagerTool mobile],
                            @"userPwd":[kUserManagerTool userPwd],
                            @"username":self.searchConditionModel.account,
                            @"token":_token,
                            @"smsCode":smsCode
                            };
    
    // 2.获取状态
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_mobileSmsCheck] timeoutInterval:self.timeOut params:dic success:^(id responseObj) {
        MYLog(@"验证淘宝验证码：%@",responseObj);
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            if ([responseObj[@"data"][@"code"] isEqualToString:@"0000"]||[responseObj[@"data"][@"code"] isEqualToString:@"0009"]) {
                _token = responseObj[@"data"][@"token"];
                
                
                if (_token) {
                    [weakSelf addTimer];
                }else{
                    if (weakSelf.searchFailure) {
                        NSError *error = [NSError errorWithDomain:responseObj[@"data"][@"msg"] code:0 userInfo:nil];
                        weakSelf.searchFailure(error);
                    }
                }
                
            } else {
                if (weakSelf.searchFailure) {
                    NSError *error = [NSError errorWithDomain:responseObj[@"data"][@"msg"] code:0 userInfo:nil];
                    weakSelf.searchFailure(error);
                }
            }
        }else{
            if (weakSelf.searchFailure) {
                NSError *error = [NSError errorWithDomain:responseObj[@"msg"] code:0 userInfo:nil];
                weakSelf.searchFailure(error);
            }
        }
        
    } failure:^(NSError *error) {
        MYLog(@"-------4淘宝短信验证 失败-------");
        self.searchFailure(error);
    }];

    
}


@end
