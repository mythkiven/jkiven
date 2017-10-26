//
//  12.m
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/2/13.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXSDK.h"
#import "LMZXLog.h"

#import "UIImage+LMZXTint.h"

#import "LMZXTBProtocol.h"

#import "LMZXSDKNavigationController.h"


#import "LMZXMobileCarrieSearchVC.h"
#import "LMZXJDSearchVC.h"
#import "LMZXTaobaoSearchVC.h"
#import "LMZXHouseFundSocialSecuritySearchVC.h"
#import "LMZXEducationSearchVC.h"
#import "LMZXCityListViewController.h"

#import "LMZXWebBusinessVC.h"


#import "LMZXAutoinsuranceVC.h"

#import "LMZXEBankBillVC.h"

#import "LMZXCentralBankVC.h"


#import "LMZXCreditBillGuideVC.h"


#import "LMZXAnalysisWebModel.h"
#import "LMZXWebNetWork.h"

// 三期
#import "LMZXLinkedinMaimaiVC.h"
#import "LMZXLostCreditVC.h"
#import "LMZXCtripVC.h"
#import "LMZXDiDiTaxiVC.h"


// 优化:
#import "LMZXWebLoadingType.h"

#import "LMZXQueryInfoModel.h"
#import "LMZXLoadingReportBaseVC.h"
@interface LMZXSDK ()

//@property (strong,nonatomic) LMZXSDKNavigationController *lmNavVC;

/********************** SDK 以下 暂不对外开放 *******************************/
/**
 *  返回按钮图片
 */
@property (nonatomic,strong) UIImage *lmzxBackImage;

/**
 *  返回按钮文字
 */
@property (nonatomic,strong) NSString *lmzxBackTxt;
/**
 *  勾选框- normal(如果不设置,使用默认 img)
 */
@property (nonatomic,strong) UIImage *lmzxProtocolImgNor;
/**
 *  勾选框- selected(如果不设置,使用默认 img)
 */
@property (nonatomic,strong) UIImage *lmzxProtocolImgSec;
/**
 *  导航器自定义样式可直接修改.
 */
@property (nonatomic,strong,readonly) UINavigationController *lmzxNavigationController;




// 外部只读属性
@property (assign,nonatomic,readwrite) LMZXSDKFunction lmzxfunction;


@end


static LMZXSDK *_instance;

@implementation LMZXSDK
{
    // 默认20 1 H5 0原生
    __block NSInteger _isLoginWeb;
    LMZXWebLoadingType *_lmzxWebLoginInfo;
    
}

-(void)dealloc { 
    [NSURLProtocol unregisterClass:[LMZXTBProtocol class]];
    [[NSNotificationCenter defaultCenter] removeObserver:LMZX_BeginNetWithSignAndTimeStamp];

}

#pragma mark - 属性
// get
-(LMZXSDKFunction)lmzxFunction{
//    if (_lmzxfunction) {
        return _lmzxfunction;
//    }
//    return 666;
}
// get
-(NSString*)LMZXSDKVersion{
    return @"1.2.1";
}

