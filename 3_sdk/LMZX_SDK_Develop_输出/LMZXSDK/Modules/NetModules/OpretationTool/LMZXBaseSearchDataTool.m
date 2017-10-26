//
//  YJBaseSearchDataTool.m
//  LiMuCycle
//
//  Created by yj on 2017/2/13.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import "LMZXBaseSearchDataTool.h"
#import "LMZXHTTPTool.h"
#import "LMZXFactoryView.h"
#import "LMZXSDKNavigationController.h"

#import "LMZXQueryInfoModel.h"
#import "LMZXPopTextFiledView.h"
#import "LMZXSDK.h"
#import "LMZXTool.h"
#import <CommonCrypto/CommonDigest.h>
// 配套数据缓存:
#define LMZX_StoreNetWithSignAndTimeStamp  @"LMZX_StoreNetWithSignAndTimeStamp"

@interface LMZXBaseSearchDataTool()
{
    NSDictionary *_params;
    NSData *_data1;
    
    BOOL _isSearch;// 正在查询中
    BOOL _isSuccess;// 查询成功
    BOOL _isSendAuth;// 是否发送签名
}
/**
 定时器
 */
@property (nonatomic, strong) NSTimer *timer;

/**
 查询类型
 */
@property (nonatomic, copy) NSString *bizType;
/**
 版本号
 */
@property (nonatomic, copy) NSString *appVersion;

/**
 授权
 */
@property (nonatomic, copy) NSString *token;

/**
 第一次请求等待时间
 */
@property (nonatomic, assign) CGFloat firstTime;

/**
 循环请求间隔
 */
@property (nonatomic, assign) CGFloat circleTime;

/**
 请求超时时间
 */
@property (nonatomic, assign) CGFloat timeOut;
/**
 循环请求总时间
 */
@property (nonatomic, assign) CGFloat totalCircleTime;


@end

@implementation LMZXBaseSearchDataTool
{
    LMZXPopTextFiledView *_jPopTextFiledView;
}
- (void)dealloc
{
//    LMLog(@"-------%@销毁了",self);
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _firstTime=3;
        _circleTime=3;
        _timeOut = 60;
        _isSendAuth = NO;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reBeginLoading:) name:LMZX_BeginNetWithSignAndTimeStamp object:nil];

    }
    return self;
}


- (void)setSearchItemType:(SearchItemType)searchItemType {
    _searchItemType = searchItemType;
    
    switch (searchItemType) {
        case SearchItemTypeHousingFund:{//公积金
            _firstTime = 7;
            _circleTime = 3;
            _timeOut = 600;
            _bizType = lmzx_kBizType_housefund;
            break;
            
        }case SearchItemTypeSocialSecurity:{//社保
            _firstTime = 7;
            _circleTime = 3;
            _timeOut = 600;
            _bizType = lmzx_kBizType_socialsecurity;
            break;
            
        }case SearchItemTypeOperators:{//运营商
            _firstTime = 15;
            _circleTime = 5;
            _timeOut = 600;
            _bizType = lmzx_kBizType_mobile;
            break;
            
        }case SearchItemTypeCentralBank:{//央行
            _firstTime = 6;
            _circleTime = 2;
            _timeOut = 300;
            _bizType = lmzx_kBizType_credit;
            break;
            
        }case SearchItemTypeE_Commerce:{//电商京东
            _firstTime = 13;
            _circleTime = 2;
            _timeOut = 600;
            _bizType = lmzx_kBizType_jd;
            break;
            
        }case SearchItemTypeEducation:{//学历
            _firstTime = 0;
            _circleTime = 2;
            _timeOut = 300;
            _bizType = lmzx_kBizType_education;
            break;
            
        }case SearchItemTypeTaoBao:{//淘宝
            _firstTime = 10;
            _circleTime = 5;
            _timeOut = 600;
            _bizType = lmzx_kBizType_taobao;
//            _appVersion = @"1.3.3";
            break;
            
        }case SearchItemTypeMaimai:{//脉脉
            _firstTime = 0;
            _circleTime = 2;
            _timeOut = 300;
            _bizType = lmzx_kBizType_maimai;
//            _appVersion = @"1.3.3";
            break;
            
        }case SearchItemTypeLinkedin:{//领英
            _firstTime = 0;
            _circleTime = 2;
            _timeOut = 300;
            _bizType = lmzx_kBizType_linkedin;
//            _appVersion = @"1.3.3";
            break;
            
        }case SearchItemTypeCreditCardBill:{//信用卡
            _firstTime = 7;
            _circleTime = 3;
            _timeOut = 300;
            _bizType = lmzx_kBizType_bill;
//            _appVersion = @"1.4.0";
            break;
            
        }case SearchItemTypeLostCredit:{//失信
            _firstTime = 7;
            _circleTime = 3;
            _timeOut = 100;
            _bizType = lmzx_kBizType_shixin;
//            _appVersion = @"1.4.0";
            break;
            
        }case SearchItemTypeCarSafe:{//车险
            _firstTime = 7;
            _circleTime = 3;
            _timeOut = 300;
            _bizType = lmzx_kBizType_autoinsurance;
//            _appVersion = @"1.4.1";
            break;
            
        }
        case SearchItemTypeNetBankBill:{//网银
            _firstTime = 7;
            _circleTime = 3;
            _timeOut = 300;
            _bizType = lmzx_kBizType_ebank;
//            _appVersion = @"1.4.2";
            break;
            
        }
            
        default:
            break;
    }
}


#pragma mark- 对外方法

#pragma mark- 运营商
/**
 运营商
 */
- (void)searchMobileDataWithUserName:(NSString *)username password:(NSString *)password contentType:(NSString *)contentType otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName  {
    self.searchItemType = SearchItemTypeOperators;
    // 1.获取token
    LMZXSDK *sdk = [LMZXSDK shared];
   password = [self base64Encode:password];
    NSDictionary *dict = @{@"method":@"api.mobile.get",
                           @"apiKey":sdk.lmzxApiKey,
                           @"callBackUrl":sdk.lmzxCallBackUrl ? sdk.lmzxCallBackUrl:@"",
                           @"version":LMZX_Api_Version_1_2_0,
                           @"accessType":@"sdk",
                           @"sign":@"sign",
                           @"uid":sdk.lmzxUid ? sdk.lmzxUid:@"",
                           @"ts":[self getCurrentDateMS],
                           
                           
                           @"identityCardNo":idNO?idNO:@"",
                           @"identityName":idName?idName:@"",
                           @"username":username ? username : @"",
                           @"password":password ? password : @"",
                           @"contentType":contentType?contentType:@"all",
                           @"otherInfo":otherInfo ? otherInfo : @""};
    
    
    [self getTokenURL:LMZXSDK_url andParameters:dict];

}
/**
 运营商&成功、失败回调
 */
