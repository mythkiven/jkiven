//
//  YJTaoBaoDataTool.m
//  CreditPlatform
//
//  Created by yj on 16/10/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCarInsuranceTool.h"
#import "CommonSendMsgVC.h"

@interface YJCarInsuranceTool ()<UITextFieldDelegate>
{
    UIAlertAction *_action1;

}

@end

@implementation YJCarInsuranceTool

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
                                        @"bizType":kBizType_autoinsurance,
                                        @"appVersion":VERSION_APP_1_4_1};
                // 3.获取查询结果
                [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryResult] params:dict3 success:^(id responseObj) {
                    MYLog(@"车险--第三步拿到-------%@",responseObj);
                    
                    if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                        
                        if ([responseObj[@"data"][@"code"]  isEqualToString:@"0000"]) {
                            [TalkingData trackEvent:@"车险查询成功" label:TalkingDataLabel];
                            weakSelf.searchSuccess(responseObj);
                        } else {
                            NSError *error = [NSError errorWithDomain:responseObj[@"data"][@"msg"] code:0 userInfo:nil];
                            weakSelf.searchFailure(error);
                        }
    
                        
                    } else {
                        if (weakSelf.searchFailure) {
                            weakSelf.searchFailure(nil);
                        }
                    }
                    
                    [weakSelf removeTimer];
                    
                } failure:^(NSError *error) {
                    MYLog(@"第三步第获车险数据失败-------%@",error);
                    if (weakSelf.searchFailure) {
                        weakSelf.searchFailure(nil);
                    }
                    
                    
                }];
                
            } else if ([status isEqualToString:@"0005"] || [status isEqualToString:@""]) { // 继续循环请求
                
            }  else {
                
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
- (void)searchCarInsuranceDataSuccesssuccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    self.searchSuccess = success;
    //    self.searchFailure = failure;
    
    __weak typeof(self) weakSelf = self;
    
    NSInteger index = self.searchConditionModel.searchType;
    NSDictionary *dict = @{ @"method":urlJK_queryAutoinsurance,
                            @"mobile":[kUserManagerTool mobile],
                            @"userPwd":[kUserManagerTool userPwd],
                            @"username":index==1?self.searchConditionModel.account:@"",
                            @"password":index==1?self.searchConditionModel.passWord:@"",
                            @"appVersion":VERSION_APP_1_4_1,
                            @"policyNo":index==2?self.searchConditionModel.account:@"",
                            @"identityNo":index==2?self.searchConditionModel.passWord:@"",
                            @"type":[NSString stringWithFormat:@"%ld",index],
                            @"insuranceCompany":self.searchConditionModel.cityCode};
    
    MYLog(@"%@",dict);
    
    
    // 1.获取taken
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryAutoinsurance] timeoutInterval:self.timeOut params:dict success:^(id responseObj) {
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






@end
