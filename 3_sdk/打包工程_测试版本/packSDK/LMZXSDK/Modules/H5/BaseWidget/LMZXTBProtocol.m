//
//  LMZXTBProtocol.m
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/2/16.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXTBProtocol.h"
#import "NSString+LMZXCommon.h"
#import "LMZXTool.h"

#import "LMZXSDK.h"
#import "LMZXHomeSearchType.h"

#define LM_NotificationTB_sendSuccess @"LM_NotificationTB_sendSuccess"

// 成功 URL
#define LMZX_LocationSuccess_TypeURL @"LM_ZXLocationSuccSesstion_TypeURL"
// 登录 URL
#define LMZX_LocationLogin_TypeURL @"LM_ZXLocationLogiSesstion_TypeURL"

// 信用卡账单 当前哪个功能
#define LMZX_LocationFunction_TypeURL @"LM_ZXLocationfuncSesstion_TypeURL"

@interface LMZXTBProtocol()<NSURLSessionDelegate,NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (readwrite, nonatomic, strong) NSURLSession *session;
@property (readwrite, nonatomic, strong) NSMutableData *data;
@property (readwrite, nonatomic, strong) NSURLResponse *response;
@property (readwrite, nonatomic, strong) NSURLConnection * connection;

@property (readwrite, nonatomic, strong) NSMutableArray * QQdata;
@property (readwrite, nonatomic, strong) NSMutableDictionary * QQcid;


@end

static NSString * const protocolKey = @"LMZXProtocolKey321";
static NSString *  username_ = @"";
static NSString *  password_ = @"";


@implementation LMZXTBProtocol


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 
#pragma mark -
#pragma mark - NSURLConnection

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
  
    NSString *url = [[request URL].host stringByAppendingString:[request URL].path];
    
    if ([NSURLProtocol propertyForKey:protocolKey inRequest:request]) {
        return NO;
    }
    
    // 126 的报错处理 URL
    if ([url isEqualToString:@"reg.163.com/services/httpLoginExchgKeyNew"]) {
        return YES;
    }
    // 领英英语
    if ([url isEqualToString:@"www.linkedin.com/uas/login"]) {
        return YES;
    }
    
//    // 携程 accounts.ctrip.com/H5Login/Handler/GetNewValidateCode.ashx
//    if ([url isEqualToString:@"accounts.ctrip.com/H5Login/Handler/LoginAction.ashx"]) {
//        return YES;
//    }
    
    
    NSArray *arr1 = [LMZXTool objectForKey:LMZX_LocationSuccess_TypeURL];
    NSArray *arr2 = [LMZXTool objectForKey:LMZX_LocationLogin_TypeURL];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:arr1];
    [arr addObjectsFromArray:arr2];
    if (arr.count) {
        BOOL jbool=NO;
        for (NSString *str in arr) {
            if ([url  isEqualToString:str]) {
                jbool = YES;
            }
        }
        return jbool;
    }
    return NO;
    
}
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    [self decodeUser:request];
    
    return request;
}
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a
                       toRequest:(NSURLRequest *)b
{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void) startLoading {
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];

    // 领英英语问题
    NSString *url = [[mutableReqeust URL].host stringByAppendingString:[mutableReqeust URL].path];
    if ([url isEqualToString:@"www.linkedin.com/uas/login"]) {
        NSMutableDictionary *headers = [mutableReqeust.allHTTPHeaderFields mutableCopy];
        [headers setObject:@"zh-cn" forKey:@"Accept-Language"];
        mutableReqeust.allHTTPHeaderFields = headers;
    }else
    if ([url isEqualToString:@"www.linkedin.com/uas/login-submit"]) {
        NSMutableDictionary *headers = [mutableReqeust.allHTTPHeaderFields mutableCopy];
        [headers setObject:@"zh-cn" forKey:@"Accept-Language"];
        mutableReqeust.allHTTPHeaderFields = headers;
        
        NSString *str = [[NSString alloc]initWithData:mutableReqeust.HTTPBody  encoding:NSUTF8StringEncoding];
        NSArray *arrr = [str componentsSeparatedByString:@"&client"];
        if (arrr.count>1) {
            NSData* xmlData = [arrr[0] dataUsingEncoding:NSUTF8StringEncoding];
            mutableReqeust.HTTPBody = xmlData;
        }
    }
    
    /** 1
     Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*\/*;q=0.8";
    "Accept-Language" = "zh-cn";
    "User-Agent" = "Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25"
     
     
     
     Accept = "text/plain, *\/*; q=0.01";
    "Accept-Language" = "zh-cn";
    "Content-Type" = "application/x-www-form-urlencoded";
    Origin = "https://www.linkedin.com";
    Referer = "https://www.linkedin.com/uas/login";
    "User-Agent" = "Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25";
    "X-IsAJAXForm" = 1;
    "X-Requested-With" = XMLHttpRequest;

     */
    
    
    [NSURLProtocol setProperty:@(YES)
                        forKey:protocolKey
                     inRequest:mutableReqeust];
    
    self.connection = [NSURLConnection connectionWithRequest:mutableReqeust
                                                    delegate:self];
    
    
}
- (void) stopLoading {
    [self.connection cancel];
    self.connection = nil;
}