- (void)searchMobileDataWithUserName:(NSString *)username password:(NSString *)password contentType:(NSString *)contentType otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName  searchSuccess:(SearchSuccess)success failure:(SearchFailure)failure {
    
    [self searchMobileDataWithUserName:username password:password contentType:contentType otherInfo:otherInfo idNO:idNO idName:idName];
    self.searchSuccess = success;
    self.searchFailure = failure;
}
/**
 运营商（传Model）&成功、失败回调
 */
- (void)searchMobileDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(SearchSuccess)success  failure:(SearchFailure)failure {
    [self searchMobileDataWithUserName:queryInfo.username password:queryInfo.password contentType:queryInfo.contentType otherInfo:queryInfo.otherInfo idNO:queryInfo.identityCardNo idName:queryInfo.identityName searchSuccess:success failure:failure];
}

#pragma mark- 网银

/**
 网银
 */
- (void)searchEBankDataWithUserName:(NSString *)username password:(NSString *)password bankCode:(NSString *)bankCode idNO:(NSString *)idNO idName:(NSString *)idName  {
    self.searchItemType = SearchItemTypeNetBankBill;
    // 1.获取token
    LMZXSDK *sdk = [LMZXSDK shared];
    password = [self base64Encode:password];
    
    NSDictionary *dict = @{@"method":@"api.ebank.get",
                           @"apiKey":sdk.lmzxApiKey,
                           @"callBackUrl":sdk.lmzxCallBackUrl ? sdk.lmzxCallBackUrl:@"",
                           @"version":@"1.2.0",@"accessType":@"sdk",
                           @"sign":@"sign",
                           @"uid":sdk.lmzxUid ? sdk.lmzxUid:@"",
                           @"ts":[self getCurrentDateMS],
                           @"identityCardNo":idNO?idNO:@"",
                           @"identityName":idName?idName:@"",

                           @"username":username?username:@"",
                           @"password":password?password:@"",
                           @"bankCode":bankCode?bankCode:@""};
    
    
    [self getTokenURL:LMZXSDK_url andParameters:dict];
    
}


/**
 网银&成功、失败回调
 */
- (void)searchEBankDataWithUserName:(NSString *)username password:(NSString *)password bankCode:(NSString *)bankCode idNO:(NSString *)idNO idName:(NSString *)idName   searchSuccess:(SearchSuccess)success failure:(SearchFailure)failure {
    
    [self searchEBankDataWithUserName:username password:password bankCode:bankCode idNO:idNO idName:idName];
    self.searchSuccess = success;
    self.searchFailure = failure;
}
/**
 网银（传Model）&成功、失败回调
 */
- (void)searchEBankDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(SearchSuccess)success  failure:(SearchFailure)failure {
    
    [self searchEBankDataWithUserName:queryInfo.username password:queryInfo.password bankCode:queryInfo.bankCode idNO:queryInfo.identityNo idName:queryInfo.identityName];
    self.searchSuccess = success;
    self.searchFailure = failure;
    
//    [self searchEBankDataWithUserName:queryInfo.username password:queryInfo.password bankCode:queryInfo.bankCode idNO:queryInfo.identityCardNo idName:queryInfo.identityName searchSuccess:success failure:failure];
}


#pragma mark- 车险
/**
 车险
 */
- (void)searchCarInsuranceDataWithUserName:(NSString *)username password:(NSString *)password polocyNo:(NSString *)polocyNo   identityNo:(NSString *)identityNo type:(NSString *)type insuranceCompany:(NSString *)insuranceCompany idNO:(NSString *)idNO idName:(NSString *)idName{
    self.searchItemType = SearchItemTypeCarSafe;
    password = [self base64Encode:password];

    // 1.获取token
    LMZXSDK *sdk = [LMZXSDK shared];
    NSDictionary *dict = @{@"method":@"api.autoinsurance.get",
                           @"apiKey":sdk.lmzxApiKey,
                           @"callBackUrl":sdk.lmzxCallBackUrl ? sdk.lmzxCallBackUrl:@"",
                           @"version":@"1.2.0",
                           @"accessType":@"sdk",
                           @"sign":@"sign",
                           @"uid":sdk.lmzxUid ? sdk.lmzxUid:@"",
                           @"ts":[self getCurrentDateMS],
                           @"identityCardNo":idNO?idNO:@"",
                           @"identityName":idName?idName:@"",
                           
                           @"username":username?username:@"",
                           @"password":password?password:@"",
                           @"policyNo":polocyNo?polocyNo:@"",
                           @"identityNo":identityNo?identityNo:@"",
                           @"type":type?type:@"",
                           @"insuranceCompany":insuranceCompany?insuranceCompany:@""};
    
    
    [self getTokenURL:LMZXSDK_url andParameters:dict];
    
}

/**
 车险&成功、失败回调
 */
- (void)searchCarInsuranceDataWithUserName:(NSString *)username password:(NSString *)password polocyNo:(NSString *)polocyNo   identityNo:(NSString *)identityNo type:(NSString *)type insuranceCompany:(NSString *)insuranceCompany idNO:(NSString *)idNO idName:(NSString *)idName searchSuccess:(SearchSuccess)success failure:(SearchFailure)failure {
    [self searchCarInsuranceDataWithUserName:username password:password polocyNo:polocyNo   identityNo:identityNo type:type insuranceCompany:insuranceCompany idNO:idNO idName:idName];
    self.searchSuccess = success;
    self.searchFailure = failure;
}

/**
 车险（传Model）&成功、失败回调
 */
- (void)searchCarInsuranceDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(SearchSuccess)success  failure:(SearchFailure)failure {
    
    
    // 这里处理了.
    
    // 直接传参数的没有处理..
    [self searchCarInsuranceDataWithUserName:queryInfo.username password:queryInfo.password polocyNo:queryInfo.polocyNo   identityNo:queryInfo.identityNo type:queryInfo.type insuranceCompany:queryInfo.insuranceCompany idNO:queryInfo.identityNo idName:queryInfo.identityName];
    self.searchSuccess = success;
    self.searchFailure = failure;
    
    
//    [self searchCarInsuranceDataWithUserName:queryInfo.username password:queryInfo.password polocyNo:queryInfo.polocyNo identityNo:queryInfo.identityNo type:queryInfo.type insuranceCompany:queryInfo.insuranceCompany  idNO:queryInfo.identityCardNo idName:queryInfo.identityName searchSuccess:success failure:failure];
    
    
    
    
}


#pragma mark 淘宝 
- (void)searchTaobaoDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType {
    self.searchItemType = SearchItemTypeTaoBao;
    password = [self base64Encode:password];

    // 1.获取token
    LMZXSDK *sdk = [LMZXSDK shared];
    NSDictionary *dict = @{@"method":@"api.taobao.get",
                           @"apiKey":sdk.lmzxApiKey,
                           @"callBackUrl":sdk.lmzxCallBackUrl ? sdk.lmzxCallBackUrl:@"",
                           @"version":@"1.2.0",
                           @"sign":@"sign",
                           @"uid":sdk.lmzxUid ? sdk.lmzxUid:@"",
                           @"ts":[self getCurrentDateMS],
                           @"identityCardNo":idNO?idNO:@"",
                           @"identityName":idName?idName:@"",
                           @"username":username?username:@"",
                           @"password":password?password:@"",

                           @"accessType":@"sdk",
                           @"cookie":cookie?cookie:@"",
                           @"loginType":loginType};
    
//    LMLog(@"淘宝请求参数:%@",dict);
    [self getTokenURL:LMZXSDK_url andParameters:dict];
    
}

