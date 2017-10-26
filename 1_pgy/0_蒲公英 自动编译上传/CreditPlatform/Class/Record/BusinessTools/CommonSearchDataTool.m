//
//  CommonBaseDataTool.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/11.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "CommonSearchDataTool.h"
#import "CommonSendMsgVC.h"
@interface CommonSearchDataTool()
/**
 mobile(手机信息)
 credit(央行信用)
 jd(京东数据)
 housefund (公积金)
 socialsecurity (社保)
 education (学信网)
 maimai（脉脉）
 linkedin(领英)
 taobao（淘宝）
 */
@property (strong,nonatomic) NSString   *bizType;
//成功查询的结果，用于标记统计数据
@property (strong,nonatomic) NSString   *successType;

@end




@implementation CommonSearchDataTool


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mrak -  轮训逻辑
- (void)requestData {
    
    if (!(_version&&_version.length)) {
        //默认是1.3.0 首次历史接口
        _version = VERSION_APP_1_3_0;
    }   
    
    
    __weak typeof(self) weakSelf = self;
    NSDictionary *dict2 = @{@"mobile":[kUserManagerTool mobile],
                            @"userPwd":[kUserManagerTool userPwd],
                            @"token":_token};
    __block NSString *status = nil;
    // 2.获取状态
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryInterfaceStatus]  timeoutInterval:self.timeOut params:dict2 success:^(id responseObj) {
        MYLog(@"第二步拿到-------%@",responseObj);
        id obj =  responseObj[@"data"];
        BOOL ss = [responseObj[@"data"] isKindOfClass:[NSNull class]];
        if (obj&&!ss) {
            status = responseObj[@"data"][@"code"];
            _token = responseObj[@"data"][@"token"];
            MYLog(@"第二步状态-------%@",status);
            if ([status isEqualToString:@"0000"]) {
                NSDictionary *dict3 = @{@"method":urlJK_queryResult,
                                        @"mobile":[kUserManagerTool mobile],
                                        @"userPwd":@"0000", // 无需该字段
                                        @"token":_token,
                                        @"bizType":self.bizType,
                                        @"appVersion":_version};
                // 3.获取查询结果
                [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryResult] params:dict3 success:^(id responseObj) {
                    MYLog(@"第三步拿到-------%@",responseObj);
                    
                    if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                        [weakSelf removeTimer];
                        
                        if ([self.bizType isEqualToString:@"credit"]) {//央行征信。。。数据结构不同
                            if (responseObj[@"data"][@"creditRespVo"] && [responseObj[@"data"][@"creditRespVo"][@"code"] isEqualToString:@"0000"]) {
                                [TalkingData trackEvent:_successType label:TalkingDataLabel];
                                weakSelf.searchSuccess(responseObj);
                            }else{
                                [self sendErrorInfo:responseObj[@"data"][@"creditRespVo"][@"msg"]];
                            }
                        }else if ([self.bizType isEqualToString:@"jd"]) {//京东。。。数据结构不同
                            if (responseObj[@"data"][@"jdRespVo"] &&[responseObj[@"data"][@"jdRespVo"][@"code"] isEqualToString:@"0000"]) {//京东。。。数据结构不同
                                [TalkingData trackEvent:_successType  label:TalkingDataLabel];
                                weakSelf.searchSuccess(responseObj);
                            }else{
                                [self sendErrorInfo:responseObj[@"data"][@"jdRespVo"][@"msg"]];
                            }
                        }else if ([self.bizType isEqualToString:kBizType_shixin]) {//失信
                            [TalkingData trackEvent:_successType label:TalkingDataLabel];
                            weakSelf.searchSuccess(responseObj);
                        }else if ([self.bizType isEqualToString:kBizType_bill]) {//信用卡。。。数据结构不同
                            if ([responseObj[@"data"][@"code"] isEqualToString:@"0000"]) {
                                //成功，但是返回的数据可能为空，VC中处理
                                [TalkingData trackEvent:_successType  label:TalkingDataLabel];
                                weakSelf.searchSuccess(responseObj);
                            }else { [self sendErrorInfo:nil]; }
                       }else {//其他数据
                            if ([responseObj[@"data"][@"code"] isEqualToString:@"0000"]) {
                                [TalkingData trackEvent:_successType label:TalkingDataLabel];
                                weakSelf.searchSuccess(responseObj);
                            }else{
                                [self sendErrorInfo:responseObj[@"data"][@"msg"]];
                            }
                        }
                    //无数据
                    }else {
                        if (weakSelf.searchFailure) {
                            weakSelf.searchFailure(nil);
                        }
                        [weakSelf removeTimer];
                    }
                    
                } failure:^(NSError *error) {
                    MYLog(@"第三步第获取数据失败-------%@",error);
                    if (weakSelf.searchFailure) {
                        weakSelf.searchFailure(nil);
                    }
                    [weakSelf removeTimer];
                    
                }];
                
            }else if(status.length&&([status isEqualToString:@"0001"])){//1---1---发送短信成功
                [weakSelf readySendSMSWithOther:0];
                [weakSelf removeTimer];
            }else if([status isEqualToString:@"0002"]){// 1---2----- 输入新密码
            }else if([status isEqualToString:@"0004"]){// 1---4----- 重置密码成功
            }else if([status isEqualToString:@"0009"]){// 1---9----- 写入短信成功 中间状态
            }else if([status isEqualToString:@"0010"]){// 1---10-----受理成功
                
            }else if([status isEqualToString:@"0011"]){// 1---11-----QQ独立密码
                [weakSelf readySendSMSWithOther:11];
                [weakSelf removeTimer];
            }else if ([status isEqualToString:@"0005"] || [status isEqualToString:@""]) { // 继续循环请求
                
            } else {
                
                if (weakSelf.searchFailure&&responseObj[@"data"][@"msg"]) {
                    NSError *error = [NSError errorWithDomain:responseObj[@"data"][@"msg"] code:0 userInfo:nil];
                    weakSelf.searchFailure(error);
                }else if (weakSelf.searchFailure&&responseObj[@"msg"]){
                    NSError *error = [NSError errorWithDomain:responseObj[@"msg"] code:0 userInfo:nil];
                    weakSelf.searchFailure(error);
                }else if (weakSelf.searchFailure){
                    NSError *error = [NSError errorWithDomain:@"网络请求失败" code:0 userInfo:nil];
                    weakSelf.searchFailure(error);
                }
                [weakSelf removeTimer];
                
            }
            
            
        }
        else{
            if (weakSelf.searchFailure&&responseObj[@"data"][@"msg"]) {
                NSError *error = [NSError errorWithDomain:responseObj[@"data"][@"msg"] code:0 userInfo:nil];
                weakSelf.searchFailure(error);
            }else if (weakSelf.searchFailure&&responseObj[@"msg"]){
                NSError *error = [NSError errorWithDomain:responseObj[@"msg"] code:0 userInfo:nil];
                weakSelf.searchFailure(error);
            }else if (weakSelf.searchFailure){
                NSError *error = [NSError errorWithDomain:@"网络请求失败" code:0 userInfo:nil];
                weakSelf.searchFailure(error);
            }
            [weakSelf removeTimer];
        }
        
    } failure:^(NSError *error) {
        if (weakSelf.searchFailure) {
            weakSelf.searchFailure(nil);
        }
    }];
}
-(void)sendErrorInfo:(NSString*)obj{
    NSError *error;
    if (obj){
        error = [NSError errorWithDomain:obj code:0 userInfo:nil];
    }else{
        error = [NSError errorWithDomain:@"数据请求失败" code:0 userInfo:nil];
    }
    self.searchFailure(error);
}