+(void)decodeUser:(NSURLRequest*)request{
    NSString *str = [[NSString alloc]initWithData:request.HTTPBody  encoding:NSUTF8StringEncoding];
    NSString *URL = request.URL.absoluteString;
    NSString *pathUrl = [[request URL].host stringByAppendingString:[request URL].path];
   
//#warning TEST
//    // URL	https://mail.10086.cn/Login/Login.ashx?f=1&w=1&c=1&face=B&selStyle=4&_lv=0.2&_fv=66&sidtype=mail&atl=1&authType=2&loginFailureUrl=http%3A%2F%2Fhtml5.mail.10086.cn%2F&loginSuccessUrl=http%3A%2F%2Fhtml5.mail.10086.cn%2Fhtml%2FmailList.html%3Fsource%3D1&clientid=1801
//    // UserName=13359460554&Password=cb38c3737c7922f08478817fa4c37c45eae27088&auto=1&VerifyCode=
//    // 这是139验证码的解决方案,直接传用户名信息到服务器
    
    
    if ([NSString checkURL:pathUrl]) {
        username_ = @"";
        password_ = @"";
        switch ([LMZXSDK shared].lmzxFunction ) {
            case LMZXSDKFunctionCtrip:{// 携程
// 境外:
//countrycode=86&mobile=18643246542&certificateCode=2746b9f5f60733daa79c0551332cf301399154f48bfc7de68f1c432964f7ff2156558e4a6d311cc73828ade7682727cc640b4c866aac1934764cb7e84334d96880afc4e5694bcd97d8e99fd5d0a9ef07de9509ece7632270fcd6b98ca84028704fb1e67ff5b5f8be82b74388362a6f63e72fb27d70def09eb0993b0172245713&captchaID=&signature=064F52B6F1F37DA498395017FEA36B51&imgCode=&onetimetoken=E40C5CEB992C44FAA6739A16E8F98181&cid=09031039210752549253&url=H5login%2Flogin_oversea&page_id=10320656341&userAgent=Mozilla%2F5.0+(iPhone%3B+CPU+iPhone+OS+6_0+like+Mac+OS+X)+AppleWebKit%2F536.26+(KHTML%2C+like+Gecko)+Version%2F6.0+Mobile%2F10A5376e+Safari%2F8536.25&rmsToken=fp%253D8qlwqr-1ggzulf-rjqlj%2526vid%253D1494233251553.2t0wld%2526pageId%253D10320656341%2526r%253Dundefined%2526ip%253Dundefined%2526screen%253D320x568%2526tz%253D%252B8%2526blang%253Dzh-CN%2526oslang%253Dzh-CN%2526ua%253DMozilla%25252F5.0%252520(iPhone%25253B%252520CPU%252520iPhone%252520OS%2525206_0%252520like%252520Mac%252520OS%252520X)%252520AppleWebKit%25252F536.26%252520(KHTML%25252C%252520like%252520Gecko)%252520Version%25252F6.0%252520Mobile%25252F10A5376e%252520Safari%25252F8536.25%2526v%253Dm14
                str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSArray *arrr = [str componentsSeparatedByString:@"&Password="];
                if (arrr.count == 2) { // password_=
                    password_ = [arrr[1] componentsSeparatedByString:@"="][0];
                }
                NSArray *arr = [str componentsSeparatedByString:@"username="];
                if (arr.count == 2) { // username=
                    username_ = [arr[1] componentsSeparatedByString:@"&"][0];
                }
                NSArray *arrjw = [str componentsSeparatedByString:@"mobile="];
                if (arrjw.count == 2) { // username=
                    username_ = [arrjw[1] componentsSeparatedByString:@"&"][0];
                }
                if (username_&&username_.length) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"ctrip",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
                }
            }
            case LMZXSDKFunctionDiDiTaxi:{// 滴滴
                
                    str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    NSArray *arrr = [str componentsSeparatedByString:@"cell\":\""];
                    if (arrr.count == 2) { // username=
                        username_ = [arrr[1] componentsSeparatedByString:@"\""][0];
                    }
                    NSArray *arr = [str componentsSeparatedByString:@"password\":\""];
                    if (arr.count == 2) { // username=
                        password_ = [arr[1] componentsSeparatedByString:@"\""][0];
                    }
                    if (username_&&username_.length) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"didi",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
                    }
            }
            case LMZXSDKFunctionLinkedin:{ // 领英
                if (str.length>10&&str.length<10000) {
                    
                    NSArray *arrr = [str componentsSeparatedByString:@"session_key="];
                    if (arrr.count == 2) { // username=
                        username_ = [arrr[1] componentsSeparatedByString:@"&"][0];
                    }
                    
                    NSArray *arr = [str componentsSeparatedByString:@"session_password="];
                    if (arr.count == 2) { // username=
                        password_ = [arr[1] componentsSeparatedByString:@"&"][0];
                    }
                    
                    if (username_&&username_.length) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"linkedin",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
                    }
                }
                
                break;
            }
                
            case LMZXSDKFunctionMaimai:{ // 脉脉
                if (str.length>10&&str.length<10000) {
                     NSArray *arrr = [str componentsSeparatedByString:@"&"];
                    int flag = 0;
                    for (NSString *str in arrr) {
                        if ([str hasPrefix:@"m="]) {
                            username_ = [str substringFromIndex:1];
                            flag += 1;
                        } else if ([str hasPrefix:@"p="]) {
                            password_ = [str substringFromIndex:1];
                            flag += 1;
                        }
                        if (flag == 2) {break;}
                    }
                    
                    if (username_&&username_.length) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"maimai",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
                    }
                }
                
                break;
            }
            case LMZXSDKFunctionJD:{ // 京东
                if (str.length>10&&str.length<10000) {
                    
                    NSArray *arrr = [str componentsSeparatedByString:@"&loginname="];
                    if (arrr.count == 2) { // username=
                        username_ = [arrr[1] componentsSeparatedByString:@"&"][0];
                    }
                    
                    NSArray *arr = [str componentsSeparatedByString:@"&nloginpwd="];
                    if (arr.count == 2) { // username=
                        password_ = [arr[1] componentsSeparatedByString:@"&"][0];
                    }
                    
                    if (username_&&username_.length) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"jd",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
                    }
                }
                
                break;
            }
            case LMZXSDKFunctionTaoBao:{ // 淘宝 taobao-1
                
                if (str.length>10&&str.length<10000) {
                    
                    // 方式 1
                    NSArray *uarr = [str componentsSeparatedByString:@"username="];
                    if (uarr.count == 2) {
                        username_ = [uarr[1] componentsSeparatedByString:@"&"][0]; //  taobao-1
                    }else {
                        NSArray *uarr2 = [str componentsSeparatedByString:@"username"];
                        if(uarr2.count ==2){
                            username_ = [uarr2[1] componentsSeparatedByString:@"="][1];
                            username_ = [username_ componentsSeparatedByString:@"&"][0];
                        }
                    }
                    
                    
                    NSArray *parr = [str componentsSeparatedByString:@"password="];
                    if (parr.count == 2) {
                        password_ = [parr[1] componentsSeparatedByString:@"&"][0];
                    }else {
                        NSArray *parr2 = [str componentsSeparatedByString:@"password"];
                        if(parr2.count ==2){
                            password_ = [parr2[1] componentsSeparatedByString:@"="][1];
                            password_ = [password_ componentsSeparatedByString:@"&"][0];
                        }
                    }
                    
                    // 方式 2
                    NSArray *tarr = [str componentsSeparatedByString:@"TPL_username="];
                    if (tarr.count == 2 && username_.length>1) { // username=
                        username_ = [[tarr lastObject] componentsSeparatedByString:@"&"][0];
                    }
                }
                
                if (username_&&username_.length) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"taobao",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
                }
                
                break;
            }
            case LMZXSDKFunctionCreditCardBill:{ // 信用卡账单
                
                NSNumber * num =  [LMZXTool objectForKey:LMZX_LocationFunction_TypeURL];
                if (num) {
                    switch (num.integerValue) {
                        case LMZXCreditCardBillMailTypeQQ:{
                            
                            if ([NSString checkURL:pathUrl]) {
                                if (str.length>10&&str.length<10000) {
                                    
                                    NSArray *arrr = [str componentsSeparatedByString:@"&loginname="];
                                    if (arrr.count == 2) { // username=
                                        username_ = [arrr[1] componentsSeparatedByString:@"&"][0];
                                    }
                                    
                                    NSArray *arr = [str componentsSeparatedByString:@"&nloginpwd="];
                                    if (arr.count == 2) { // username=
                                        password_ = [arr[1] componentsSeparatedByString:@"&"][0];
                                    }
                                    if (username_&&username_.length) {
                                        [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"qq",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
                                    }
                                }
                            }
                            
                            break;
                        }
                        case LMZXCreditCardBillMailTypesina:{
                            if ([NSString checkURL:pathUrl]) {
                                username_ = nil;
                                if (URL.length>10&&URL.length<10000) {
                                    NSArray *arr = [URL componentsSeparatedByString:@"&username="];
                                    if (arr.count == 2) { // username=
                                        username_ =arr[1];
                                        [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"sina",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
                                    }
                                }
                            }
                            break;
                        }
                        case LMZXCreditCardBillMailType139:{
                            if ([NSString checkURL:pathUrl]) {
                                
                                if (str.length>10&&str.length<10000) {
                                    NSArray *arr = [str componentsSeparatedByString:@"&Password="];
                                    if (arr.count == 2) { // username=
                                        username_ = [arr[0] componentsSeparatedByString:@"="][1];
                                        username_ = [username_ stringByAppendingString:@"@139.com"];
                                        password_ = arr[1];
                                        [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"139",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
                                    }
                                }
                            }
                            break;
                        }
                        case LMZXCreditCardBillMailType126:{
                            if ([NSString checkURL:pathUrl]) {
                                NSString *string = request.URL.absoluteString;
                                if (string.length>10&&string.length<10000) {
                                    NSArray *arr = [string componentsSeparatedByString:@"username="];
                                    if (arr.count == 2) { // username=
                                        username_ = [arr[1] componentsSeparatedByString:@"&"][0];
                                        [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"126",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
                                    }
                                }
                            }
                            break;
                        }
                        case LMZXCreditCardBillMailType163:{
                            if ([NSString checkURL:pathUrl]) {
                                if (URL.length>10&&URL.length<10000) {
                                    NSArray *arr = [URL componentsSeparatedByString:@"&username="];
                                    if (arr.count == 2) { // username=
                                        username_ =arr[1];
                                        [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"163",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
                                    }
                                }
                            }
                            break;
                        }
                        default:
                            break;
                    }
                }
                
                
                break;
            }
            default:
                break;
        }
        
        
    }
    
    
    // 以下保留,方式1
    
/**
 
 // 淘宝
 //    if ([NSString checkURL:url]) {
 if ([url isEqualToString:@"login.m.taobao.com/login.htm"]) { // taobao -1
 if (str.length>10&&str.length<10000) {
 if ([str hasStr:@"username"]) {
 NSArray *arr = [str componentsSeparatedByString:@"username="];
 
 if (arr.count == 2) {
 username_ = [arr[1] componentsSeparatedByString:@"&"][0];
 }else {
 NSArray *arr2 = [str componentsSeparatedByString:@"username"];
 if(arr2.count ==2){
 username_ = [arr2[1] componentsSeparatedByString:@"="][1];
 username_ = [username_ componentsSeparatedByString:@"&"][0];
 }
 }
 }
 if ([str hasStr:@"password"]) {
 NSArray *arr = [str componentsSeparatedByString:@"password="];
 
 if (arr.count == 2) {
 password_ = [arr[1] componentsSeparatedByString:@"&"][0];
 }else {
 NSArray *arr2 = [str componentsSeparatedByString:@"password"];
 if(arr2.count ==2){
 password_ = [arr2[1] componentsSeparatedByString:@"="][1];
 password_ = [password_ componentsSeparatedByString:@"&"][0];
 }
 }
 }
 
 if (username_) {
 [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"taobao",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
 }
 
 }
 }
 // 淘宝
 //    if ([NSString checkURL:url]) {
 if ([url isEqualToString: @"login.m.taobao.com/msg_login.htm"]) {
 if (str.length>10&&str.length<10000) {
 NSArray *arr = [str componentsSeparatedByString:@"TPL_username="];
 if (arr.count == 2) { // username=
 username_ = [[arr lastObject] componentsSeparatedByString:@"&"][0];
 [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"taobao",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
 }
 }
 
 }
 // 126
 //    if ([NSString checkURL:url]) {
 if ([url isEqualToString: @"passport.126.com/next.jsp"]) {
 NSString *string = request.URL.absoluteString;
 if (string.length>10&&string.length<10000) {
 NSArray *arr = [string componentsSeparatedByString:@"username="];
 if (arr.count == 2) { // username=
 username_ = [arr[1] componentsSeparatedByString:@"&"][0];
 [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"126",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
 }
 }
 }
 
 // 139
 //    if ([NSString checkURL:url]) {
 if ([url isEqualToString: @"mail.10086.cn/Login/Login.ashx"]) {
 
 if (str.length>10&&str.length<10000) {
 NSArray *arr = [str componentsSeparatedByString:@"&Password="];
 if (arr.count == 2) { // username=
 username_ = [arr[0] componentsSeparatedByString:@"="][1];
 username_ = [username_ stringByAppendingString:@"@139.com"];
 password_ = arr[1];
 [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"139",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
 }
 }
 }
 
 // 163
 //    if ([NSString checkURL:url]) {
 if ([url isEqualToString: @"reg.163.com/httpLoginVerifyNew.jsp"]) {
 
 if (URL.length>10&&URL.length<10000) {
 NSArray *arr = [URL componentsSeparatedByString:@"&username="];
 if (arr.count == 2) { // username=
 username_ =arr[1];
 [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"163",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
 }
 }
 }
 // sina
 //    if ([NSString checkURL:url]) {
 if ([url isEqualToString:@"mail.sina.cn/cgi-bin/sla.php"]) {
 username_ = nil;
 if (URL.length>10&&URL.length<10000) {
 NSArray *arr = [URL componentsSeparatedByString:@"&username="];
 if (arr.count == 2) { // username=
 username_ =arr[1];
 [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"sina",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
 }
 }
 }
 // JD
 //    if ([NSString checkURL:url]) {
 if ([url isEqualToString:@"passport.jd.com/uc/loginService"]) {
 if (str.length>10&&str.length<10000) {
 
 NSArray *arrr = [str componentsSeparatedByString:@"&loginname="];
 if (arrr.count == 2) { // username=
 username_ = [arrr[1] componentsSeparatedByString:@"&"][0];
 }
 
 NSArray *arr = [str componentsSeparatedByString:@"&nloginpwd="];
 if (arr.count == 2) { // username=
 password_ = [arr[1] componentsSeparatedByString:@"&"][0];
 }
 if (username_&&password_) {
 [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"jd",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
 }
 }
 }
 // QQ
 //    if ([NSString checkURL:url]) {
 if ([url isEqualToString:@"w.mail.qq.com/cgi-bin/login"]) {
 if (str.length>10&&str.length<10000) {
 
 NSArray *arrr = [str componentsSeparatedByString:@"&loginname="];
 if (arrr.count == 2) { // username=
 username_ = [arrr[1] componentsSeparatedByString:@"&"][0];
 }
 
 NSArray *arr = [str componentsSeparatedByString:@"&nloginpwd="];
 if (arr.count == 2) { // username=
 password_ = [arr[1] componentsSeparatedByString:@"&"][0];
 }
 if (username_&&password_) {
 [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"qq",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
 }
 }
 }
 
 //
 
 */
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    [self.client URLProtocol:self
            didFailWithError:error];
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
        if ([httpRes statusCode] == 302) {
            NSMutableURLRequest *req = [request copy];
            [NSURLProtocol removePropertyForKey:protocolKey inRequest:req];
            request = [req copy];
            [self.client URLProtocol:self wasRedirectedToRequest:request redirectResponse:response];
        }
    }
    
    //// 以下注释
    
    if (response != nil)
    {
        NSHTTPURLResponse *re = (NSHTTPURLResponse *)response;
        NSString *pathURL = [re.URL.host stringByAppendingString:re.URL.path];
        NSString *setCookie = [re.allHeaderFields objectForKey:@"Set-Cookie"];
        
        if (setCookie) {
            
           // NSString*cookie=@"";
            
            // 139
            if ([NSString checkURL:pathURL]) {
//            if ([@"mail.10086.cn/Login/Login.ashx" isEqualToString:pathURL]) {
            
               [self cookie139:re.allHeaderFields[@"Set-Cookie"]];
//              [self decodeCookie:response];
                
//                [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"1",@"code":@"139",@"username":username_,@"password":password_,@"cookie":cookie}];
            }
            // QQ 
            else if ([@"ptlogin4.mail.qq.com/check_sig" isEqualToString:pathURL]) {
                [self decodeCookie:response];
            }
//            // 126
//            else if ([@"mail.126.com/entry/cgi/ntesdoor" isEqualToString:pathURL] | [@"passport.126.com/next.jsp" isEqualToString:pathURL]) {
//                
//                [self decodeCookie:response];
//                [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"126",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//            }// 163
//            else if ([@"mail.163.com/entry/cgi/ntesdoor" isEqualToString:pathURL]) {
//                
//                [self decodeCookie:response];
//                [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"163",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//            }
//
            
            if ([pathURL isEqualToString:@"w.mail.qq.com/cgi-bin/login"]) {
                [self decodeCookie:response];
                
            }
        }
        
    }
    return request;
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return YES;
}

- (void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [self.client URLProtocol:self
didReceiveAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection
didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [self.client URLProtocol:self
didCancelAuthenticationChallenge:challenge];
}


- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    if (response != nil) {
        
        NSHTTPURLResponse *re = (NSHTTPURLResponse *)response;
        NSString *setCookie = [re.allHeaderFields objectForKey:@"Set-Cookie"];
        
        
        if (setCookie) {
            
            
            NSString *url = [[response URL].host stringByAppendingString:[response URL].path];
            
            
            // QQ
            if ([url isEqualToString:@"w.mail.qq.com/cgi-bin/login"]) {
                [self decodeCookie:response];
            }
            
            // 126 的报错处理 URL
            if ([url isEqualToString:@"reg.163.com/services/httpLoginExchgKeyNew"]) {
                
                NSHTTPURLResponse *re = (NSHTTPURLResponse *)response;
                NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:re.allHeaderFields forURL:[response URL]];
                NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                
                for (NSHTTPCookie *cookie in cookies) {
                    
                    if (cookie.value) {
                        [cookieJar setCookie:cookie];
                    }
                }
                
            }
            
        }
    }
    [self.client URLProtocol:self
          didReceiveResponse:response
          cacheStoragePolicy:NSURLCacheStorageAllowed];
    
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    if (data.length>10) {
        NSString *pathUrl = [connection.currentRequest.URL.host stringByAppendingString:connection.currentRequest.URL.path];
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        // didi 
        if ([NSString checkURL:pathUrl]) {
            if ([dic isKindOfClass:[NSDictionary class]] &&dic.allKeys) {
                NSString *cell = dic[@"cell"];
                NSString *ticket = dic[@"ticket"];
                if (cell.length>5&&ticket.length>5) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"1",@"code":@"didi",@"username":@"",@"password":@"",@"cookie": [NSString stringWithFormat:@"cell=%@&ticket=%@",cell,ticket]}];
                }
            }
        }
    }
    
    [self.client URLProtocol:self
                 didLoadData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.client URLProtocolDidFinishLoading:self];
}