/**
 淘宝&成功、失败回调
 */
- (void)searchTaobaoDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType searchSuccess:(SearchSuccess)success failure:(SearchFailure)failure {
    [self searchTaobaoDataWithUserName:username password:password idNO:idNO idName:idName accessType:accessType cookie:cookie loginType:(NSString*)loginType];
    self.searchSuccess = success;
    self.searchFailure = failure;
}
/**
 淘宝（传Model）&成功、失败回调
 */
- (void)searchTaobaoDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(SearchSuccess)success  failure:(SearchFailure)failure {
    
    [self searchTaobaoDataWithUserName:queryInfo.username password:queryInfo.password idNO:queryInfo.identityCardNo idName:queryInfo.identityName accessType:queryInfo.accessType cookie:queryInfo.cookie loginType:queryInfo.loginType searchSuccess:success failure:failure];
}

#pragma mark- 脉脉
/**
 脉脉
 */
- (void)searchMaimaiDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName   {
    self.searchItemType = SearchItemTypeMaimai;
    password = [self base64Encode:password];

    // 1.获取token
    LMZXSDK *sdk = [LMZXSDK shared];
    NSDictionary *dict = @{@"method":@"api.maimai.get",
                           @"apiKey":sdk.lmzxApiKey,
                           @"callBackUrl":sdk.lmzxCallBackUrl ? sdk.lmzxCallBackUrl:@"",
                           @"version":@"1.2.0",@"accessType":@"sdk",
                           @"sign":@"sign",
                           @"uid":sdk.lmzxUid ? sdk.lmzxUid:@"",
                           @"ts":[self getCurrentDateMS],
                           @"identityCardNo":idNO?idNO:@"",
                           @"identityName":idName?idName:@"",
                           
                           @"username":username?username:@"",
                           @"password":password?password:@""};
    
    
    [self getTokenURL:LMZXSDK_url andParameters:dict];
}

/**
 脉脉&成功、失败回调
 */
- (void)searchMaimaiDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName searchSuccess:(SearchSuccess)success failure:(SearchFailure)failure {
    [self searchMaimaiDataWithUserName:username password:password idNO:idNO idName:idName];
    self.searchSuccess = success;
    self.searchFailure = failure;
}
/**
 脉脉（传Model）&成功、失败回调
 */
- (void)searchMaimaiDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(SearchSuccess)success  failure:(SearchFailure)failure {
    
    [self searchMaimaiDataWithUserName:queryInfo.username password:queryInfo.password idNO:queryInfo.identityCardNo idName:queryInfo.identityName searchSuccess:success failure:failure];
}

#pragma mark- 领英
/**
 领英
 */
- (void)searchLinkedinDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName {
    
    self.searchItemType = SearchItemTypeLinkedin;
    password = [self base64Encode:password];

    // 1.获取token
    LMZXSDK *sdk = [LMZXSDK shared];
    NSDictionary *dict = @{@"method":@"api.linkedin.get",
                           @"apiKey":sdk.lmzxApiKey,
                           @"callBackUrl":sdk.lmzxCallBackUrl ? sdk.lmzxCallBackUrl:@"",
                           @"version":@"1.2.0",@"accessType":@"sdk",
                           @"sign":@"sign",
                           @"uid":sdk.lmzxUid ? sdk.lmzxUid:@"",
                           @"ts":[self getCurrentDateMS],
                           @"identityCardNo":idNO?idNO:@"",
                           @"identityName":idName?idName:@"",
                           
                           @"username":username?username:@"",
                           @"password":password?password:@""};
    
    
    [self getTokenURL:LMZXSDK_url andParameters:dict];
    
}
/**
 领英&成功、失败回调
 */
- (void)searchLinkedinDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName searchSuccess:(SearchSuccess)success failure:(SearchFailure)failure {
    [self searchLinkedinDataWithUserName:username password:password idNO:idNO idName:idName];
    self.searchSuccess = success;
    self.searchFailure = failure;
}
/**
 领英（传Model）&成功、失败回调
 */
- (void)searchLinkedinDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(SearchSuccess)success  failure:(SearchFailure)failure {
    
    [self searchLinkedinDataWithUserName:queryInfo.username password:queryInfo.password idNO:queryInfo.identityCardNo idName:queryInfo.identityName searchSuccess:success failure:failure];
}

#pragma mark- 京东
/**
 京东
 */
- (void)searchJdDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType  {
    self.searchItemType = SearchItemTypeE_Commerce;
    password = [self base64Encode:password];

    // 1.获取token
    LMZXSDK *sdk = [LMZXSDK shared];
    NSDictionary *dict = @{@"method":@"api.jd.get",
                           @"apiKey":sdk.lmzxApiKey,
                           @"callBackUrl":sdk.lmzxCallBackUrl ? sdk.lmzxCallBackUrl:@"",
                           @"version":@"1.2.0",
                           @"sign":@"sign",
                           @"uid":sdk.lmzxUid ? sdk.lmzxUid:@"",
                           @"ts":[self getCurrentDateMS],
                           @"identityCardNo":idNO?idNO:@"",
                           @"identityName":idName?idName:@"",
                           
                           @"username":username?username:@"",
                           @"password":password?password:@"",
                           @"accessType":accessType?accessType:@"sdk",
                           @"cookie":cookie?cookie:@"",
                           @"loginType":loginType};
    
    
    [self getTokenURL:LMZXSDK_url andParameters:dict];
}
/**
 京东&成功、失败回调
 */
- (void)searchJdDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType searchSuccess:(SearchSuccess)success failure:(SearchFailure)failure {
    [self searchJdDataWithUserName:username password:password idNO:idNO idName:idName accessType:accessType cookie:cookie loginType:loginType];
    self.searchSuccess = success;
    self.searchFailure = failure;
}
/**
 京东（传Model）&成功、失败回调
 */
- (void)searchJdDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(SearchSuccess)success  failure:(SearchFailure)failure {
    
    [self searchJdDataWithUserName:queryInfo.username password:queryInfo.password idNO:queryInfo.identityCardNo idName:queryInfo.identityName accessType:queryInfo.accessType cookie:queryInfo.cookie loginType:queryInfo.loginType searchSuccess:success failure:failure];
}


#pragma mark- 学信
/**
 学信
 */