#pragma mark -
#pragma mark - 初始化
+(LMZXSDK*)shared{
    if (_instance == nil) {
        _instance = [[LMZXSDK alloc] init];
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


// 注册 SDK
+(void)registerLMZXSDK{
[NSURLProtocol registerClass:[LMZXTBProtocol class]];
}

// 初始化 SDK
+(LMZXSDK *)lmzxSDKWithApikey:(NSString *)lmApikey
                              uid:(NSString *)lmUid
                      callBackUrl:(NSString *)callBackUrl{

    
    
    return [[self alloc] initWithApikey:lmApikey uid:lmUid callBackUrl:callBackUrl];
}
// 注册
-(LMZXSDK *)initWithApikey:(NSString *)lmApikey uid:(NSString *)lmUid callBackUrl:(NSString *)callBackUrl{
  
     //顺序不能反了,否则下边获取不到宏定义的内容
//#warning  TEST
//#warning  TEST
//#warning  TEST 生产版本要改的
//    if (!_lmzxTestURL) {
//        _lmzxTestURL = @"https://api.limuzhengxin.com";
//    }
//
    //正确的打开方式
    _lmzxTestURL = @"https://api.limuzhengxin.com";
    
    _lmzxUid = lmUid;
    _lmzxApiKey = lmApikey;
    _lmzxCallBackUrl = callBackUrl;
    _lmzxQuitOnSuccess = YES;
    _lmzxQuitOnFail = NO;
    _lmzxProtocolUrl = LMZXSDK_GetProtocol_URL;
    _lmzxProtocolTitle = @"《授权协议》";
    _lmzxSubmitBtnTitleColor = [UIColor whiteColor];
    _isLoginWeb = 20;
    // 默认是0 会产生歧义公积金, 修改默认为-1
    _lmzxfunction = -1;
    //
    _lmzxWebLoginInfo = [[LMZXWebLoadingType alloc]init];
    [_lmzxWebLoginInfo removeLastWebLoginInfo];
    [self setSDKTheme];
    // 预加载网络信息
    [self getWebInfo];
    return self;
    
}

#pragma mark 启动网络
- (void)sendReqWithSign:(NSString *)sign{
    // 发送通知,启动网络
    [[NSNotificationCenter defaultCenter] postNotificationName:LMZX_BeginNetWithSignAndTimeStamp
                                                        object:nil
                                                      userInfo:@{@"sign":sign}];
    
}


#pragma mark 主题颜色
-(void)setSDKTheme {
    
    // 默认导航条颜色
    if (!self.lmzxThemeColor) {
        self.lmzxThemeColor = LM_RGB(48, 113, 242);
    }
    // 默认标题颜色
    if (!self.lmzxTitleColor) {
        self.lmzxTitleColor = [UIColor whiteColor];
    }
    // 默认协议颜色
    if (!self.lmzxProtocolTextColor) {
        self.lmzxProtocolTextColor = LM_RGB(48, 113, 242) ;
    }
    // 默认提交按钮颜色
    if (!self.lmzxSubmitBtnColor) {
        self.lmzxSubmitBtnColor = LM_RGB(57, 179, 27);
    }
    // 默认页面背景色
    if (!self.lmzxPageBackgroundColor) {
        self.lmzxPageBackgroundColor = LM_RGB(245, 245, 245);
    }
    // 默认提交按钮文字颜色
    if (!self.lmzxSubmitBtnTitleColor) {
        self.lmzxSubmitBtnTitleColor = [UIColor whiteColor];
    }
    // 默认状态栏
    if (!self.lmzxStatusBarStyle) {
        self.lmzxStatusBarStyle = LMZXStatusBarStyleLightContent;
    }
    
    // 返回文字:
    [LMZXSDK shared].lmzxBackTxt = @"返回";
    // 返回图片
    [LMZXSDK shared].lmzxBackImage = [UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_back"];
    
    if (self.lmzxTitleColor) {
        [LMZXSDK shared].lmzxBackImage = [[LMZXSDK shared].lmzxBackImage imageWithTintColor:self.lmzxTitleColor];
    }
    
    
}



#pragma mark - 启动功能
/**
 启动 SDK 功能
 
 @param function 启动的某个功能
 @param lmzxAuthBlock 加签，授权
 */
-(void)startFunction:(LMZXSDKFunction)function authCallBack:(LMZXAuthBlock)lmzxAuthBlock{
    
    if (!_lmzxUid || !_lmzxUid.length) {
        LMLog(@"立木征信 SDK: uid 不能为空");
        return;
    }
    if (!_lmzxApiKey || !_lmzxApiKey.length) {
        LMLog(@"立木征信 SDK: ApiKey 不能为空");
        return;
    }
    if (!_lmzxCallBackUrl || !_lmzxCallBackUrl.length) {
        LMLog(@"立木征信 SDK: CallBackUrl 不能为空");
        return;
    }
    
    
    [LMZXSDK shared].lmzxAuthBlock = ^(NSString *auth){
        lmzxAuthBlock(auth);
    };

     self.lmzxfunction = function;
    
    

    LMZXBaseViewController *baseVc;
    // 调用模块
    switch (function) {
            
            // 启动运营商
        case LMZXSDKFunctionMobileCarrie:{
            
            baseVc = [[LMZXMobileCarrieSearchVC alloc] init];
            baseVc.searchItemType = LMZXSearchItemTypeOperators;
            
            break;
        }
            //启动淘宝
        case  LMZXSDKFunctionTaoBao:{
            baseVc = [[LMZXWebBusinessVC alloc] init];
        
            // 类型
            baseVc.searchItemType  = LMZXSearchItemTypeTaoBao;
            
            
            break;
        }
            //启动公积金
        case LMZXSDKFunctionHousingFund:{
            
            baseVc = [[LMZXHouseFundSocialSecuritySearchVC alloc] init];

            baseVc.searchItemType = LMZXSearchItemTypeHousingFund;
            
            
            
            break;
        }
            // 京东
        case LMZXSDKFunctionJD:{
            
            if (_isLoginWeb >=20&&_isLoginWeb <=23) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self getInfoFunction:function complete:lmzxAuthBlock];
                });
                break;
            }// H5
            if(_isLoginWeb == 1) { // H5
                baseVc = [[LMZXWebBusinessVC alloc] init];
                baseVc.searchItemType  = LMZXSearchItemTypeE_Commerce;
                break;
            }else if(_isLoginWeb == 0){ // 原生
                baseVc = [[LMZXJDSearchVC alloc] init];
                baseVc.searchItemType = LMZXSearchItemTypeE_Commerce;
                break;
            }else{
                _isLoginWeb = 20;// 复位
                baseVc = [[LMZXJDSearchVC alloc] init];
                baseVc.searchItemType = LMZXSearchItemTypeE_Commerce;
                break;
            }
            
            break;
        }

            // 学信
        case LMZXSDKFunctionEducation:{
            
            baseVc = [[LMZXEducationSearchVC alloc] init];
            baseVc.searchItemType = LMZXSearchItemTypeEducation;
            
            
            break;
        }
            
        case LMZXSDKFunctionSocialSecurity:{ // 社保
            
            baseVc = [[LMZXHouseFundSocialSecuritySearchVC alloc] init];
            baseVc.searchItemType = LMZXSearchItemTypeSocialSecurity;
            
            
            
            break;
        }
            // 车险 + 已加上
        case LMZXSDKFunctionAutoinsurance:{
            
            baseVc = [[LMZXAutoinsuranceVC alloc] init];
            baseVc.searchItemType = LMZXSearchItemTypeCarSafe;
            
            
            
            break;
        }
            // 网银 + 已加上
        case LMZXSDKFunctionEBankBill:{
            
            baseVc = [[LMZXEBankBillVC alloc] init];
            baseVc.searchItemType = LMZXSearchItemTypeNetBankBill;
            
            
            
            break;
        }
            //央行征信 +
        case LMZXSDKFunctionCentralBank:{
            
            baseVc = [[LMZXCentralBankVC alloc] init];
            baseVc.searchItemType = LMZXSearchItemTypeCentralBank;
            
            
            
            break;
        }
            // 信用卡账单
        case LMZXSDKFunctionCreditCardBill:{
            baseVc = [[LMZXCreditBillGuideVC alloc] init];
            baseVc.searchItemType = LMZXSearchItemTypeCreditCardBill;
            
            break;
        }
//            // 失信
//        case LMZXSDKFunctionDishonest:{
//            baseVc = [[LMZXLostCreditVC alloc] init];
//            baseVc.searchItemType SearchItemTypeLinkedinit;
//            
//            break;
//        }
            // 脉脉
        case LMZXSDKFunctionMaimai:{
            
            if (_isLoginWeb >=20&&_isLoginWeb <=23) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self getInfoFunction:function complete:lmzxAuthBlock];
                });
                break;
            }// H5
            if(_isLoginWeb == 1) { // H5
                baseVc = [[LMZXWebBusinessVC alloc] init];
                baseVc.searchItemType = LMZXSearchItemTypeMaimai;
                break;
            }else if(_isLoginWeb == 0){ // 原生
                baseVc = [[ LMZXLinkedinMaimaiVC alloc] init];
                baseVc.searchItemType = LMZXSearchItemTypeMaimai;
                break;
            }else{
                _isLoginWeb = 20;// 复位
                baseVc = [[ LMZXLinkedinMaimaiVC alloc] init];
                baseVc.searchItemType = LMZXSearchItemTypeMaimai;
                break;
            }
            break;
        }
            // 领英
        case LMZXSDKFunctionLinkedin:{
            if (_isLoginWeb >=20&&_isLoginWeb <=23) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self getInfoFunction:function complete:lmzxAuthBlock];
                });
                break;
            }// H5
            if(_isLoginWeb == 1) {
                baseVc = [[LMZXWebBusinessVC alloc] init];
                baseVc.searchItemType = LMZXSearchItemTypeLinkedin;
                break;
            }else if(_isLoginWeb == 0){ // 原生
                baseVc = [[LMZXLinkedinMaimaiVC alloc] init];
                baseVc.searchItemType  = LMZXSearchItemTypeLinkedin;
                break;
            }else{
                _isLoginWeb = 20;// 复位
                baseVc = [[LMZXLinkedinMaimaiVC alloc] init];
                baseVc.searchItemType  = LMZXSearchItemTypeLinkedin;
                break;
            }
                break;
        }
              // 携程查询
        case LMZXSDKFunctionCtrip:{
            if (_isLoginWeb >=20&&_isLoginWeb <=23) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self getInfoFunction:function complete:lmzxAuthBlock];
                });
                break;
            }// H5
            if(_isLoginWeb == 1) {
                baseVc = [[LMZXWebBusinessVC alloc] init];
                baseVc.searchItemType  = LMZXSearchItemTypeCtrip;
                break;
            }else if(_isLoginWeb == 0){ // 原生
                baseVc = [[LMZXCtripVC alloc] init];
                baseVc.searchItemType  = LMZXSearchItemTypeCtrip;
                break;
            }else{
                _isLoginWeb = 20;// 复位
                baseVc = [[LMZXCtripVC alloc] init];
                baseVc.searchItemType  = LMZXSearchItemTypeCtrip;
                break;
            }
            break;
        }
            // didi
        case LMZXSDKFunctionDiDiTaxi:{

            if (_isLoginWeb >=20&&_isLoginWeb <=23) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self getInfoFunction:function complete:lmzxAuthBlock];
                });
                break;
            }// H5
            if(_isLoginWeb == 1) {
                baseVc = [[LMZXWebBusinessVC alloc] init];
                baseVc.searchItemType = LMZXSearchItemTypeDiDiTaxi;
                break;
            }else if(_isLoginWeb == 0){ // 原生
                baseVc = [[LMZXDiDiTaxiVC alloc] init];
                baseVc.searchItemType = LMZXSearchItemTypeDiDiTaxi;
                break;
            }else{
                _isLoginWeb = 20;// 复位
                baseVc = [[LMZXDiDiTaxiVC alloc] init];
                baseVc.searchItemType = LMZXSearchItemTypeDiDiTaxi;
                break;
            }
            break;
        }
            
        default:
            break;
    }
    
    // 返回按钮
    baseVc.lmBackImg = self.lmzxBackImage;
    baseVc.lmBackTxt = self.lmzxBackTxt;

    LMZXSDKNavigationController *_lmNavVC = [[LMZXSDKNavigationController alloc] initWithRootViewController:baseVc];

    
    if (function == LMZXSDKFunctionJD || function ==LMZXSDKFunctionLinkedin|| function ==LMZXSDKFunctionMaimai|| function ==LMZXSDKFunctionDiDiTaxi|| function ==LMZXSDKFunctionCtrip) {
        if (_isLoginWeb  == 1 | _isLoginWeb  == 0) {
            
            [[self getPresentedViewController] presentViewController:_lmNavVC animated:YES completion:NULL];
//            [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:_lmNavVC animated:YES completion:NULL];
            _isLoginWeb = 20;
         }
    } else {
        [[self getPresentedViewController] presentViewController:_lmNavVC animated:YES completion:NULL];
//        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:_lmNavVC animated:YES completion:NULL];
        
    }
    

}

