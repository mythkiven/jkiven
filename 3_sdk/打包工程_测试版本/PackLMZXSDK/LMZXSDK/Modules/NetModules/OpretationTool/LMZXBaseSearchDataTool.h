//
//  YJBaseSearchDataTool.h
//  LiMuCycle
//
//  Created by yj on 2017/2/13.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMZXDemoAPI.h"
@class LMZXQueryInfoModel;


// 轮训操作中的状态回调
// 对外提供的状态:8种:
typedef enum {
    
    // 用户退出
    LMZXSDKSearchActionCancel = -6,
    
    // 商户信息错误
    LMZXSDKSearchActionUserInfoError = -5,
    
    // 用户输入错误
    LMZXSDKSearchActionInputError  = -4,
    
    // 网络异常
    LMZXSDKSearchActionNetError = -3,
    
    // 系统异常
    LMZXSDKSearchActionSeverceError= -2,
    
    // 其他异常:请求超时,
    LMZXSDKSearchActionOtherError = -1,
    
    // 查询成功:
    LMZXSDKSearchActionSuccess = 0,
    // 查询中:
    LMZXSDKSearchActionSearching = 1,
    // 登录成功:
    LMZXSDKSearchActionLoginSuccess = 2,
    
    
}LMZXSDKSearchAction;


///////////////////////////////////////////////////////////////////////////////////////////


/** 成功回调:
 @param obj 成功数据
 @param dic 含有任务 id,格式同失败 等其他信息{@"taskID":@"任务 ID",...}
 */
typedef void(^LMSearchSuccess)(id obj,NSDictionary * dic);

/** 失败回调:
 @param error 查询失败的 msg,展示在 SDK 中,替代 block: SearchFailure
 @param type  验证码状态,输出给客户(枚举)
 @param info  含有任务 id,等其他信息{@"token":@"任务 ID",...}
 */
typedef void(^LMSearchFailure)(NSString * error, NSInteger type, NSDictionary* info);

/** 验证码回调:
 @param type 验证码类型(枚举)
 @param code 验证码状态(0,未发送,1已发送)
 eg:
 运营商验证码已经发送: (CommonSendMsgTypePhone,0)
 运营商验证码已经输入完成: (CommonSendMsgTypePhone,1)
 
 */
typedef void(^SmsVerification)(NSInteger type, NSInteger code);


@interface LMZXBaseSearchDataTool : NSObject


///////////////////////////////////////////////////////////////////////////////////////////




//#warning --- 如果有验证码,必须传值.
/** 查询的 model
 
*/
@property (nonatomic, strong) LMZXQueryInfoModel *queryInfoModel;

/**
 查询类型
 */
@property (nonatomic, assign) LMZXSearchItemType searchItemType;

/**
 查询成功回调
 */
@property (nonatomic, copy) LMSearchSuccess searchSuccess;

/**
 查询失败/状态回调
 */
@property (nonatomic, copy) LMSearchFailure searchFailure;

/**
 短信验证
 */
@property (nonatomic, copy) SmsVerification smsVerification;

/**
 用户是否终止查询
 */
@property (nonatomic, assign) BOOL isUserStopSearch;


///////////////////////////////////////////////////////////////////////////////////////////

#pragma mark- 对外方法
/**
 用户终止查询,会有回调
 */
- (void)stopSearch ;

/**
 运营商查询

 @param username 手机号
 @param password 手机服务密码，使用base64编码
 @param contentType 查询指定内容《默认为all 可以指定多选,格式:sms;busi;netsms(短信记录)busi(业务记录)net(上网记录)》
 @param otherInfo 必需卡类型和对应取值如下：北京移动:客服密码 广西电信:身份证号码 山西电信:身份证号码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 */
- (void)searchMobileDataWithUserName:(NSString *)username password:(NSString *)password contentType:(NSString *)contentType otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName;