- (void)searchEducationDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName {
    
    self.searchItemType = SearchItemTypeEducation;
    password = [self base64Encode:password];

    // 1.获取token
    LMZXSDK *sdk = [LMZXSDK shared];
    NSDictionary *dict = @{@"method":@"api.education.get",
                           @"apiKey":sdk.lmzxApiKey,
                           @"callBackUrl":sdk.lmzxCallBackUrl ? sdk.lmzxCallBackUrl:@"",
                           @"version":@"1.2.0",@"accessType":@"sdk",
                           @"sign":@"sign",
                           @"uid":sdk.lmzxUid ? sdk.lmzxUid:@"",
                           @"ts":[self getCurrentDateMS],
                           @"identityCardNo":idNO?idNO:@"",
                           @"identityName":idName?idName:@"",
                           
                           @"username":username?username:@"",
                           @"password":password?password:@""};
    
    
    [self getTokenURL:LMZXSDK_url andParameters:dict];
    
}

/**
 学信&成功、失败回调
 */
- (void)searchEducationDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName searchSuccess:(SearchSuccess)success failure:(SearchFailure)failure {
    [self searchEducationDataWithUserName:username password:password idNO:idNO idName:idName];
    self.searchSuccess = success;
    self.searchFailure = failure;
}
/**
 学信（传Model）&成功、失败回调
 */
- (void)searchEducationDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(SearchSuccess)success  failure:(SearchFailure)failure {
    
    [self searchEducationDataWithUserName:queryInfo.username password:queryInfo.password idNO:queryInfo.identityCardNo idName:queryInfo.identityName searchSuccess:success failure:failure];
}


#pragma mark- 央行
/**
 央行
 */
- (void)searchCentralBankDataWithUserName:(NSString *)username password:(NSString *)password middleAuthCode:(NSString *)middleAuthCode idNO:(NSString *)idNO idName:(NSString *)idName {
    self.searchItemType = SearchItemTypeCentralBank;
    password = [self base64Encode:password];

    // 1.获取token
    LMZXSDK *sdk = [LMZXSDK shared];
    NSDictionary *dict = @{@"method":@"api.credit.get",
                           @"apiKey":sdk.lmzxApiKey,
                           @"callBackUrl":sdk.lmzxCallBackUrl ? sdk.lmzxCallBackUrl:@"",
                           @"version":@"1.2.0",@"accessType":@"sdk",
                           @"sign":@"sign",
                           @"uid":sdk.lmzxUid ? sdk.lmzxUid:@"",
                           @"ts":[self getCurrentDateMS],
                           @"identityCardNo":idNO?idNO:@"",
                           @"identityName":idName?idName:@"",
                           
                           @"username":username?username:@"",
                           @"password":password?password:@"",
                           @"middleAuthCode":middleAuthCode?middleAuthCode:@""};
    
    
    [self getTokenURL:LMZXSDK_url  andParameters:dict];
}

/**
 央行&成功、失败回调
 */
- (void)searchCentralBankDataWithUserName:(NSString *)username password:(NSString *)password middleAuthCode:(NSString *)middleAuthCode idNO:(NSString *)idNO idName:(NSString *)idName searchSuccess:(SearchSuccess)success failure:(SearchFailure)failure {
    [self searchCentralBankDataWithUserName:username password:password middleAuthCode:middleAuthCode idNO:idNO idName:idName];
    self.searchSuccess = success;
    self.searchFailure = failure;
}
/**
 央行（传Model）&成功、失败回调
 */
- (void)searchCentralBankDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(SearchSuccess)success  failure:(SearchFailure)failure {
    
    [self searchCentralBankDataWithUserName:queryInfo.username password:queryInfo.password middleAuthCode:queryInfo.middleAuthCode idNO:queryInfo.identityCardNo idName:queryInfo.identityName searchSuccess:success failure:failure];
}

#pragma mark- 信用卡
/**
 信用卡
 */
- (void)searchCreditCardDataWithUserName:(NSString *)username password:(NSString *)password billType:(NSString *)billType bankCode:(NSString *)bankCode idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType {
    self.searchItemType = SearchItemTypeCreditCardBill;
    password = [self base64Encode:password];

    // 1.获取token
    LMZXSDK *sdk = [LMZXSDK shared];
    NSDictionary *dict = @{@"method":@"api.bill.get",
                           @"apiKey":sdk.lmzxApiKey,
                           @"callBackUrl":sdk.lmzxCallBackUrl ? sdk.lmzxCallBackUrl:@"",
                           @"version":@"1.2.0",
                           @"sign":@"sign",
                           @"uid":sdk.lmzxUid ? sdk.lmzxUid:@"",
                           @"ts":[self getCurrentDateMS],
                           @"identityCardNo":idNO?idNO:@"",
                           @"identityName":idName?idName:@"",
                           
                           @"username":username?username:@"",
                           @"password":password?password:@"",
                           @"billType":billType?billType:@"",
                           @"bankCode":bankCode?bankCode:@"",
                           @"accessType":accessType?accessType:@"sdk",
                           @"cookie":cookie?cookie:@"",
                           @"loginType":loginType
                           };
    
    
    [self getTokenURL:LMZXSDK_url  andParameters:dict];
}

/**
 信用卡&成功、失败回调
 */
- (void)searchCreditCardDataWithUserName:(NSString *)username password:(NSString *)password billType:(NSString *)billType bankCode:(NSString *)bankCode idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType searchSuccess:(SearchSuccess)success failure:(SearchFailure)failure {
    [self searchCreditCardDataWithUserName:username password:password billType:billType bankCode:bankCode idNO:idNO idName:idName accessType:accessType cookie:cookie loginType:loginType];
    self.searchSuccess = success;
    self.searchFailure = failure;
}
/**
 信用卡（传Model）&成功、失败回调
 */
- (void)searchCreditCardDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(SearchSuccess)success  failure:(SearchFailure)failure {
    
    [self searchCreditCardDataWithUserName:queryInfo.username password:queryInfo.password billType:queryInfo.billType bankCode:queryInfo.bankCode idNO:queryInfo.identityCardNo idName:queryInfo.identityName accessType:queryInfo.accessType cookie:queryInfo.cookie loginType:queryInfo.loginType searchSuccess:success failure:failure];
}

#pragma mark- 失信
/**
 失信
 */
- (void)searchDishonestDataWithName:(NSString *)name identityNo:(NSString *)identityNo idNO:(NSString *)idNO idName:(NSString *)idName  {
    self.searchItemType = SearchItemTypeLostCredit;
    
    // 1.获取token
    LMZXSDK *sdk = [LMZXSDK shared];
    NSDictionary *dict = @{@"method":@"api.shixin.get",
                           @"apiKey":sdk.lmzxApiKey,
                           @"callBackUrl":sdk.lmzxCallBackUrl ? sdk.lmzxCallBackUrl:@"",
                           @"version":@"1.2.0",@"accessType":@"sdk",
                           @"sign":@"sign",
                           @"uid":sdk.lmzxUid ? sdk.lmzxUid:@"",
                           @"ts":[self getCurrentDateMS],
                           @"identityCardNo":idNO?idNO:@"",
                           @"identityName":idName?idName:@"",
                           
                           @"name":name?name:@"",
                           @"identityNo":identityNo?identityNo:@""
                           };
    
    
    [self getTokenURL:LMZXSDK_url  andParameters:dict];
}