-(void)decodeCookie:(NSURLResponse*)response {
    if (!self.QQcid) self.QQcid = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString *url = [[response URL].host stringByAppendingString:[response URL].path];
    NSHTTPURLResponse *re = (NSHTTPURLResponse *)response;
    NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:re.allHeaderFields forURL:[response URL]];
    for (NSHTTPCookie *cookie in cookies) {
//
        if (cookie.value) {
            if (cookie.value.length>0) {
                [self.QQcid setValue:cookie.value forKey:cookie.name];
                // QQ
                if ([re.allHeaderFields objectForKey:@"Set-Cookie" ]&&[url isEqualToString:@"w.mail.qq.com/cgi-bin/login"]) {
                    if ([cookie.name isEqualToString:@"qm_username"]) {
                        username_ =[cookie.value stringByAppendingString:@"@qq.com"];
                    }
                    if (username_&&username_.length) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"qq",@"username":username_,@"password":password_,@"cookie":@"NULL"}];
                    }
                    
                }
                
            }
        }
    }
}
-(NSString*)cookie139:(NSString*)ss{
    
    NSArray<NSString*>* cookies = [ss componentsSeparatedByString:@";"];
    NSMutableArray *mmarr = [NSMutableArray arrayWithArray:@[]];
    NSMutableArray *cookieValue = [NSMutableArray arrayWithArray:@[]];
    
    
    for(NSString *cookie in cookies){
        NSArray *array = [cookie componentsSeparatedByString:@", "];
        if (array) {
            for (NSString *sss in array) {
                [mmarr addObject:sss];
            }
        }else
            [mmarr addObject:cookie];
        
    }
    
    for (NSString *cookie in mmarr) {
        if ([cookie hasPrefix:@"a_l="]&&cookie.length>=6) {
            [cookieValue addObject:cookie];
        }
        if ([cookie hasPrefix:@"a_l2="]) {
            [cookieValue addObject:cookie];
        }
        if ([cookie hasPrefix:@"areaCode"]) {
            [cookieValue addObject:cookie];
        }
        if ([cookie hasPrefix:@"cookiepartid="]) {
            [cookieValue addObject:cookie];
        }
        if ([cookie hasPrefix:@"cookiepartid2149="]) {
            [cookieValue addObject:cookie];
        }
        if ([cookie hasPrefix:@"html5SkinPath2149="]) {
            [cookieValue addObject:cookie];
        }
        if ([cookie hasPrefix:@"Login_UserNumber="]) {
            [cookieValue addObject:cookie];
        }
        if ([cookie hasPrefix:@"Os_SSo_Sid="]) {
            [cookieValue addObject:cookie];
        }
        if ([cookie hasPrefix:@"provCode2149="]) {
            [cookieValue addObject:cookie];
        }
        if ([cookie hasPrefix:@"RMKEY="]) {
            [cookieValue addObject:cookie];
        }
        if ([cookie hasPrefix:@"fromhtml5="]) {
            [cookieValue addObject:cookie];
        }
    }
    
    return [cookieValue componentsJoinedByString:@";"];
    
}