#pragma mrak -  首次网络
- (void)searchDataSuccesssuccess:(void (^)(id obj))success failure:(void (^)(NSError *error))failure   {
    self.searchSuccess = success;
//    self.searchFailure = failure;
    
    __weak typeof(self) weakSelf = self;
    if (!self.method) {
         self.method= urlJK_queryEducation;
    }
    if (!(_version&&_version.length)) {
        //默认是1.3.0 首次历史接口
        _version = VERSION_APP_1_3_0;
    }
    
    NSDictionary *dict = [self setDic];
    [self setBizType];
    
    MYLog(@"首次查询数据%@",dict);
    
    // 1.获取taken
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,self.method] timeoutInterval:self.timeOut params:dict success:^(id responseObj) {
        MYLog(@"URL:%@",[NSString stringWithFormat:@"%@%@",SERVE_URL,self.method]);
        MYLog(@"第一步拿到token-------%@",responseObj);
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            _token = responseObj[@"data"][@"token"];
            if (_token) {
                [weakSelf addTimer];
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
            }else{
                self.searchFailure(nil);
            }
        }
    } failure:^(NSError *error) {
        MYLog(@"第一步拿到token失败%@",error);
        if (weakSelf.searchFailure) {
            weakSelf.searchFailure(nil);
        }
        
    }];
    
    
}