/**
 失信&成功、失败回调
 */
- (void)searchDishonestDataWithName:(NSString *)name identityNo:(NSString *)identityNo idNO:(NSString *)idNO idName:(NSString *)idName searchSuccess:(SearchSuccess)success failure:(SearchFailure)failure {
    [self searchDishonestDataWithName:name identityNo:identityNo idNO:idNO idName:idName];
    self.searchSuccess = success;
    self.searchFailure = failure;
}
/**
 失信（传Model）&成功、失败回调
 */
- (void)searchDishonestDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(SearchSuccess)success  failure:(SearchFailure)failure {
    
    [self searchDishonestDataWithName:queryInfo.name identityNo:queryInfo.identityNo idNO:queryInfo.identityCardNo idName:queryInfo.identityName searchSuccess:success failure:failure];
}

#pragma mark- 公积金
/**
 公积金
 */
- (void)searchHouseFoundDataWithUserName:(NSString *)username password:(NSString *)password area:(NSString *)area realName:(NSString *)realName otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName  {
    self.searchItemType = SearchItemTypeHousingFund;
    
    password = [self base64Encode:password];
    
    

    // 1.获取token
    LMZXSDK *sdk = [LMZXSDK shared];
    NSDictionary *dict = @{@"method":@"api.housefund.get",
                           @"apiKey":sdk.lmzxApiKey,
                           @"callBackUrl":sdk.lmzxCallBackUrl ? sdk.lmzxCallBackUrl:@"",
                           @"version":@"1.2.0",@"accessType":@"sdk",
                           @"sign":@"sign",
                           @"uid":sdk.lmzxUid ? sdk.lmzxUid:@"",
                           @"ts":[self getCurrentDateMS],
                           @"identityCardNo":idNO?idNO:@"",
                           @"identityName":idName?idName:@"",
                           
                           @"username":username ? username : @"",
                           @"password":password ? password : @"",
                           @"area":area ? area : @"",
                           @"realName" : realName ? realName : @"",
                           @"otherInfo" : otherInfo ? otherInfo : @""};
    
    
    [self getTokenURL:LMZXSDK_url  andParameters:dict];
}
/**
 公积金&成功、失败回调
 */
- (void)searchHouseFoundDataWithUserName:(NSString *)username password:(NSString *)password area:(NSString *)area realName:(NSString *)realName otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName  searchSuccess:(SearchSuccess)success failure:(SearchFailure)failure{
    [self searchHouseFoundDataWithUserName:username password:password area:area realName:realName otherInfo:otherInfo idNO:idNO idName:idName];
    
    self.searchSuccess = success;
    self.searchFailure = failure;
    
}
/**
 公积金（传Model）&成功、失败回调
 */
- (void)searchHouseFoundDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(SearchSuccess)success  failure:(SearchFailure)failure {
    
    [self searchHouseFoundDataWithUserName:queryInfo.username password:queryInfo.password area:queryInfo.area realName:queryInfo.realname otherInfo:queryInfo.otherInfo idNO:queryInfo.identityCardNo idName:queryInfo.identityName searchSuccess:success failure:failure];
}


#pragma mark- 社保
/**
 社保
 */
- (void)searchSocialSecturityDataWithUserName:(NSString *)username password:(NSString *)password area:(NSString *)area realName:(NSString *)realName otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName  {
    // 1.获取token
    LMZXSDK *sdk = [LMZXSDK shared];
    self.searchItemType = SearchItemTypeSocialSecurity;
    password = [self base64Encode:password];

    NSDictionary *dict = @{@"method":@"api.socialsecurity.get",
                           @"apiKey":sdk.lmzxApiKey,
                           @"callBackUrl":sdk.lmzxCallBackUrl ? sdk.lmzxCallBackUrl:@"",
                           @"version":@"1.2.0",@"accessType":@"sdk",
                           @"sign":@"sign",
                           @"uid":sdk.lmzxUid ? sdk.lmzxUid:@"",
                           @"ts":[self getCurrentDateMS],
                           @"identityCardNo":idNO?idNO:@"",
                           @"identityName":idName?idName:@"",
                           
                           @"username":username ? username : @"",
                           @"password":password ? password : @"",
                           @"area":area ? area : @"",
                           @"realName" : realName ? realName : @"",
                           @"otherInfo" : otherInfo ? otherInfo : @""};
    
    
 
    
    [self getTokenURL:LMZXSDK_url andParameters:dict];
}
/**
 社保&成功、失败回调
 */
- (void)searchSocialSecturityDataWithUserName:(NSString *)username password:(NSString *)password area:(NSString *)area realName:(NSString *)realName otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName  searchSuccess:(SearchSuccess)success failure:(SearchFailure)failure{
    [self searchSocialSecturityDataWithUserName:username password:password area:area realName:realName otherInfo:otherInfo idNO:idNO idName:idName];
    
    self.searchSuccess = success;
    self.searchFailure = failure;
    
}
/**
 社保（传Model）&成功、失败回调
 */
- (void)searchSocialSecturityDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(SearchSuccess)success  failure:(SearchFailure)failure {
    
    [self searchSocialSecturityDataWithUserName:queryInfo.username password:queryInfo.password area:queryInfo.area realName:queryInfo.realname otherInfo:queryInfo.otherInfo idNO:queryInfo.identityCardNo idName:queryInfo.identityName searchSuccess:success failure:failure];
}




#pragma mark - 用户停止查询
- (void)stopSearch {
    // 如果正在查询
    if (_isSearch) {
        [self handleFailure:@"用户取消查询" action:LMZXSDKSearchActionCancel];
        [self removeTimer];
        _isUserStopSearch = YES;
    }
    // 防止签名错误
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}




#pragma mark - ***************私有方法****************

#pragma mark- 添加定时器
- (void)addTimer {
    if (_timer == nil) {
        // 增加定时器前，先进行一次请求
        [self startRequestData];
        // 第一次请求结束后，添加定时器开始轮训
        [self performSelector:@selector(startCycleRequest) withObject:nil afterDelay:_firstTime];
    }
}

#pragma mark- 开启轮循
- (void)startCycleRequest {
    // 添加定时器前，是否已经终止了查询
    if (!_isUserStopSearch) {
        _firstTime = 0;
        _timer = [NSTimer timerWithTimeInterval:_circleTime target:self selector:@selector(startRequestData) userInfo:nil repeats:YES];

        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

    }
}


