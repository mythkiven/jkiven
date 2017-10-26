//
//  YJQueryInfoModel.m
//  LiMuCycle
//
//  Created by yj on 2017/2/13.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import "LMZXQueryInfoModel.h"

@implementation LMZXQueryInfoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _identityCardNo = @"";
        _identityName   = @"";
        _username       = @"";
        _password       = @"";
        _otherInfo      = @"";
        _contentType    = @"";
        
        _area       = @"";
        _realname   = @"";

        _middleAuthCode = @"";
        _billType       = @"";
        _bankCode       = @"";

        _name       = @"";
        _identityNo = @"";

        _polocyNo           = @"";
        _type               = @"";
        _insuranceCompany   = @"";
        
        _accessType =@"";
        _cookie     = @"";
    }
    return self;
}

// 运营商:
- (void)setDataMobileWithUserName:(NSString *)username password:(NSString *)password contentType:(NSString *)contentType otherInfo:(NSString *)otherInfo idNO:(NSString *)idNO idName:(NSString *)idName  isJLDX:(BOOL)isjldx{
    _username = username;
    _password = password;
    _contentType = contentType;
    _otherInfo = otherInfo;
    _identityNo = idNO;
    _identityName = idName;
    if (isjldx == YES) {
        _checkTypeForSMS = LMZXCommonSendMsgTypeJLDX;
    }else{
        _checkTypeForSMS = LMZXCommonSendMsgTypePhone;
    }
//    _isSCALJL = isjldx;
    
    
}
// taobao
- (void)setDataTaoBaoWithUserName:(NSString *)username password:(NSString *)password accessType:(NSString *)accessType cookie:(NSString *)cookie idNO:(NSString *)idNO idName:(NSString *)idName  loginType:(NSString*)logintype{
    _username = username;
    _password = password;
    _accessType = accessType;
    _cookie = cookie;
    _identityNo = idNO;
    
    _identityName = idName;
    _loginType = logintype;
    
}
// 车险
- (void)setDataChexianWithAccessType:(NSString *)accessType identityCardNo:(NSString *)identityCardNo identityName:(NSString *)identityName  UserName:(NSString *)username password:(NSString *)password  policyNo:(NSString*)policyNo identityNo:(NSString*)identityNo type:(NSString*)type insuranceCompany:(NSString*)insuranceCompany{
    
    _accessType =accessType;
    // 用户身份证
    _identityCardNo = identityCardNo;
    _identityName = identityName;
    _username = username;
    _password = password;
    _polocyNo =policyNo;
    _identityNo = identityNo;
    _type = type;
    _insuranceCompany = insuranceCompany;
    
}
/**
 网银:
 
 */
- (void)setDataWangyinWithAccessType:(NSString *)accessType identityCardNo:(NSString *)identityCardNo identityName:(NSString *)identityName  UserName:(NSString *)username password:(NSString *)password  bankCode:(NSString*)bankCode{
    _accessType =accessType;
    // 用户身份证
    _identityCardNo = identityCardNo;
    _identityName = identityName;
    _username = username;
    _password = password;
    _bankCode = bankCode;
}
// 信用卡
- (void)setDataCreditBillWithUserName:(NSString *)username password:(NSString *)password accessType:(NSString *)accessType cookie:(NSString *)cookie idNO:(NSString *)idNO idName:(NSString *)idName loginType:(NSString*)logintype bankCode:(NSString*)bankCode billType:(NSString*)billType{
    _username = username;
    _password = password;
    _accessType = accessType;
    _cookie = cookie;
    _identityNo = idNO;
    _identityName = idName;
    _loginType = logintype;
    _bankCode = bankCode;
    _billType = billType;
}
- (void)setDataJDWithUserName:(NSString *)username password:(NSString *)password accessType:(NSString *)accessType cookie:(NSString *)cookie idNO:(NSString *)idNO idName:(NSString *)idName loginType:(NSString*)logintype{
    _username = username;
    _password = password;
    _accessType = accessType;
    _cookie = cookie;
    _identityNo = idNO;
    _identityName = idName;
    _loginType = logintype;
}
@end