/**
 运营商查询&成功/失败回调

 @param username 手机号
 @param password 手机服务密码，使用base64编码
 @param contentType 查询指定内容《默认为all 可以指定多选,格式:sms;busi;netsms(短信记录)busi(业务记录)net(上网记录)》
 @param otherInfo 必需卡类型和对应取值如下：北京移动:客服密码 广西电信:身份证号码 山西电信:身份证号码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchMobileDataWithUserName:(NSString *)username password:(NSString *)password contentType:(NSString *)contentType otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName  searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure ;

/**
 运营商查询(传Model)&成功/失败回调

 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchMobileDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;

/**
 网银查询

 @param username 账号
 @param password 密码,使用base64编码
 @param bankCode 银行码表
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 */
- (void)searchEBankDataWithUserName:(NSString *)username password:(NSString *)password bankCode:(NSString *)bankCode idNO:(NSString *)idNO idName:(NSString *)idName;

/**
 网银查询&成功/失败回调

 @param username 账号
 @param password 密码,使用base64编码
 @param bankCode 银行码表
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchEBankDataWithUserName:(NSString *)username password:(NSString *)password bankCode:(NSString *)bankCode idNO:(NSString *)idNO idName:(NSString *)idName searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure ;

/**
 网银查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchEBankDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;

/**
 车险查询

 @param username 账号(授权查询必需)
 @param password 密码,使用base64编码(授权查询必需)
 @param polocyNo 保单号
 @param identityNo 投保人身份证号
 @param type 1:授权查询 2:保单查询
 @param insuranceCompany 投保的保险公司 PICC:中国人民保险 CPIC:太平洋保险 PAIC:平安保险 SPIC:三星保险 CCIC:大地保险
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 */
- (void)searchCarInsuranceDataWithUserName:(NSString *)username password:(NSString *)password polocyNo:(NSString *)polocyNo   identityNo:(NSString *)identityNo type:(NSString *)type insuranceCompany:(NSString *)insuranceCompany idNO:(NSString *)idNO idName:(NSString *)idName;


/**
 车险查询&成功/失败回调
 
 @param username 账号(授权查询必需)
 @param password 密码,使用base64编码(授权查询必需)
 @param polocyNo 保单号
 @param identityNo 投保人身份证号
 @param type 1:授权查询 2:保单查询
 @param insuranceCompany 投保的保险公司 PICC:中国人民保险 CPIC:太平洋保险 PAIC:平安保险 SPIC:三星保险 CCIC:大地保险
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchCarInsuranceDataWithUserName:(NSString *)username password:(NSString *)password polocyNo:(NSString *)polocyNo   identityNo:(NSString *)identityNo type:(NSString *)type insuranceCompany:(NSString *)insuranceCompany idNO:(NSString *)idNO idName:(NSString *)idName searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure ;

/**
 车险查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchCarInsuranceDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;



/**
 淘宝查询

 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 ..
 */

- (void)searchTaobaoDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType;

/**
 淘宝查询&成功/失败回调
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 ..
 */
- (void)searchTaobaoDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure;
/**
 淘宝查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchTaobaoDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;

/**
 京东查询
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名

 */
- (void)searchJdDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType ;



/**
 京东查询&成功/失败回调
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchJdDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure ;
/**
 京东查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchJdDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;

/**
 学信查询
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 */
- (void)searchEducationDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName ;

/**
 学信查询&成功/失败回调
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchEducationDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure ;
/**
 学信查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchEducationDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;


/**
 央行查询
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param middleAuthCode 央行征信身份验证码
 */
- (void)searchCentralBankDataWithUserName:(NSString *)username password:(NSString *)password middleAuthCode:(NSString *)middleAuthCode idNO:(NSString *)idNO idName:(NSString *)idName ;


/**
 央行查询&成功/失败回调
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param middleAuthCode 央行征信身份验证码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchCentralBankDataWithUserName:(NSString *)username password:(NSString *)password middleAuthCode:(NSString *)middleAuthCode idNO:(NSString *)idNO idName:(NSString *)idName searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure ;
/**
 央行查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchCentralBankDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;

/**
 信用卡查询

 @param username 用户账号(163邮箱/126邮箱/sina邮箱/qq邮箱/139邮箱)
 @param password 密码使用base64编码
 @param billType ebank:网银账单(暂不支持) email:邮箱账单
 @param bankCode 账单银行码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 */
- (void)searchCreditCardDataWithUserName:(NSString *)username password:(NSString *)password billType:(NSString *)billType bankCode:(NSString *)bankCode idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType;