#pragma mark- 请求超时，移除定时器
- (void)removeTimerWithTimeOut {
    [self removeTimer];
    [self handleFailure:@"查询超时，请稍后重试。" action:LMZXSDKSearchActionOtherError];
    LMLog(@"立木征信Log:请求超时");
}

#pragma mark- 移除定时器，停止循环请求
- (void)removeTimer {
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        
        _isSearch = NO;
    }
    // 防止签名错误
    [[NSNotificationCenter defaultCenter] removeObserver: self];
  
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startCycleRequest) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
}

#pragma mark - 重启查询
-(void)reBeginLoading:(NSNotification*)noti{
    
    NSDictionary *dic = noti.userInfo;
    __weak typeof(self) weakSelf = self;
    NSString *sign = dic[@"sign"];
    if ([sign isKindOfClass:[NSString class]] && sign.length) {
        
        NSDictionary *params = [LMZXTool objectForKey:LMZX_StoreNetWithSignAndTimeStamp];
        if (params.allKeys.count<1) {
            [weakSelf handleFailure:@"签名异常" action:LMZXSDKSearchActionOtherError];
            return;
        }
        NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:params];
        [mdic setValue:sign forKey:@"sign"];
        params = [mdic copy];
        [LMZXTool  removeObjectForKey:LMZX_StoreNetWithSignAndTimeStamp];
        
        // 开始查询
        _isSearch = YES;
        __weak typeof(self) weakSelf = self;

        [LMZXHTTPTool post:LMZXSDK_url params:params success:^(id obj) {
            BOOL obj4 =[obj isKindOfClass:[NSDictionary class]];
            if (!obj | !obj4) {
                [weakSelf handleFailure:@"查询失败" action:LMZXSDKSearchActionOtherError];
                LMLog(@"立木征信Log:1-建任务失败:%@",obj);
            }else if ([obj[@"code"] isEqualToString:@"0010"]) {
                LMLog(@"立木征信Log:1-受理成功");
                _token = obj[@"token"];
                [weakSelf addTimer];
            } else {
                _isSearch = NO;
                //错误类型 根据 code 决定
                [weakSelf handleFailure:obj[@"msg"] action:[self decodeAction:obj[@"code"]]];
                LMLog(@"立木征信Log:1-建任务失败:%@",obj);
            }
            
        } failure:^(NSString *error) {
            _isSearch = NO;
            // 此类错误对外归结为:其他异常
            [weakSelf handleFailure:error action:LMZXSDKSearchActionOtherError];
            LMLog(@"立木征信Log:1-建任务失败:%@",error);
        }];
        
    }else{
        [self handleFailure:@"签名异常" action:LMZXSDKSearchActionOtherError];
    }
    
}


#pragma mark - **1.获取token**
- (void)getTokenURL:(NSString *)urlString andParameters:(NSDictionary *)params {
    
    if ([LMZXSDK shared].lmzxAuthBlock) {
        
        [LMZXTool setObject:params forKey:LMZX_StoreNetWithSignAndTimeStamp];
        NSString *sign = [self sign:params];
//        LMLog(@"======一次加签后：%@",sign);
        [LMZXSDK shared].lmzxAuthBlock(sign);
        
        return;
    }

    
    
//    __weak typeof(self) weakSelf = self;
//    
//    // 开始查询
//    _isSearch = YES;
//    
//    LMLog(@"tool:1----dic：%@",params);
//    [LMZXHTTPTool post:urlString params:params success:^(id responseObj) {
//        LMLog(@"tool:1----拿到token：%@",responseObj);
//        
//        if (!responseObj) {//某些特殊情况
//            [weakSelf handleFailure:@"查询失败" action:LMZXSDKSearchActionOtherError];
//        }
//        
//        if ([responseObj[@"code"] isEqualToString:@"0010"]) {
//            
//            _token = responseObj[@"token"];
//
//            [weakSelf addTimer];
//            
//        } else {
////            [weakSelf handleFailure:responseObj[@"msg"]];
//            _isSearch = NO;
//            //错误类型 根据 code 决定
//            [weakSelf handleFailure:responseObj[@"msg"] action:[self decodeAction:responseObj[@"code"]]];
//            
//        }
//        
//    } failure:^(NSString *error) {
//        _isSearch = NO;
//        // 此类错误对外归结为:其他异常
//        [weakSelf handleFailure:error action:LMZXSDKSearchActionOtherError];
//        LMLog(@"tool ---第一步获取token失败");
//    }];
    
}


#pragma mark  **2.轮循--状态**
- (void)startRequestData {
//    LMLog(@"-----**2.轮循**");
    // LMLog(@"立木征信Log:2-数据获取中");
    // 1.请求总用时超过 超时时长，就停止请求
    if (_totalCircleTime >= _timeOut) {
        [self removeTimerWithTimeOut];
        return;
    }
    
    // 2.统计请求用时
    _totalCircleTime += _circleTime;
    
    // 3.开始请求
    __weak typeof(self) weakSelf = self;
    NSDictionary *dict = @{@"method":@"api.common.getStatus",
                           @"apiKey":[LMZXSDK shared].lmzxApiKey,
                           @"version":LMZX_Api_Version_1_2_0,
                           @"sign":@"sign",

                           @"token":_token,
                           @"bizType":_bizType
                           };

    [LMZXHTTPTool post:LMZXSDK_url params:dict success:^(id obj) {

        
        
        
        LMLog(@"立木征信Log:查询中......");
        BOOL obj4 =[obj isKindOfClass:[NSDictionary class]];
        if (!obj | !obj4) {
            [weakSelf handleFailure:@"查询失败" action:LMZXSDKSearchActionOtherError];
        }else if ([obj[@"code"] isEqualToString:@"0000"]) { // 1 查询成功
            LMLog(@"立木征信Log:查询成功");
            // 3.获取查询结果
            _token = obj[@"token"];
//            [weakSelf queryResult];
            [weakSelf removeTimer];
            weakSelf.searchSuccess(obj,@{@"taskID":_token});
            
            
        } else if ([obj[@"code"] isEqualToString:@"0006"]) { // 2 验证码
            
            LMLog(@"立木征信Log:2-待输入验证码");
            
            [weakSelf removeTimer];
            [weakSelf showSMSAlert];
            [weakSelf handleMsgCode:0];
//            LMLog(@"tool:需要短信验证");
            
        }else if ([obj[@"code"] isEqualToString:@"0100"]){ // 3 登录成功 回调
            LMLog(@"立木征信Log:登录成功");
            
            // 如果设置了自动退出,那么此时应当停止轮训, SDK 自动退出
            if ([LMZXSDK shared].lmzxQuitOnSuccess==NO) {
                [weakSelf removeTimer];
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.loginStatus) {
                    self.loginStatus(0,obj[@"token"]);
                }
            });
            
            
        }else if ([obj[@"code"] isEqualToString:@""]  ) { // 继续循环
            
        } else {// 循环出错、结束请求
            //错误类型 根据 code 决定
            [weakSelf removeTimer];
            [weakSelf handleFailure:obj[@"msg"] action:[self decodeAction:obj[@"code"]]];
            
//            if (weakSelf.searchFailure) {
//                [weakSelf handleFailure:responseObj[@"msg"]];
//            }
            LMLog(@"立木征信Log:2-查询失败:%@",obj);
        }
        
        
    } failure:^(NSString *error) {
        [weakSelf removeTimer];
        
        // 此类错误对外归结为:其他异常
        [weakSelf handleFailure:error action:LMZXSDKSearchActionOtherError];
        
        LMLog(@"立木征信Log:2-查询失败:%@",error);

    }];
    
    
}