#pragma mrak -  短信验证逻辑
- (void)readySendSMSWithOther:(NSInteger)index {
    __weak typeof(self) weakSelf = self;
    
    CommonSendMsgVC *ss = [[CommonSendMsgVC alloc]init];
    
    if ([_method isEqualToString:urlJK_queryCreditcardbill]) {//信用卡
        ss.sendMsgType = CommonSendMsgTypeNormal;
        ss.msg = @"邮箱绑定的手机";
        if (index==11) {// QQ邮箱独立密码
            ss.sendMsgType = CommonSendMsgTypeQQCredit;
            ss.msg = @"";
        }
    }
//    else if ([_method isEqualToString:urlJK_queryLinkedin]) {//领英
//        ss.sendMsgType = CommonSendMsgTypeNormal;
//        ss.msg = @"邮箱绑定的手机";
//    }else if ([_method isEqualToString:urlJK_queryJd]) {//京东 1
//        ss.sendMsgType = CommonSendMsgTypeNormal;
//        ss.msg = @"邮箱绑定的手机";
//    }
    else{
        ss.sendMsgType = CommonSendMsgTypeNormal;
        ss.msg = self.searchConditionModel.account;
    }
    
    ss.Sure=^(id obj){
        [self sendSMS:obj];
    };
    ss.Cancel = ^(id obj){
        if (weakSelf.searchFailure) {
            NSError *error = [NSError errorWithDomain:@"用户取消操作" code:0 userInfo:nil];
            weakSelf.searchFailure(error);
        }
    };
    [[UIViewController getCurrentVC] presentViewController:[[YJNavigationController alloc] initWithRootViewController:ss] animated:YES completion:nil];
}

- (void)sendSMS:(NSString *)smsCode {
    __weak typeof(self) weakSelf = self;
    
    
    NSDictionary *dic = @{ @"method":@"mobileSmsCheck",
                           @"mobile":[kUserManagerTool mobile],
                           @"userPwd":[kUserManagerTool userPwd],
                           @"username":self.searchConditionModel.account,
                           @"token":_token,
                           @"smsCode":smsCode
                           };
    MYLog(@"验证码DIC：%@",dic);
    // 2.获取状态
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_mobileSmsCheck] timeoutInterval:self.timeOut params:dic success:^(id responseObj) {
        MYLog(@"验证码报文：%@",responseObj);
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            if ([responseObj[@"data"][@"code"] isEqualToString:@"0000"]|[responseObj[@"data"][@"code"] isEqualToString:@"0009"]) {
                _token = responseObj[@"data"][@"token"];
                
                if (_token) {
                    [weakSelf addTimer];
                }else{
                    if (weakSelf.searchFailure) {
                        NSError *error = [NSError errorWithDomain:responseObj[@"data"][@"msg"] code:0 userInfo:nil];
                        weakSelf.searchFailure(error);
                    }
                }
            }else{
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
        MYLog(@"短信验证 失败-------");
        self.searchFailure(error);
    }];
    
    
}



