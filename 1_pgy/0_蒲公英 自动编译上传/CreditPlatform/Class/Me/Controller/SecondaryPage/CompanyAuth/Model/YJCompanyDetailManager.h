//
//  YJCompanyDetailManager.h
//  CreditPlatform
//
//  Created by yj on 16/9/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompanyDetailModel.h"

@interface YJCompanyDetailManager : NSObject
/**
 *  保存企业信息到本地
 */
+ (void)saveCompanyInfo:(CompanyDetailModel *)company;
/**
 *  熊本地获取企业信息
 */
+ (CompanyDetailModel *)companyInfo;
/**
 *  清空本地企业信息
 */
+ (BOOL)clearCompanyInfo;
/**
 *  发送网络请求
 *  获取企业信息
 */
+ (void)getCompanyInfoFromNet;
@end
