//
//  OperatorsDataTool.m
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/8/3.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "OperatorsDataTool.h"

@implementation OperatorsDataTool
{
//    NSString *_yzm;
   __block NSString *token_;
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark 2 轮训
- (void)requestData {
    
    __block NSString *status = nil;
    __weak typeof(self) weakSelf = self;
    NSDictionary *dict2 = @{@"method":urlJK_queryInterfaceStatus,
                            @"mobile":kUserManagerTool.mobile,
                            @"userPwd":kUserManagerTool.userPwd,
                            @"token":token_};
    
    
    
    // 2.获取状态
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryInterfaceStatus] timeoutInterval:self.timeOut params:dict2 success:^(id responseObj) {
        MYLog(@"222222----------%@",responseObj);
        if (responseObj[@"data"]) {//1---
            status = responseObj[@"data"][@"code"];
            token_ = responseObj[@"data"][@"token"];
            if ([status isEqualToString:@"0000"]) { //1--1----无验证码成功。
                [Tool removeObjectForKey:tokensaveOnce];
                [Tool setObject:token_ forKey:tokensaveOnce];
                [weakSelf removeTimer];
                if ([responseObj[@"data"][@"msg"] isEqualToString:@"重置密码成功"]) {//考虑特殊情况
                    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_OperationShow_88_3meaasga object:@"1"];
                    
                }else{
                    NSDictionary *dict3 = @{@"method":urlJK_queryResult,
                                            @"mobile":kUserManagerTool.mobile,
                                            @"userPwd":kUserManagerTool.userPwd,
                                            @"token":token_,
                                            @"bizType":@"mobile",
                                            @"appVersion":VERSION_APP_1_4_3};
                    // 3.获取查询结果
                    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryResult] params:dict3 success:^(id responseObj) {
                        MYLog(@"KOK--------%@",responseObj);
                        if ([responseObj[@"data"][@"code"] isEqualToString:@"0000"]) {
                            if ([responseObj[@"data"][@"code"] isEqualToString:@"0000"]) {
                               
                                [TalkingData trackEvent:@"运营商查询成功" label:TalkingDataLabel];
                                
                                weakSelf.searchSuccess(responseObj);
                                
                            }else{
                                if (responseObj[@"data"][@"msg"]) {
                                    [weakSelf showError:responseObj[@"data"][@"msg"]];
                                } else {
                                    [weakSelf showError:@"数据请求失败" ];
                                }
                            }
                            
                        }else{
                            [weakSelf showError:responseObj[@"data"][@"msg"]];
                        }
                        
                    } failure:^(NSError *error) {
                        MYLog(@"第三步第获取数据失败-------");
                        self.searchFailure(error);
                    }];
                }
                
            }else if(status.length&&([status isEqualToString:@"0001"])){//1---1---发送短信成功
                //发送通知，需要显示验证码：
                if (_isfrom == 91) {//【弃用】点击重新发送验证码 对应在 验证码页面
                    [weakSelf removeTimer];
                    [Tool removeObjectForKey:tokensaveOnce];
                    [Tool setObject:token_ forKey:tokensaveOnce];
                }
                else if (_isfrom == 88) {//【弃用】重置运营商密码 对应的 短信验证码
                    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_OperationShow_88meaasga object:nil];
                    [weakSelf removeTimer];
                    [Tool removeObjectForKey:tokensaveOnce];
                    [Tool setObject:token_ forKey:tokensaveOnce];
                }
                else if (_isfrom == 81) {//【弃用】重置运营商密码 对应的 短信验证码
                    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_OperationShow_81meaasga object:nil];
                    [weakSelf removeTimer];
                    [Tool removeObjectForKey:tokensaveOnce];
                    [Tool setObject:token_ forKey:tokensaveOnce];
                }
                else{ // 正常的验证码都在此：
                    
                    [weakSelf removeTimer];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_OperationShow_sendMeaasga object:nil];
                    [Tool removeObjectForKey:tokensaveOnce];
                    [Tool setObject:token_ forKey:tokensaveOnce];
                }
                
                
            }else if([status isEqualToString:@"0002"]){//【弃用】1---2----- 输入新密码
                if (_isfrom == 88) {//重置密码 后一页面
                    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_OperationShow_88_2meaasga object:nil];
                    [weakSelf removeTimer];
                    [Tool removeObjectForKey:tokensaveOnce];
                    [Tool setObject:token_ forKey:tokensaveOnce];
                } else if (_isfrom == 81) {//前一页面
                    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_OperationShow_81_2meaasga object:nil];
                    [weakSelf removeTimer];
                    [Tool removeObjectForKey:tokensaveOnce];
                    [Tool setObject:token_ forKey:tokensaveOnce];
                }
            }else if([status isEqualToString:@"0004"]){//【弃用】1---4----- 重置密码成功
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_OperationShow_88_3meaasga object:@"1"];;
                
                [weakSelf removeTimer];
                [Tool removeObjectForKey:tokensaveOnce];
                [Tool setObject:token_ forKey:tokensaveOnce];
            }else if([status isEqualToString:@"0009"]){//1---9----- 写入短信成功 中间状态
                
            }else if(status.length){//账户问题，直接抛出 1-----7----
                [weakSelf showError:responseObj[@"data"][@"msg"] ];
                
            }
        }
        
    } failure:^(NSError *error) {
        MYLog(@"第二步状态获取失败-------");
        self.searchFailure(error);
        
    }];
}