-(void)startFunction:(LMZXSDKFunction)function preParameters:(NSDictionary*)paramDic authCallBack:(LMZXAuthBlock)lmzxAuthBlock{
    if (!_lmzxUid || !_lmzxUid.length) {
        LMLog(@"立木征信 SDK: uid 不能为空");
        return;
    }
    if (!_lmzxApiKey || !_lmzxApiKey.length) {
        LMLog(@"立木征信 SDK: ApiKey 不能为空");
        return;
    }
    if (!_lmzxCallBackUrl || !_lmzxCallBackUrl.length) {
        LMLog(@"立木征信 SDK: CallBackUrl 不能为空");
        return;
    }
    
    if (paramDic) {
        if ([paramDic isKindOfClass:[NSDictionary class]]) {
            if (paramDic.allKeys.count == 7) {
                
            } else {
                LMLog(@"立木征信 SDK: paramDic 传入参数数量有误");
                return;
            }
        }else{
            LMLog(@"立木征信 SDK: paramDic 格式不正确");
            return;
        }
    }else{
        LMLog(@"立木征信 SDK: paramDic 不能为空");
        return;
    }
    
    
    [LMZXSDK shared].lmzxAuthBlock = ^(NSString *auth){
        lmzxAuthBlock(auth);
    };
    
    self.lmzxfunction = function;
    
    /**
     修改之处: 本方法+动画页面增加判断: 是否为 modal 过去的, 是则添加返回按钮.等
     */
    
    // 参数模型
    LMZXQueryInfoModel *_lmQueryInfoModel = [[LMZXQueryInfoModel alloc] init];
    // 动画页面
    LMZXLoadingReportBaseVC *_lmloadingVc = [[LMZXLoadingReportBaseVC alloc] init];
    
    
    // 调用模块
    if(function == LMZXSDKFunctionMobileCarrie ){
        
        _lmQueryInfoModel.username = paramDic[@"mobile"]?paramDic[@"mobile"]:@"";
        _lmQueryInfoModel.password = paramDic[@"password"]?paramDic[@"password"]:@"";
        _lmQueryInfoModel.contentType = paramDic[@"contentType"]?paramDic[@"contentType"]:@"all";
        _lmQueryInfoModel.otherInfo = paramDic[@"otherInfo"]?paramDic[@"otherInfo"]:@"all";
        _lmQueryInfoModel.identityNo = paramDic[@"identityCardNo"]?paramDic[@"identityCardNo"]:@"all";
        _lmQueryInfoModel.identityName = paramDic[@"identityName"]?paramDic[@"identityName"]:@"all";
        _lmQueryInfoModel.checkTypeForSMS = [paramDic[@"mobileArea"] isEqualToString:@"吉林电信"]?LMZXCommonSendMsgTypeJLDX:LMZXCommonSendMsgTypePhone;
        
        if (!_lmQueryInfoModel.username.length) {
            LMLog(@"立木征信 SDK: 手机号不能为空");
            return;
        }
        
        _lmloadingVc.lmQueryInfoModel = _lmQueryInfoModel;
        _lmloadingVc.searchType = LMZXSearchItemTypeOperators;
    }else{
        [self startFunction: function  authCallBack: lmzxAuthBlock];
    }
    
    
    LMZXSDKNavigationController *_lmNavVC = [[LMZXSDKNavigationController alloc] initWithRootViewController:_lmloadingVc];
    [[self getPresentedViewController] presentViewController:_lmNavVC animated:YES completion:NULL];
    
}