#pragma mark -
#pragma mark - QQ 方案 2 保留


//-(void)cookieQQ:(NSString*)ss request:(NSURLRequest*)request with:(BOOL)send {
//
//
//
//    //    NSMutableArray *marr =  [NSMutableArray arrayWithCapacity:0];
//    NSArray<NSString*>* Ccookies = [ss componentsSeparatedByString:@"; "];
//    NSMutableArray *mmarr = [NSMutableArray arrayWithArray:@[]];
//
//
//
//
//    for(NSString *cookie in Ccookies){
//        NSArray *array = [cookie componentsSeparatedByString:@", "];
//        if (array) {
//            for (NSString *sss in array) {
//                [mmarr addObject:sss];
//            }
//        }else
//            [mmarr addObject:cookie];
//
//    }
//
//    for (NSString *cookie in mmarr) {
//        if ([cookie hasPrefix:@"edition="]&&cookie.length>=6) {
//            [self.QQdata addObject:cookie];
//        }else
//            if ([cookie hasPrefix:@"mpwd="]) {
//                [self.QQdata addObject:cookie];
//            }else
//                if ([cookie hasPrefix:@"msid="]) {
//                    [self.QQdata addObject:cookie];
//                }else
//                    if ([cookie hasPrefix:@"new_mail_num="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"p_lskey="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"p_luin="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"p_skey="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"p_uin="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"pcache="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"promote_iphone="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"qm_flag="]) {
//                            [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"qm_username="]) {
//                       //            username_ =[cookie componentsSeparatedByString: @"="].lastObject;
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"qqmail_alias="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"sid="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"ssl_edition="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"username="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"device="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"lskey="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"luin="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"pt2gguin="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"ptisp="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"qm_lg="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"RK="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"skey="]) {
//                        [self.QQdata addObject:cookie];
//                    }else if ([cookie hasPrefix:@"uin="]) {
//                        [self.QQdata addObject:cookie];
//                    }
//
//
//    }
//
//    if (send) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"1",@"username":username_,@"password":password_,@"cookie":[self.QQdata componentsJoinedByString:@";"]}];
//        //        [self.QQdata removeAllObjects];
//    }
//
//
//    return;
//    if (!self.QQdata) {
//        self.QQdata = [NSMutableArray arrayWithCapacity:0];
//    }
//    [self.QQdata addObject:@"111"];
//    NSMutableArray *nmarr = [NSMutableArray arrayWithArray:@[]];
//    NSArray<NSString*>* cookies = [ss componentsSeparatedByString:@"; "];
//    for(NSString *cookie in cookies){
//        NSArray *array = [cookie componentsSeparatedByString:@", "];
//        if (array) {
//            for (NSString *sss in array) {
//                [nmarr addObject:sss];
//            }
//        }else
//            [nmarr addObject:cookie];
//
//    }
//
//
//    for (NSString *cookie in nmarr) {
//        // Get this cookie's name and value
//        NSArray<NSString *> *comps = [cookie componentsSeparatedByString:@"="];
//        if (comps.count < 2) {
//            continue;
//        }
//        if (!comps.lastObject) {
//            continue;
//        }
//        if ([comps.lastObject isEqualToString:@""]) {
//            continue;
//        }
//
//        // we need NSHTTPCookieOriginURL for NSHTTPCookie to be created
//        NSString* cookieWithURL = [NSString stringWithFormat:@"%@; ORIGINURL=%@", cookie, request.URL];
//        NSHTTPCookie* httpCookie = [cookieWithURL cookie];
//
//        if (httpCookie) {
//            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:httpCookie];
//        }
//
//    }
//
//    NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
//    NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//
//    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//        [cookieDic setObject:cookie.value forKey:cookie.name];
//    }
//
//    for (NSString *key in cookieDic) {
//        NSString *appendString = [NSString stringWithFormat:@"%@=%@;", key, [cookieDic valueForKey:key]];
//        [cookieValue appendString:appendString];
//    }
//
//
//
//    return;
//
//
//}

#pragma mark -
#pragma mark - cookie 方案1 保留

//////////////////////////////// NSURLConnection  /////////////////////////////////////////////

//
//- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
//{
//    
//    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
//        if ([httpRes statusCode] == 302) {
//            NSMutableURLRequest *req = [request copy];
//            [NSURLProtocol removePropertyForKey:protocolKey inRequest:req];
//            request = [req copy];
//            [self.client URLProtocol:self wasRedirectedToRequest:request redirectResponse:response];
//        }
//    }
//    
//    
//    if (response != nil)
//    {
//        
//        
//        NSHTTPURLResponse *re = (NSHTTPURLResponse *)response;
//        NSString *pathURL = [re.URL.host stringByAppendingString:re.URL.path];
//        NSString *setCookie = [re.allHeaderFields objectForKey:@"Set-Cookie"];
//        
//        if (setCookie) {
//            
//            NSString*cookie=@"";
//            
//            // 139
//            if ([@"mail.10086.cn/Login/Login.ashx" isEqualToString:pathURL]) {
//                cookie = [self cookie139:re.allHeaderFields[@"Set-Cookie"]];
//                //              [self decodeCookie:response];
//                
//                [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"1",@"code":@"139",@"username":username_,@"password":password_,@"cookie":cookie}];
//            }
//            // QQ
//            else if ([@"ptlogin4.mail.qq.com/check_sig" isEqualToString:pathURL]) {
//                
//                [self decodeCookie:response];
//                [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"qq",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//            }// 126
//            else if ([@"mail.126.com/entry/cgi/ntesdoor" isEqualToString:pathURL] | [@"passport.126.com/next.jsp" isEqualToString:pathURL]) {
//                
//                [self decodeCookie:response];
//                [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"126",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//            }// 163
//            else if ([@"mail.163.com/entry/cgi/ntesdoor" isEqualToString:pathURL]) {
//                
//                [self decodeCookie:response];
//                [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"163",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//            }
//            // sina  3
//            else if ([@"mail.sina.cn/cgi-bin/sla.php" isEqualToString:pathURL]) {
//                
//                [self decodeCookie:response];
//                [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"1",@"code":@"sina",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//            }
//        }
//        
//    }
//    return request;
//}
//
//- (void)connection:(NSURLConnection *)connection
//didReceiveResponse:(NSURLResponse *)response
//{
//    if (response != nil) {
//        
//        NSHTTPURLResponse *re = (NSHTTPURLResponse *)response;
//        NSString *setCookie = [re.allHeaderFields objectForKey:@"Set-Cookie"];
//        
//        if (setCookie) {
//            
//            
//            NSString *url = [[response URL].host stringByAppendingString:[response URL].path];
//            
//            
//            // QQ
//            if ([url isEqualToString:@"w.mail.qq.com/cgi-bin/login"]) {
//                [self decodeCookie:response];
//                [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"qq",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//                
//            }else if ([url isEqualToString:@"w.mail.qq.com/cgi-bin/today"]) {
//                [self decodeCookie:response];
//                [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"1",@"code":@"qq",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//                
//            }else if ([url isEqualToString:@"ptlogin4.mail.qq.com/check_sig"]) {
//                [self decodeCookie:response];
//                [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"qq",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//                
//            }else
//                // 126
//                if ([@"mail.126.com/m/main.jsp" isEqualToString:url]) {
//                    [self decodeCookie:response];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"1",@"code":@"126",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//                }else
//                    // 163
//                    if ([@"reg.163.com/httpLoginVerifyNew.jsp" isEqualToString:url]) {
//                        [self decodeCookie:response];
//                        [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"163",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//                    }else
//                        //163
//                        if ([@"mail.163.com/m/main.jsp" isEqualToString:url]) {
//                            [self decodeCookie:response];
//                            [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"1",@"code":@"163",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//                        }else
//                            // sina ->2
//                            if ([@"passport.sina.cn/sso/crossdomain" isEqualToString:url]) {
//                                [self decodeCookie:response];
//                                [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"sina",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//                            }else
//                                //// sina ->1
//                                if ([@"login.sina.com.cn/sso/login.php" isEqualToString:url]) {
//                                    [self decodeCookie:response];
//                                    [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"0",@"code":@"sina",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//                                }else
//                                    // sina 3
//                                    if ([@"m0.mail.sina.cn/mobile/index.php" isEqualToString:url]) {
//                                        [self decodeCookie:response];
//                                        [[NSNotificationCenter defaultCenter] postNotificationName:LM_NotificationTB_sendSuccess object:@{@"status":@"1",@"code":@"sina",@"username":username_,@"password":password_,@"cookie":self.QQcid}];
//                                    }
//            
//        }
//    }
//    [self.client URLProtocol:self
//          didReceiveResponse:response
//          cacheStoragePolicy:NSURLCacheStorageAllowed];
//    
//}
//
//-(void)decodeCookie:(NSURLResponse*)response {
//    if (!self.QQcid) self.QQcid = [NSMutableDictionary dictionaryWithCapacity:0];
//    NSString *url = [[response URL].host stringByAppendingString:[response URL].path];
//    NSHTTPURLResponse *re = (NSHTTPURLResponse *)response;
//    NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:re.allHeaderFields forURL:[response URL]];
//    for (NSHTTPCookie *cookie in cookies) {
//        //        
//        if (cookie.value) {
//            if (cookie.value.length>0) {
//                [self.QQcid setValue:cookie.value forKey:cookie.name];
//                // QQ
//                if ([re.allHeaderFields objectForKey:@"Set-Cookie" ]&&[url isEqualToString:@"w.mail.qq.com/cgi-bin/login"]) {
//                    if ([cookie.name isEqualToString:@"qm_username"]) {
//                        username_ =[cookie.value stringByAppendingString:@"@qq.com"];
//                    }
//                }
//                
//            }
//        }
//    }
//}
//-(NSString*)cookie139:(NSString*)ss{
//    
//    NSArray<NSString*>* cookies = [ss componentsSeparatedByString:@";"];
//    NSMutableArray *mmarr = [NSMutableArray arrayWithArray:@[]];
//    NSMutableArray *cookieValue = [NSMutableArray arrayWithArray:@[]];
//    
//    
//    for(NSString *cookie in cookies){
//        NSArray *array = [cookie componentsSeparatedByString:@", "];
//        if (array) {
//            for (NSString *sss in array) {
//                [mmarr addObject:sss];
//            }
//        }else
//            [mmarr addObject:cookie];
//        
//    }
//    
//    for (NSString *cookie in mmarr) {
//        if ([cookie hasPrefix:@"a_l="]&&cookie.length>=6) {
//            [cookieValue addObject:cookie];
//        }
//        if ([cookie hasPrefix:@"a_l2="]) {
//            [cookieValue addObject:cookie];
//        }
//        if ([cookie hasPrefix:@"areaCode"]) {
//            [cookieValue addObject:cookie];
//        }
//        if ([cookie hasPrefix:@"cookiepartid="]) {
//            [cookieValue addObject:cookie];
//        }
//        if ([cookie hasPrefix:@"cookiepartid2149="]) {
//            [cookieValue addObject:cookie];
//        }
//        if ([cookie hasPrefix:@"html5SkinPath2149="]) {
//            [cookieValue addObject:cookie];
//        }
//        if ([cookie hasPrefix:@"Login_UserNumber="]) {
//            [cookieValue addObject:cookie];
//        }
//        if ([cookie hasPrefix:@"Os_SSo_Sid="]) {
//            [cookieValue addObject:cookie];
//        }
//        if ([cookie hasPrefix:@"provCode2149="]) {
//            [cookieValue addObject:cookie];
//        }
//        if ([cookie hasPrefix:@"RMKEY="]) {
//            [cookieValue addObject:cookie];
//        }
//        if ([cookie hasPrefix:@"fromhtml5="]) {
//            [cookieValue addObject:cookie];
//        }
//    }
//    
//    return [cookieValue componentsJoinedByString:@";"];
//    
//}




@end