#pragma mark - 
#pragma mark 设置属性
-(void)setBizType{
    
    if ([_method isEqualToString:urlJK_queryHouseFund]) {//公积金 1
        self.bizType  = kBizType_housefund;
        _successType = @"公积金查询成功";
    } else if ([_method isEqualToString:urlJK_querySocialsecurity]) {//社保 1
        _successType = @"社保查询成功";
        self.bizType  = kBizType_socialsecurity;
    } else if ([_method isEqualToString:urlJK_queryMobile]) {//运营商
        _successType = @"运营商查询成功";
        self.bizType  = kBizType_mobile;
    }else if ([_method isEqualToString:urlJK_queryJd]) {//京东 1
        _successType = @"京东查询成功";
        self.bizType  = kBizType_jd;
    }else if ([_method isEqualToString:urlJK_queryEducation]) {//学信 1
        _successType = @"学历学籍查询成功";
        self.bizType  = kBizType_education;
    }else if ([_method isEqualToString:urlJK_queryCredit]) {//央行
        self.bizType  = kBizType_credit;
        _successType = @"央行征信查询成功";
    }else if ([_method isEqualToString:urlJK_queryTaobao]) {//淘宝
        _successType = @"淘宝查询成功";
        self.bizType  = kBizType_taobao;
    }else if ([_method isEqualToString:urlJK_queryLinkedin]) {//领英
        _successType = @"领英查询成功";
        self.bizType  = kBizType_linkedin;
    }else if ([_method isEqualToString:urlJK_queryMaiMai]) {//脉脉
        _successType = @"脉脉查询成功";
        self.bizType  = kBizType_maimai;
    }else if ([_method isEqualToString:urlJK_queryShixin]) {//失信
        _successType = @"失信人被执行查询成功";
        self.bizType  = kBizType_shixin;
    }else if ([_method isEqualToString:urlJK_queryCreditcardbill]) {//信用卡
        _successType = @"信用卡账单查询成功";
        self.bizType  = kBizType_bill;
    }
    
    
    
}
#pragma mark 设置字典
-(NSDictionary*)setDic{
    NSDictionary *dict;
    switch (self.searchType) {
        case SearchItemTypeHousingFund: // 公积金
        {
            /*
             参数：realName
             以下地区必填：
             广州（用身份证号查询时必填）
             洛阳（只需要身份证号和真实姓名）
             西安
             */
            dict = @{@"method":self.method,
                   @"mobile":[kUserManagerTool mobile],
                   @"userPwd":[kUserManagerTool userPwd],
                   @"username":self.searchConditionModel.account,
                   @"password":self.searchConditionModel.passWord,
                   @"area":self.searchConditionModel.cityCode,
                   @"realName" : self.searchConditionModel.servicePass,
                   @"otherInfo" : self.searchConditionModel.otherInfo,
                   @"appVersion": VERSION_APP_1_4_2};
            break;
        }
        case SearchItemTypeSocialSecurity: // 社保
        {
            dict=@{@"method":self.method,
                   @"mobile":[kUserManagerTool mobile],
                   @"userPwd":[kUserManagerTool userPwd],
                   @"username":self.searchConditionModel.account,
                   @"password":self.searchConditionModel.passWord,
                   @"area":self.searchConditionModel.cityCode,
                   @"realName" : self.searchConditionModel.servicePass,
                   @"otherInfo" : self.searchConditionModel.otherInfo};
            
            break;
        }
        case SearchItemTypeCentralBank: // 央行征信
        {
            dict = @{ @"method":@"queryCredit",
                    @"mobile":[kUserManagerTool mobile],
                    @"userPwd":[kUserManagerTool userPwd],
                    @"username":self.searchConditionModel.account,//需要填写真实帐号，此处为造数据
                    @"password":self.searchConditionModel.passWord,//央行征信账户密码
                    @"middleAuthCode":self.searchConditionModel.servicePass//央行征信者身份验证码
                                    };
            break;
        }
        case SearchItemTypeEducation:// 学历学籍
        {
            dict=@{@"method":self.method,
                   @"mobile":[kUserManagerTool mobile],
                   @"userPwd":[kUserManagerTool userPwd],
                   @"username":self.searchConditionModel.account,
                   @"password":self.searchConditionModel.passWord};
            
            break;
        }
        case SearchItemTypeMaimai: case SearchItemTypeLinkedin://   领英 脉脉
        {
            dict=@{@"method":self.method,
                   @"mobile":[kUserManagerTool mobile],
                   @"userPwd":[kUserManagerTool userPwd],
                   @"username":self.searchConditionModel.account,
                   @"password":self.searchConditionModel.passWord,
                   @"appVersion":_version};
            
            break;
        }
        case SearchItemTypeE_Commerce: // 电商数据
        {
            dict = @{@"method":urlJK_queryJd,
                     @"mobile":kUserManagerTool.mobile,
                     @"userPwd":kUserManagerTool.userPwd,
                     @"username":self.searchConditionModel.account,
                     @"password":self.searchConditionModel.passWord
                     };
            break;
        }
        case SearchItemTypeTaoBao: // 淘宝
        {
            
            break;
        }
        case SearchItemTypeOperators: // 运营商
        {
            
            break;
        }
        case SearchItemTypeLostCredit: // 失信
        {
            if (!self.searchConditionModel.account) self.searchConditionModel.account = @"";
            if (! self.searchConditionModel.passWord) self.searchConditionModel.passWord = @"";
            dict = @{@"method":urlJK_queryShixin,
                     @"mobile":kUserManagerTool.mobile,
                     @"userPwd":kUserManagerTool.userPwd,
                     @"name":self.searchConditionModel.account,
                     @"identityNo":self.searchConditionModel.passWord,
                     @"appVersion":_version};
            break;
        }
        case SearchItemTypeCreditCardBill: // 信用卡
        {
            dict = @{@"method":urlJK_queryCreditcardbill,
                     @"mobile":kUserManagerTool.mobile,
                     @"userPwd":kUserManagerTool.userPwd,
                     
                     @"username":self.searchConditionModel.account,
                     @"password":self.searchConditionModel.passWord,
                     
                     @"billType":@"email",
                     @"bankCode":@"ALL",
                     @"appVersion":_version,
                     };
            break;
        }
        default:
            break;
    }
    
    return dict;
}

/**
 
 
 switch (self.searchType) {
 case SearchItemTypeHousingFund: // 公积金
 {
 break;
 }
 case SearchItemTypeSocialSecurity: // 社保
 {
 
 break;
 }
 case SearchItemTypeOperators: // 运营商
 {
 
 break;
 }
 case SearchItemTypeCentralBank: // 央行征信
 {
 
 break;
 }
 case SearchItemTypeE_Commerce: // 电商数据
 {
 break;
 }
 case SearchItemTypeEducation: // 学历学籍
 {
 
 break;
 }
 case SearchItemTypeMaimai: // 脉脉
 {
 
 return;
 }
 case SearchItemTypeLinkedin: // 领英
 {
 
 return;
 }
 case SearchItemTypeTaoBao: // 淘宝
 {
 
 return;
 }
 
 default:
 break;
 }
 
 */
@end