#pragma mark  **3.查询结果**
- (void)queryResult {
    __weak typeof(self) weakSelf = self;

    NSDictionary *dict = @{@"method":@"api.common.getResult",
                          @"apiKey":[LMZXSDK shared].lmzxApiKey,
                          @"version":LMZX_Api_Version_1_2_0,
                          @"accessType":@"sdk",
                          @"sign":@"sign",

                          @"token":_token,
                          @"bizType":_bizType
                          };
//    NSLog(@"===获取查询参数：%@",dict);
    // 3.获取查询结果
    [LMZXHTTPTool post:LMZXSDK_url params:dict success:^(id obj) {
//        LMLog(@"tool:第三步-成功获取数据----%@",responseObj);
        BOOL obj4 =[obj isKindOfClass:[NSDictionary class]];
        if (!obj | !obj4) {
            [weakSelf handleFailure:@"查询失败" action:LMZXSDKSearchActionOtherError];
            
        }
        
        if ([obj[@"code"] isEqualToString:@"0000"]) {
            
            // 成功回调给外部处理
//           weakSelf.searchSuccess(responseObj,nil);
            
        } else {
            //错误类型 根据 code 决定
           [weakSelf handleFailure:obj[@"msg"] action:[self decodeAction:obj[@"code"]]];
            
//            [weakSelf handleFailure:responseObj[@"msg"]];
//             LMLog(@"网络Log__第三步获数据失败:%@",responseObj[@"msg"]);
        }
        
        
    } failure:^(NSString *error) {
        
//        LMLog(@"网络Log__第三步获数据失败:%@",error);
        
//        LMLog(@"tool:第三步获数据失败-------%@",error);
        // 此类错误对外归结为: 其他异常
        [weakSelf handleFailure:error action:LMZXSDKSearchActionOtherError];
        
    }];

}

#pragma mark - 验证码
#pragma mark  验证码 输入框
- (void)showSMSAlert {
    
    
   __block UIWindow *nowWindow;
    NSArray *windows =[UIApplication sharedApplication].windows;
    
    if (windows.count>=2) {
        [windows enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isKindOfClass:NSClassFromString(@"UITextEffectsWindow")]) {
            }else if([obj isKindOfClass:NSClassFromString(@"UIWindow")]) {
                nowWindow = (UIWindow *)obj;
            }
        }];
    } else if ([windows.lastObject isKindOfClass:NSClassFromString(@"UIWindow")]){
        nowWindow = [[UIApplication sharedApplication].windows lastObject];
    }
    
    
    // 创建弹框
    if (!_jPopTextFiledView) {
        
        __block typeof(_jPopTextFiledView) ssview = _jPopTextFiledView;
        __block typeof(self) sself =self;
        
        // cover view
        UIView * _backView = [LMZXFactoryView JCoverViewWithBgColor:[UIColor blackColor] alpha:0.7];
        _backView.frame = CGRectMake(0, -64, LM_SCREEN_WIDTH, LM_SCREEN_HEIGHT+64);
        // pop view
        CGFloat width = lmzxJPWIDTH;
        CGFloat height = lmzxJPHEIGHT;
        _jPopTextFiledView = [[LMZXPopTextFiledView alloc]initWithFrame:CGRectMake(15, -height, width, height)];
        [nowWindow addSubview:_backView];
        [nowWindow addSubview:_jPopTextFiledView];
        [nowWindow  makeKeyAndVisible];
        
        
        // 吉林电信(提示: 请用186****6666手机  发送CXXD至10001,获取验证码 )
        if (self.queryInfoModel.checkTypeForSMS == LMZXCommonSendMsgTypeJLDX) {
            _jPopTextFiledView.sendMsgType = self.queryInfoModel.checkTypeForSMS;
        }
        // 运营商 (提示:验证码已经发送至  18666666666)
        else if (self.queryInfoModel.checkTypeForSMS == LMZXCommonSendMsgTypePhone ) {
            _jPopTextFiledView.sendMsgType = self.queryInfoModel.checkTypeForSMS;
        }
        //  QQ 独立密码(提示:请输入QQ邮箱独立密码)
        else if (self.queryInfoModel.checkTypeForSMS == LMZXCommonSendMsgTypeQQCredit ) {
            _jPopTextFiledView.sendMsgType = self.queryInfoModel.checkTypeForSMS;
        }
        // 其他:信用卡账单,京东,淘宝手机验证码,邮箱验证码 ( 统一提示:短信验证码已发送)
        else{
            _jPopTextFiledView.sendMsgType = LMZXCommonSendMsgTypeNormal;
        }
    
        
        // 弹窗的主题文字:
        _jPopTextFiledView.txt  = self.queryInfoModel.username;
        
        
        
        
        [_jPopTextFiledView show];
        
        [self performSelector:@selector(sleepPopTxt) withObject:nil afterDelay:0.8];
        
        
        // 点击确认
        _jPopTextFiledView.clickedBlock=(^(NSString * obj ){
            
            [sself handleMsgCode:1];
            [sself sendSMS:obj];
            _backView.hidden = YES;
            ssview.hidden = YES;
            [_backView removeFromSuperview];
            [ssview removeFromSuperview];
            _jPopTextFiledView = nil;
        });
        
        // 点击取消
        _jPopTextFiledView.CancleBlock=^(){
            //错误类型 根据 code 决定
            [sself handleFailure:@"用户取消查询" action:LMZXSDKSearchActionCancel];
            LMLog(@"立木征信Log:用户取消查询");
            _backView.hidden = YES;
            ssview.hidden = YES;
            [_backView removeFromSuperview];
            [ssview removeFromSuperview];
            _jPopTextFiledView = nil;
        };
    }
        
}
-(void)sleepPopTxt{
   [_jPopTextFiledView.textfile  becomeFirstResponder];
}


