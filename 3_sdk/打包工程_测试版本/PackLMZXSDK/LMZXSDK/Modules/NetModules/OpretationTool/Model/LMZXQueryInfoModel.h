//
//  YJQueryInfoModel.h
//  LiMuCycle
//
//  Created by yj on 2017/2/13.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMZXHomeSearchType.h"
@interface LMZXQueryInfoModel : NSObject


///////////////////// 共用参数 和 API 文档一致 /////////

// 用于 判断验证码类型
@property (assign,nonatomic) LMZXCommonSendMsgType   checkTypeForSMS;


/**
 查询用户的身份证号
 */

@property (nonatomic, copy) NSString *identityCardNo;
/**
 查询用户的真实姓名
 */
@property (nonatomic, copy) NSString *identityName;

/**
 账户
 */
@property (nonatomic, copy) NSString *username;
/**
 密码
 */
@property (nonatomic, copy) NSString *password;


/**
 其他信息
 */
@property (nonatomic, copy) NSString *otherInfo;


/** 运营商
 查询指定内容《默认为all 可以指定多选,格式:sms;busi;netsms(短信记录)busi(业务记录)net(上网记录)》
 */
@property (nonatomic, copy) NSString *contentType;

///**
// 仅作为吉林电信的标识,用于弹框判断,不作为实际查询参数
// */
//@property (nonatomic, assign) BOOL  isSCALJL;

///////////////////// 公积金/社保 /////////

/**
 地区代码
 */
@property (nonatomic, copy) NSString *area;
/**
 真实姓名
 */
@property (nonatomic, copy) NSString *realname;




///////////////////// 征信 /////////
/**
 央行征信授权码
 */
@property (nonatomic, copy) NSString *middleAuthCode;
/**
 信用卡:查询类型(邮箱email)
 */
@property (nonatomic, copy) NSString *billType;
/**
 信用卡:银行代码
 */
@property (nonatomic, copy) NSString *bankCode;


///////////////////// 失信 /////////
/**
 失信个人姓名、机构名称
 */
@property (nonatomic, copy) NSString *name;
/**
 个人身份证号、机构码
 */
@property (nonatomic, copy) NSString *identityNo;


///////////////////// 车险 /////////

/**
 车险：保单号
 */
@property (nonatomic, copy) NSString *polocyNo;
/**
 车险查询类型 1：账户查询，2：保单查询
 */
@property (nonatomic, copy) NSString *type;
/**
 车险公司代码
 */
@property (nonatomic, copy) NSString *insuranceCompany;



///////////////////// 淘宝 /////////
/**
  淘宝 接入方式
 */
@property (nonatomic, copy) NSString *accessType;
/**
 淘宝 cookie
 */
@property (nonatomic, copy) NSString *cookie;

@property (nonatomic, copy) NSString *loginType;



//////////////// 初始化方法:


/**运营商:
 
 */
- (void)setDataMobileWithUserName:(NSString *)username password:(NSString *)password contentType:(NSString *)contentType otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName isJLDX:(BOOL)isjldx;

/**淘宝:
 
 */
- (void)setDataTaoBaoWithUserName:(NSString *)username password:(NSString *)password accessType:(NSString *)accessType cookie:(NSString *)cookie idNO:(NSString *)idNO idName:(NSString *)idName loginType:(NSString*)logintype;

/**
 车险:
 
 */
- (void)setDataChexianWithAccessType:(NSString *)accessType identityCardNo:(NSString *)identityCardNo identityName:(NSString *)identityName  UserName:(NSString *)username password:(NSString *)password  policyNo:(NSString*)policyNo identityNo:(NSString*)identityNo type:(NSString*)type insuranceCompany:(NSString*)insuranceCompany;

/**
 网银:
 */
- (void)setDataWangyinWithAccessType:(NSString *)accessType identityCardNo:(NSString *)identityCardNo identityName:(NSString *)identityName  UserName:(NSString *)username password:(NSString *)password  bankCode:(NSString*)bankCode;

/**信用卡账单:
 
 */
- (void)setDataCreditBillWithUserName:(NSString *)username password:(NSString *)password accessType:(NSString *)accessType cookie:(NSString *)cookie idNO:(NSString *)idNO idName:(NSString *)idName loginType:(NSString*)logintype bankCode:(NSString*)bankCode billType:(NSString*)billType;

/**京东:
 
 */
- (void)setDataJDWithUserName:(NSString *)username password:(NSString *)password accessType:(NSString *)accessType cookie:(NSString *)cookie idNO:(NSString *)idNO idName:(NSString *)idName loginType:(NSString*)logintype;




@end