#pragma mark - 运营商 发送验证码
- (void)messageInfo:(NSDictionary *)dic OperatorsDataMeaasgasuccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    self.searchSuccess = success;
    self.searchFailure = failure;
    NSDictionary *dict2;
    token_ = [Tool objectForKey:tokensaveOnce];
    if (!dic) {
        dict2 =@{ @"method":urlJK_mobileSmsCheck,
                                @"mobile":kUserManagerTool.mobile,
                                @"userPwd":kUserManagerTool.userPwd,
                                @"token":token_,
                                @"smsCode":_info};
    }else{
        dict2 = dic;
    }
   
     __weak typeof(self) weakSelf = self;
    MYLog(@"%@",dict2);
    // 2.获取状态
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_mobileSmsCheck] timeoutInterval:self.timeOut params:dict2 success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        if (responseObj[@"data"]) {
 
            if ([responseObj[@"data"][@"code"] isEqualToString:@"0000"]|[responseObj[@"data"][@"code"] isEqualToString:@"0009"]) {
                token_ = responseObj[@"data"][@"token"];
                [Tool removeObjectForKey:tokensaveOnce];
                [Tool setObject:token_ forKey:tokensaveOnce];
                if (token_) {
                    [weakSelf addTimer];
                }
            } else {
                [weakSelf showError:responseObj[@"data"][@"msg"] ];
                
            }
        } else {
            [weakSelf showError:responseObj[@"msg"] ];
        }
        
    } failure:^(NSError *error) {
        self.searchFailure(error);
    }];
}


#pragma mark - 查询运营商信息
- (void)searchInfo:(NSDictionary *)dic OperatorsDataSuccesssuccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    self.searchSuccess = success;
    self.searchFailure = failure;
    __weak typeof(self) weakSelf = self;
    

    
    NSDictionary *dict = @{
                           @"method":urlJK_queryMobile,
                           @"mobile":kUserManagerTool.mobile,
                           @"userPwd":kUserManagerTool.userPwd,
                           @"username":self.searchConditionModel.account ,
                           @"password":self.searchConditionModel.passWord ,
                           @"otherInfo":self.searchConditionModel.servicePass };//服务密码
    
    MYLog(@"%@",dict);
    // 1.获取taken
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryMobile] timeoutInterval:self.timeOut params:dict success:^(id responseObj) {
        MYLog(@"111111--------%@",responseObj);
        if (responseObj[@"data"] && [responseObj[@"code"] isEqualToString:@"0000"]) {
            if ([responseObj[@"data"][@"code"] isEqualToString:@"0010"]) {
                token_ = responseObj[@"data"][@"token"];
                [Tool setObject:token_ forKey:tokensaveOnce];
                if (token_) {
                    [weakSelf addTimer];
                }else {
                    [weakSelf showError:responseObj[@"data"][@"msg"] ];
                }
            } else {
                [weakSelf showError:responseObj[@"data"][@"msg"] ];
            }
        } else {
            [weakSelf showError:responseObj[@"msg"] ];
            
        }
        
    } failure:^(NSError *error) {
        MYLog(@"第一步拿到token失败");
        self.searchFailure(error);
    }];
    
}

-(void)showError:(NSString*)str{
    [self removeTimer];
    NSError *error = [NSError errorWithDomain:str code:ErrorCodeNormal userInfo:nil];
    self.searchFailure(error);
    
}

#pragma mark -
#pragma mark - 弃用

#pragma mark 密码修改接口-重置密码
- (void)resetInfo:(NSDictionary *)dic OperatorsData:(void (^)(id))success failure:(void (^)(NSError *))failure {
    self.searchSuccess = success;
    self.searchFailure = failure;
    __weak typeof(self) weakSelf = self;
    //    __block typeof(token_) token__ = token_;
    
    
    MYLog(@"%@",dic);
    // 1.获取taken
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,dic[@"method"]] timeoutInterval:self.timeOut params:dic success:^(id responseObj) {
        MYLog(@"-----11111---%@",responseObj);
        if (responseObj[@"data"]) {
            if ([responseObj[@"data"][@"code"] isEqualToString:@"0010"]|[responseObj[@"data"][@"code"] isEqualToString:@"0000"]|[responseObj[@"data"][@"code"] isEqualToString:@"0009"]) {
                token_ = responseObj[@"data"][@"token"];
                [Tool setObject:token_ forKey:tokensaveOnce];
                if (token_) {
                    [weakSelf addTimer];
                }
            } else {
                [weakSelf showError:responseObj[@"data"][@"msg"] ];
                
//                [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_Operationerror_meaasga object: nil userInfo:@{@"key":responseObj[@"data"][@"msg"],@"isOut":@"0"}];
            }
        } else {
            [weakSelf showError:responseObj[@"data"][@"msg"] ];
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_Operationerror_meaasga object: nil userInfo:@{@"key":responseObj[@"msg"],@"isOut":@"0"}];
        }
        
    } failure:^(NSError *error) {
        MYLog(@"第一步拿到token失败");
        self.searchFailure(error);
//        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_Operationerror_meaasga object: nil userInfo:@{@"key":@"请求失败，请重新尝试",@"isOut":@"0"}];
        
    }];
    
}

@end