#pragma mark  验证码 网络
- (void)sendSMS:(NSString *)smsCode {
    NSDictionary *dic = @{  @"method":@"api.common.input",
                            @"apiKey":[LMZXSDK shared].lmzxApiKey,
                            @"version":@"1.2.0",
                            
                            @"token":_token,
                            @"input":smsCode
                            };
    
    __weak typeof(self) weakSelf = self;
    
    __block BOOL isPass = NO;
    [LMZXHTTPTool post:LMZXSDK_url params:dic success:^(id responseObj) {
        
        if ([responseObj[@"code"] isEqualToString:@"0009"]) {
            _token = responseObj[@"token"];

            [weakSelf startCycleRequest];
            isPass = YES;
        } else {
            //错误类型 根据 code 决定
            _isSearch = false;
            [weakSelf handleFailure:responseObj[@"msg"] action:[self decodeAction:responseObj[@"code"]]];
            LMLog(@"立木征信Log:验证码验证错误：%@",responseObj);
        }
        
    } failure:^(NSString *error) {
        _isSearch = false;
        [weakSelf handleFailure:error action:LMZXSDKSearchActionOtherError];
        LMLog(@"立木征信Log:验证码验证错误：%@",error);
    }];
    
}


#pragma mark - 结果回调

#pragma mark 回调失败
// 根据状态码 转换为输出用户的 code
- (void)handleFailure:(NSString *)error action:(LMZXSDKSearchAction)action{
    
    if (_searchFailure) {
        _searchFailure(error,action,nil);
    }
    
}

#pragma mark 回调验证码
- (void)handleMsgCode:(NSInteger)code {
    if (_smsVerification ) {
        _smsVerification(self.queryInfoModel.checkTypeForSMS,code);
//        switch (self.searchItemType) {
//            case SearchItemTypeOperators:{ // 运营商验证码
//                _smsVerification(SearchItemTypeOperators,code);
//                break;
//            }
//            default:
//                break;
//        }
    }
    
}


#pragma mark  获取当前控制器
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    
    return result;
}


#pragma mark BASE64

- (NSString *)base64Encode:(NSString *)string {
    NSData *nsdata = [string
                      dataUsingEncoding:NSUTF8StringEncoding];
    return [nsdata base64EncodedStringWithOptions:0];
}


#pragma mark   根据 code 返回输出状态

-(LMZXSDKSearchAction)decodeAction:(NSString*)code {
    
    // 系统异常
    if ([code isEqualToString:@"1012"]||[code isEqualToString:@"1119"]) {
       return LMZXSDKSearchActionSeverceError;
    }
    // 其他异常
    if ([code isEqualToString:@"2030"]) {
        return LMZXSDKSearchActionOtherError;
    }
    
    // 商户信息异常
     else if ([code hasPrefix:@"100"]) {
        return LMZXSDKSearchActionUserInfoError;
     }else if ([code hasPrefix:@"101"]) {
         return LMZXSDKSearchActionUserInfoError;
     }else if ([code isEqualToString:@"1104"]) {
         return LMZXSDKSearchActionUserInfoError;
     }
    // 网络异常
     else if ([code isEqualToString:@"1117"]||[code isEqualToString:@"3001"]||[code isEqualToString:@"1118"]) {
         return LMZXSDKSearchActionNetError;
     }else if ([code isEqualToString:@"1116"]||[code isEqualToString:@"1107"]||[code isEqualToString:@"3001"]) {
         return LMZXSDKSearchActionNetError;
     }
    
    // 用户输入错误
    else if ([code hasPrefix:@"110"]) {
        return LMZXSDKSearchActionInputError;
    }else if ([code hasPrefix:@"111"]) {
        return LMZXSDKSearchActionInputError;
    }else if ([code hasPrefix:@"200"]) {
        return LMZXSDKSearchActionInputError;
    }else if ([code hasPrefix:@"201"]) {
        return LMZXSDKSearchActionInputError;
    }else if ([code hasPrefix:@"203"]) {
        return LMZXSDKSearchActionInputError;
    }else if ([code hasPrefix:@"204"]) {
        return LMZXSDKSearchActionInputError;
    }else if ([code hasPrefix:@"205"]) {
        return LMZXSDKSearchActionInputError;
    }else if ([code hasPrefix:@"300"]) {
        return LMZXSDKSearchActionInputError;
    }else if ([code hasPrefix:@"301"]) {
        return LMZXSDKSearchActionInputError;
    }else if ([code hasPrefix:@"400"]) {
        return LMZXSDKSearchActionInputError;
    }else if ([code isEqualToString:@"6011"]) {
        return LMZXSDKSearchActionInputError;
    }
    // 网络异常
    else if ([code  hasPrefix:@"202"]) {
        return LMZXSDKSearchActionNetError;
    }
    
    // 其他异常
   return LMZXSDKSearchActionOtherError;
    
    
}

/**
 获取当前时间毫秒

 @return 毫秒
 */
- (NSString *)getCurrentDateMS
{
    NSString *ms = [NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970]*1000];
    //NSLog(@"===MS:%@",ms);
    return ms;
}


#pragma mark -  签名算法
//签名算法如下：
//1. 对除sign以外的所有请求参数进行字典升序排列；
//2. 将以上排序后的参数表进行字符串连接，如key1=value1&key2=value2&key3=value3...keyNvalueN；
//3. 对该字符串进行SHA-1计算；
//4. 转换成16进制小写编码即获得签名串.
- (NSString *)sign:(NSDictionary*)ddic
{
   // NSMutableDictionary *restultDic = [NSMutableDictionary dictionaryWithDictionary:ddic];
    
    // 签名串
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:ddic];
    [paramsDic removeObjectForKey:@"sign"];
    
    // 1、对所有请求参数除sign外进行字典升序排列；
    //dic排序后的key 数组
    NSArray *sortedKeys = [[paramsDic allKeys] sortedArrayUsingSelector: @selector(compare:)];
    //遍历key，将dic的  value 按照顺序存放在value数组中
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *key in sortedKeys) {
        [valueArray addObject:[paramsDic objectForKey:key]];
    }
    
    //  2、将排序后的参数表进行字符串连接，如key1=value1&key2=value2&...keyN=valueN；
    //key1=value1 key2=value2 key3=value3 ；
    NSMutableArray *signArray = [NSMutableArray array];
    for (int i = 0; i < sortedKeys.count; i++) {
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@",sortedKeys[i],valueArray[i]];
        [signArray addObject:keyValueStr];
    }
    //key1=value1&key2=value2&key3=value3 ；
    NSString *sign = [signArray componentsJoinedByString:@"&"];
    
    // 3、 对该字符串进行SHA-1计算，得到签名，并转换成16进制小写编码，如： key1=value1&key2=value2&...keyN=valueNapi secret，得到签名串
   // LMLog(@"====&&&字符串%@",sign);

    NSMutableString *signString = [NSMutableString stringWithString:sign];

    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *stringBytes = [signString dataUsingEncoding: NSUTF8StringEncoding];
    if (CC_SHA1([stringBytes bytes], (unsigned int)[stringBytes length], digest)) {
        NSMutableString *digestString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
        for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
            unsigned char aChar = digest[i];
            [digestString appendFormat:@"%02X", aChar];
        }
        NSString *value =[digestString lowercaseString];
        return value;
    }
    
    return nil;
}

+ (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        
        if ([elements count] <= 1) {
            return nil;
        }
        
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}





@end
