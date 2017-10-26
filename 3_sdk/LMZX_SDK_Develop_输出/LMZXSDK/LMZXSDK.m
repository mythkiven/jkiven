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
    NSString *apikey;
    // 11 不行 22 行
    __block NSInteger _isLoginWeb;
}

-(void)dealloc {
    [NSURLProtocol unregisterClass:[LMZXTBProtocol class]];
    [[NSNotificationCenter defaultCenter] removeObserver:LMZX_BeginNetWithSignAndTimeStamp];

}

#pragma mark - 属性
// get
-(LMZXSDKFunction)lmzxFunction{
    if (_lmzxfunction) {
        return _lmzxfunction;
    }
    return 666;
}
// get
-(NSString*)LMZXSDKVersion{
    return @"1.1.0";
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
    
    
    // 顺序不能反了,否则下边获取不到宏定义的内容
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
    
    [self setSDKTheme];
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
            baseVc.searchItemType = SearchItemTypeOperators;
            
            break;
        }
            //启动淘宝
        case  LMZXSDKFunctionTaoBao:{
            
            baseVc = [[LMZXWebBusinessVC alloc] init];
        
            // 类型
            baseVc.webBusinesstype  = LMZXWebBusinessTypeTaobao;
            
            
            break;
        }
            //启动公积金
        case LMZXSDKFunctionHousingFund:{
            
            baseVc = [[LMZXHouseFundSocialSecuritySearchVC alloc] init];

            baseVc.searchItemType = SearchItemTypeHousingFund;
            
            
            
            break;
        }
            // 京东
        case LMZXSDKFunctionJD:{
            
            if (_isLoginWeb ==20) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self getInfoFunction:function complete:lmzxAuthBlock];
                });
                break;
            }
            
            // 原生
            if(_isLoginWeb == 1) { // H5
                
                // JD H5
                baseVc = [[LMZXWebBusinessVC alloc] init];
                // 类型
                baseVc.webBusinesstype  = LMZXWebBusinessTypeJD;
                
                break;
            }else{ // 原生
                baseVc = [[LMZXJDSearchVC alloc] init];

                baseVc.searchItemType = SearchItemTypeE_Commerce;
                
                
                break;
            }
            
            break;
        }

            // 学信
        case LMZXSDKFunctionEducation:{
            
            baseVc = [[LMZXEducationSearchVC alloc] init];
            baseVc.searchItemType = SearchItemTypeEducation;
            
            
            break;
        }
            
        case LMZXSDKFunctionSocialSecurity:{ // 社保
            
            baseVc = [[LMZXHouseFundSocialSecuritySearchVC alloc] init];
            baseVc.searchItemType = SearchItemTypeSocialSecurity;
            
            
            
            break;
        }
            // 车险 + 已加上
        case LMZXSDKFunctionAutoinsurance:{
            
            baseVc = [[LMZXAutoinsuranceVC alloc] init];
            baseVc.searchItemType = SearchItemTypeCarSafe;
            
            
            
            break;
        }
            // 网银 + 已加上
        case LMZXSDKFunctionEBankBill:{
            
            baseVc = [[LMZXEBankBillVC alloc] init];
            baseVc.searchItemType = SearchItemTypeNetBankBill;
            
            
            
            break;
        }
            //央行征信 +
        case LMZXSDKFunctionCentralBank:{
            
            baseVc = [[LMZXCentralBankVC alloc] init];
            baseVc.searchItemType = SearchItemTypeCentralBank;
            
            
            
            break;
        }
            // 信用卡账单
        case LMZXSDKFunctionCreditCardBill:{
            baseVc = [[LMZXCreditBillGuideVC alloc] init];
            baseVc.searchItemType = SearchItemTypeCreditCardBill;
            
            break;
        }
        default:
            break;
    }
    
    // 返回按钮
    baseVc.lmBackImg = self.lmzxBackImage;
    baseVc.lmBackTxt = self.lmzxBackTxt;

    LMZXSDKNavigationController *_lmNavVC = [[LMZXSDKNavigationController alloc] initWithRootViewController:baseVc];

    
    if (function == LMZXSDKFunctionJD) {
        if (_isLoginWeb !=20) {
//            [self setSDK];
            [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:_lmNavVC animated:YES completion:NULL];
            _isLoginWeb =20;
         }
    } else {
//        [self setSDK];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:_lmNavVC animated:YES completion:NULL];
        
    }
    

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
 
    __block typeof(self) sself = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
        [LMZXWebNetWork get:[LMZXSDK_webConfig_URL stringByAppendingString:@"?bizType=JD"]   timeoutInterval:2.0 success:^(id obj) {
            BOOL obj1 =[obj isKindOfClass:[NSNull class]];
            BOOL obj2 =[obj isKindOfClass:[NSString class]];
            
            if (obj1 | obj2) {
               _isLoginWeb ++;
                 [sself startFunction:function authCallBack:lmzxAuthBlock];
            }else if ([obj isKindOfClass:[NSArray class]] ) {
                NSArray *arr = (NSArray*)obj;
                if (arr.count){
                    NSDictionary *dic = arr.firstObject;
                    NSDictionary* ldic=  dic[@"items"];
                    if (ldic.allValues) {
                        if ([ldic[@"isWebLogin"] isEqualToString:@"1"]) {
                           _isLoginWeb = 1;
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
//    });
}



/**
 开启日志
 */
- (void)unlockLog; {
    [[LMZXLog defaultLog] unlockLog];
}



@end
