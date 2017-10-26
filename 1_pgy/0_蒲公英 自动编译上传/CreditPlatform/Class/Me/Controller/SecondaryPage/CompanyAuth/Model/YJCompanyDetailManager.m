//
//  YJCompanyDetailManager.m
//  CreditPlatform
//
//  Created by yj on 16/9/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCompanyDetailManager.h"
#define kCompanyInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"company.plist"]

@implementation YJCompanyDetailManager
+ (void)saveCompanyInfo:(CompanyDetailModel *)company {
    [NSKeyedArchiver archiveRootObject:company toFile:kCompanyInfoPath];
    
}

+ (CompanyDetailModel *)companyInfo {
    if ([[NSFileManager defaultManager] fileExistsAtPath:kCompanyInfoPath]) {
        CompanyDetailModel *companyInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:kCompanyInfoPath];
        return companyInfo;
    }
    return nil;
}
+ (BOOL)clearCompanyInfo {
    
    return [[NSFileManager defaultManager] removeItemAtPath:kCompanyInfoPath error:nil];
}

/**
 *  刷新企业信息
 *  "status": 00-待审核 20-审核成功 99-审核失败
 */
+ (void)getCompanyInfoFromNet {
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {

        // 提交企业认证后，企业详情接口
        __weak typeof(self) weakSelf = self;
        
        NSDictionary *dict = @{@"method" : urlJK_queryMember,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd
                               };
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryMember] params:dict success:^(id responseObj) {
            
            //"status": "00" // 00-待审核 20-审核成功 99-审核失败
//            MYLog(@"企业认证成功---%@",responseObj[@"data"]);
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                
                 CompanyDetailModel *companyDetailModel = [CompanyDetailModel mj_objectWithKeyValues:responseObj[@"data"]];
                [YJCompanyDetailManager saveCompanyInfo:companyDetailModel];

                YJUserModel *user = [YJUserManagerTool user];
                user.authStatus = companyDetailModel.status;
                [YJUserManagerTool saveUser:user];

            } else {
                YJUserModel *user = [YJUserManagerTool user];
                user.authStatus = @"0";
                [YJUserManagerTool saveUser:user];
            }
        } failure:^(NSError *error) {
            
            MYLog(@"企业认证请求失败---%@",error);
            
        }];
    }
    
}
@end