/**
 启动 SDK 功能
 
 @param function 启动的某个功能
 @param lmzxAuthBlock 加签，授权
 @param lmzxResultBlock 查询结果回调
 */
-(void)startFunction:(LMZXSDKFunction)function authCallBack:(LMZXAuthBlock)lmzxAuthBlock resultCallBack:(LMZXResultBlock)lmzxResultBlock {
    self.lmzxResultBlock = lmzxResultBlock;
    [self startFunction:function authCallBack:lmzxAuthBlock];
}





-(void)getInfoFunction:(LMZXSDKFunction)function complete:(LMZXAuthBlock)lmzxAuthBlock{
 
//    _isLoginWeb =1;
//    [self startFunction:function authCallBack:lmzxAuthBlock];
//    return;
    
    __block typeof(self) sself = self;
    NSString *path,*typp;
    if (function == LMZXSDKFunctionJD) {//JD
        path = @"?bizType=JD";typp = _lmzxWebLoginInfo.jd;
    } else if (function == LMZXSDKFunctionLinkedin) {//领英
        path = @"?bizType=linkedin";typp = _lmzxWebLoginInfo.linkedin;
    } else if (function == LMZXSDKFunctionDiDiTaxi) {//滴滴
        path = @"?bizType=diditaxi";typp = _lmzxWebLoginInfo.diditaxi;
    }else if (function == LMZXSDKFunctionMaimai) {//脉脉
        path = @"?bizType=maimai";typp = _lmzxWebLoginInfo.maimai;
    }else if (function == LMZXSDKFunctionCtrip) {//携程
        path = @"?bizType=ctrip";typp = _lmzxWebLoginInfo.ctrip;
    }
    
    
    /// 加载现有数据
    
    LMZXWebLoginModel *modelTypp = [_lmzxWebLoginInfo getLastWebLoginInfo:typp];
    if (modelTypp && modelTypp.items) {
        LMZXWebLoginItemsModel *modelItem = modelTypp.items;
        if ([modelItem.isWebLogin isEqualToString:@"1"]) {
            _isLoginWeb = 1;
            [sself startFunction:function authCallBack:lmzxAuthBlock];
            return;
        }else if ([modelItem.isWebLogin isEqualToString:@"0"]) {
            _isLoginWeb = 0;
            [sself startFunction:function authCallBack:lmzxAuthBlock];
            return;
        }
    }
    
    
    [LMZXWebNetWork get:[LMZXSDK_webConfig_URL stringByAppendingString:path]   timeoutInterval:2.0 success:^(id obj) {
       
            if ([obj isKindOfClass:[NSArray class]] ) {
            NSArray *arr = (NSArray*)obj;
            if (arr.count){
                NSDictionary *dic = arr.firstObject;
                NSDictionary* ldic=  dic[@"items"];
                if (ldic.allValues) {
                    if ([ldic[@"isWebLogin"] isEqualToString:@"1"]) {
                       _isLoginWeb = 1;
                        [sself startFunction:function authCallBack:lmzxAuthBlock];
                    }else if ([ldic[@"isWebLogin"] isEqualToString:@"0"]) {
                        _isLoginWeb = 0;
                        [sself startFunction:function authCallBack:lmzxAuthBlock];
                    }else{
                        _isLoginWeb ++;
                        [sself startFunction:function authCallBack:lmzxAuthBlock];
                    }
                }else{
                    _isLoginWeb ++;
                    [sself startFunction:function authCallBack:lmzxAuthBlock];
                }
            }else{
                _isLoginWeb ++;
                [sself startFunction:function authCallBack:lmzxAuthBlock];
            }
        }else{
            _isLoginWeb ++;
            [sself startFunction:function authCallBack:lmzxAuthBlock];
        }
    } failure:^(NSError *error) {
        _isLoginWeb ++;
        [sself startFunction:function authCallBack:lmzxAuthBlock];
    }];

}

-(void)getWebInfo{
    
    [LMZXWebNetWork get:LMZXSDK_webConfig_URL timeoutInterval:1.0 success:^(id obj) {
        
        BOOL obj1 =[obj isKindOfClass:[NSNull class]];
        BOOL obj2 =[obj isKindOfClass:[NSString class]];
        
        if (obj1 | obj2) {
        }else if ([obj isKindOfClass:[NSArray class]] ){
            [_lmzxWebLoginInfo saveLastWebLoginInfo:obj];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

/**
 开启日志
 */
- (void)unlockLog; {
    [[LMZXLog defaultLog] unlockLog];
}



@end