/**
 信用卡查询&成功/失败回调
 
 @param username 用户账号(163邮箱/126邮箱/sina邮箱/qq邮箱/139邮箱)
 @param password 密码使用base64编码
 @param billType ebank:网银账单(暂不支持) email:邮箱账单
 @param bankCode 账单银行码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchCreditCardDataWithUserName:(NSString *)username password:(NSString *)password billType:(NSString *)billType bankCode:(NSString *)bankCode idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure;
/**
 信用卡查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchCreditCardDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;









/**
 失信查询

 @param name 姓名或企业名称
 @param identityNo 身份证号或组件机构代码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 */
- (void)searchDishonestDataWithName:(NSString *)name identityNo:(NSString *)identityNo idNO:(NSString *)idNO idName:(NSString *)idName;

/**
 失信查询&成功/失败回调

 @param name 姓名或企业名称
 @param identityNo 身份证号或组件机构代码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchDishonestDataWithName:(NSString *)name identityNo:(NSString *)identityNo idNO:(NSString *)idNO idName:(NSString *)idName searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure;

/**
 失信查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchDishonestDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;

/**
 公积金查询
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param area 地区
 @param realName 真实姓名
 @param otherInfo 其他信息
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 */
- (void)searchHouseFoundDataWithUserName:(NSString *)username password:(NSString *)password area:(NSString *)area realName:(NSString *)realName otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName ;

/**
 公积金查询&成功/失败回调
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param area 地区
 @param realName 真实姓名
 @param otherInfo 其他信息
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchHouseFoundDataWithUserName:(NSString *)username password:(NSString *)password area:(NSString *)area realName:(NSString *)realName otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName  searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure;
/**
 公积金查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchHouseFoundDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;


/**
 社保查询
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param area 地区
 @param realName 真实姓名
 @param otherInfo 其他信息
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 */
- (void)searchSocialSecturityDataWithUserName:(NSString *)username password:(NSString *)password area:(NSString *)area realName:(NSString *)realName otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName ;

/**
 社保查询&成功/失败回调
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param area 地区
 @param realName 真实姓名
 @param otherInfo 其他信息
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchSocialSecturityDataWithUserName:(NSString *)username password:(NSString *)password area:(NSString *)area realName:(NSString *)realName otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName  searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure;
/**
 社保查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchSocialSecturityDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;







/**
 脉脉查询
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 */
- (void)searchMaimaiDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType ;
/**
 脉脉查询&成功/失败回调
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchMaimaiDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType  searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure ;

/**
 脉脉查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchMaimaiDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;

/**
 领英查询
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 */
- (void)searchLinkedinDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType  ;
/**
 领英查询&成功/失败回调
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchLinkedinDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType  searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure ;
/**
 领英查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchLinkedinDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;

/**
 滴滴出行查询
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 */
- (void)searchDidiTaxiDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType  ;
/**
 滴滴出行查询&成功/失败回调
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchDidiTaxiDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType  searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure ;
/**
 滴滴出行查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchDidiTaxiDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;

/**
 携程查询
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 */
- (void)searchCtripDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType  ;
/**
 携程查询&成功/失败回调
 
 @param username 用户账号
 @param password 密码使用base64编码
 @param idNO 查询用户的身份证号
 @param idName 查询用户的真实姓名
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchCtripDataWithUserName:(NSString *)username password:(NSString *)password idNO:(NSString *)idNO idName:(NSString *)idName accessType:(NSString *)accessType cookie:(NSString *)cookie loginType:(NSString*)loginType  searchSuccess:(LMSearchSuccess)success failure:(LMSearchFailure)failure ;
/**
 携程查询(传Model)&成功/失败回调
 
 @param queryInfo 查询条件的模型数据
 @param success 成功回调结果
 @param failure 失败回调
 */
- (void)searchCtripDataWithQueryInfo:(LMZXQueryInfoModel *)queryInfo searchSuccess:(LMSearchSuccess)success  failure:(LMSearchFailure)failure;

/***
 服务器 code 解说:
 
 0000 数据查询成功
 0006 需要输入验证码
 0009 短信写入成功
 0010 受理成功 : 创建任务成功/第一步token 获取成功
 0100 登录成功,登录被查询页面
 
 */



@end
