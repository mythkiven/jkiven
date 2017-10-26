//
//  AppDelegate.h
//  LMZX_SDK_Demo
//

#import <UIKit/UIKit.h>


//#warning  TEST
//#ifdef DEBUG
//#define LMTLog(...) // NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
//#else
//#define LMTLog(...)
//#endif
//#warning  TEST


// 内部统一接口

#import "LMZXSDK.h"
#import "LMZXLog.h"

#import "LMZXHomeSearchType.h"

#import "LMZXBaseSearchDataTool.h"

#import "LMZXQueryInfoModel.h"

#import "LMZXToast+UIView.h"

#import "UIImage+LMZXTint.h"
//// 测试环境: 需要验证签名
//#define LMZXSDK_url @"https://t.limuzhengxin.cn:3443/api/gateway"

#define LMZXSDK_url ([[LMZXSDK shared].lmzxTestURL stringByAppendingPathComponent:@"api/gateway"])

// 获取 web 接口配置信息
//#define LMZXSDK_webConfig_URL @"http://192.168.101.29:8001/api/config/v1/login"
#define LMZXSDK_webConfig_URL ([[LMZXSDK shared].lmzxTestURL stringByAppendingPathComponent:@"api/config/v1/login"])

// 获取 各种列表数据
//#define LMZXSDK_ListConfig_URL @"https://t.limuzhengxin.cn:3443/api/config/v1/category"
#define LMZXSDK_ListConfig_URL ([[LMZXSDK shared].lmzxTestURL stringByAppendingPathComponent:@"api/config/v1/category"])


// 获取 code 转码
//#define LMZXSDK_NetCodeDecode_URL @"http://192.168.101.29:8001/api/config/v1/errorCodeMapping"
#define LMZXSDK_NetCodeDecode_URL ([[LMZXSDK shared].lmzxTestURL stringByAppendingPathComponent:@"api/config/v1/errorCodeMapping"])

// 协议统一地址
//#define LMZXSDK_GetProtocol_URL  @"http://192.168.101.29:8001/static/h5/agreement.html"
#define LMZXSDK_GetProtocol_URL  ([[LMZXSDK shared].lmzxTestURL stringByAppendingPathComponent:@"static/h5/agreement.html"])


//新
//#define LMZXSDK_url @"http://192.168.101.29:8001/api/gateway"
// 旧
//#define LMZXSDK_url @"http://192.168.101.28:8001/api/gateway"



//// 徐锦 测试

//#define LMZXSDK_url @"http://192.168.117.38:8185/api/gateway"





// 直接从 SDK 获取.
//#define ApiKey      @"2119370938180771"
//#define Api_Secret  @"eobszafxfmvmNK2SetxChP93A23V2hHZ"




#define LMZX_Api_Version_1_0_0  @"1.0.0"

#define LMZX_Api_Version_1_2_0  @"1.2.0"
// 央行征信验证码
#define SERVE_URL_YZM @"https://www.limuzhengxin.com/credit/getCreditPwd" //生常用于忘记密码





// 通知
// 启动网络请求的通知
#define LMZX_BeginNetWithSignAndTimeStamp  @"LMZX_BeginNetWithSignAndTimeStamp"






/////////////////////// tag  ///////////////////////////////////////////

// tag 确定唯一的textfiled
#define LM_TagCommonSearchCellTextfiled 5148

//// tag 信用卡账单查询 下拉 textfile
//#define LM_TagJmailPopTextfiled 1748

// 加载 web页面基本数据超时时间
#define LMZX_WebTimeIntervale 5



//********************************  size信息  ********************************************

#define LM_SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define LM_SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height


//********************************  色彩  ********************************************


#define LM_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define LM_RGB(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
// 页面默认的灰色分割线
#define LM_RGBGrayLine LM_RGB(224, 224, 224)


//********************************  字号信息  ********************************************

#define LM_Font(size) [UIFont systemFontOfSize:size]



//******************************* 其余宏 *********************************************

// ***********  打印： 当打包 SDK 需要禁止此处的打印 ***********

#define LMLog(...) [[LMZXLog defaultLog] LMZXLogging:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:__VA_ARGS__]]];









#define LM_iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define LM_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define LM_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define LM_iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)







