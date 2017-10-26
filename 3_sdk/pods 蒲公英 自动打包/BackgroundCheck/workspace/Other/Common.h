//
//  Common.h
//  T98
//
//  Created by mythkiven on 15/9/1.
//  Copyright (c) 2015年 yunhoo. All rights reserved.
//

// 微信信息 不可删除 微信订单 本地保留
#define WeChatAppPayOrderListDetail @"WeChatAppPayOrderListDetail_"


//********************************  系统信息  ********************************************
// devices.
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define iOS11        ([UIDevice currentDevice].systemVersion.floatValue >=11.0)
#define iOS8        ([UIDevice currentDevice].systemVersion.floatValue >=8.0)
#define iOS7        ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) && ([UIDevice currentDevice].systemVersion.floatValue < 8.0)
#define iOS6        ([UIDevice currentDevice].systemVersion.floatValue >= 6.0) && ([UIDevice currentDevice].systemVersion.floatValue < 7.0)
#define iOS7_OR_LATER       [UIDevice currentDevice].systemVersion.floatValue >= 7.0
#define iOS8_OR_LATER       [UIDevice currentDevice].systemVersion.floatValue >= 8.0
#define iOS9_OR_LATER       [UIDevice currentDevice].systemVersion.floatValue >= 9.0
#define iOS10_OR_LATER       [UIDevice currentDevice].systemVersion.floatValue >= 10.0
#define iPad                [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad
// 型号
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
// (width = 750, height = 1334)
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)
// 1125 * 2001
#define iphone56Rate (1-1136/1334)

// sandbox paths.
#define DocumentsPath       [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()]
#define LibraryPath         [NSString stringWithFormat:@"%@/Library", NSHomeDirectory()]
#define LibraryCachesPath   [NSString stringWithFormat:@"%@/Library/Caches", NSHomeDirectory()]
#define TmpPath             [NSString stringWithFormat:@"%@/tmp", NSHomeDirectory()]
#define DOUCMENTS_DIRECYTORY [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// UUid
#define UUID  [UIDevice currentDevice].identifierForVendor.UUIDString
// 当前语言
#define CURRENT_INTERNATIONAL [NSString stringWithFormat:@"%@", @"cn"]


//********************************  版本信息  ********************************************

/** 1.3.0接口专用，历史接口，不删改：：：  */
#define VERSION_APP_1_3_0 @"1.3.0"

/** 1.3.3接口专用，历史接口     ：：：领英\脉脉、淘宝、意见反馈 */
#define VERSION_APP_1_3_3 @"1.3.3"

/** 1.3.3接口专用，准历史接口     ：：：领英\脉脉、淘宝、意见反馈 */
#define VERSION_APP_1_3_4 @"1.3.4"

/** 1.4.0接口专用，历史接口     ：：：信用卡账单、失信、A套餐定价、城市列表变更 */
#define VERSION_APP_1_4_0 @"1.4.0"

/** 1.4.1接口专用，历史接口     ：：：汽车保险、母子账号、B套餐定价 */
 #define VERSION_APP_1_4_1 @"1.4.1"

/** 1.4.2接口专用，历史接口     ：：：公积金城市列表、请求动画、网银流水 */
#define VERSION_APP_1_4_2 @"1.4.2"

/** 1.4.3接口专用，历史接口     ：：：运营商结果数据格式修改 */
#define VERSION_APP_1_4_3 @"1.4.3"


/** 1.4.4接口专用，历史接口     ：：：有关接口分页 */
#define VERSION_APP_1_4_4 @"1.4.4"



/** 系统版本号                  ：：：介绍*/

#define VERSION_SYSTEM_NOW [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

////以下实际 已经替换为 VERSION_APP_1_3_3 准历史接口
//#ifdef DEBUG
//#define NEXT_APP_VERSION @"1.3.3"
//#else
//#define NEXT_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//#endif

////bound Version
//#define Version     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//#define versionK    @"versionK232312WWWqqq"


//********************************  size信息  ********************************************
// Size：
#define SCREEN_BOUNDS   [UIScreen mainScreen].bounds
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define SCREEN_CENTERX  [UIScreen mainScreen].bound.size.width/2.0
#define SCREEN_CENTERY  [UIScreen mainScreen].bound.size.height/2.0
#define viewX(v)        v.frame.origin.x
#define viewY(v)        v.frame.origin.y
#define viewWidth(v)    v.frame.size.width
#define viewHeight(v)   v.frame.size.height
#define  MinX(x) CGRectGetMinX(x)
#define  MinY(x) CGRectGetMinY(x)
#define  MaxX(x) CGRectGetMaxX(x)
#define  MaxY(x) CGRectGetMaxY(x)
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
//10的间隙
#define kMargin_10      10
//10的间隙
#define kMargin_15      15


//********************************  color信息  ********************************************
#define JColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//使用：JColorFromRGB(0x60689f)

#define YJColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define YJBgColor YJColor(25,57,103)
//色彩：
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
//黑色
#define RGB_black           RGB(0, 0,0)
//白色
#define RGB_white           RGB(255, 255, 255)
//导航条颜色
#define RGB_navBar          RGB(48, 113, 242)
//导航条颜色
#define RGB_clear           [UIColor clearColor]
//绿色查询按钮
#define RGB_greenBtn        RGB(57, 179, 27)
//绿色查询按钮
#define RGB_greenBtnHeighLight        RGB(30, 150, 0)
//灰色直线分割线颜色
//#define RGB_grayLine        RGB(199, 199, 199) //#e0e0e0
#define RGB_grayLine        RGB(204, 204, 204) //#ccc

//淡灰色文字-placehold-选中cell的状态背景色
#define RGB_grayPlaceHoldText RGB(204, 204, 204)
//淡灰色文字-报告页面灰色文字
#define RGB_grayNormalText    RGB(153, 153, 153)
//页面淡灰色背景色 #f5f5f5
#define RGB_pageBackground    RGB(240, 242, 245)  // #f0f2f5

/**蓝色字体*/
#define RGB_blueText          RGB(48, 113, 242) // #3071f2
/**红色字体*/
#define RGB_redText          RGB(242, 65, 48) // #f24130
/**黄色背景色*/
#define RGB_yellowBg RGB(255, 243, 184) // #fff3b8

#define RGB_red_alph3       RGBA(239, 83, 68, 0.3)
#define RGB_red_alph6       RGBA(239, 83, 68, 0.6)
#define RGB_red             RGB(239, 83, 68)
#define RGB_yellow          RGB(245, 177,87)
#define RGB_gray            RGB(241, 241, 241)
#define RGB_gray115         RGB(115, 115, 115)
#define RGB_grayBar         RGB(247, 247, 247) //f7f7f7
#define RGB_lightGray         RGB(236, 240, 243) 
//选中背景色
#define RGB_graySelected         RGB(221, 221, 221)


//********************************  字号信息  ********************************************
//字体：
#define JFont(size) [UIFont systemFontOfSize:size]
//字体：21号
#define Font21      JFont(21)
//字体：18号
#define Font18      JFont(18)
//字体：17号
#define Font17     JFont(17)
//字体：16号
#define Font16     JFont(16)
//字体：15号
#define Font15      JFont(15)
//字体：14号
#define Font14     JFont(14)
//字体：13号
#define Font13      JFont(13)
#define Font30      JFont(30)

//********************************  本地化信息  ********************************************
//用户相关：
#define JIsLoginUser @"JIsLoginUser"
//是否有网络
#define JIsNetWorking @"JIsNetWorking"
//用户所有信息
#define JLAST_USER_INFO @"lastUser"
//用户手机号
#define JLAST_USER_Phone @"LAST_USER_Phone"

//********************************  NSNotificationCenter  ********************************************

// 运营商发送验证码，提示用户输入验证码。仅仅在Main页面
#define NSNotificationCenter_OperationShow_sendMeaasga @"NSNotificationCenter_OperationShow_sendMeaasga12"

#define NSNotificationCenter_OperationReault_meaasga @"NSNotificationCenter_OperationReault_meaasga21"

#define NSNotificationCenter_Operationerror_meaasga @"NSNotificationCenter_Operationerror_meaasga11"

#define NSNotificationCenter_Operationerror_OK @"NSNotificationCenter_Operationerror_OK"

#define NSNotificationCenter_inputSrearchBar  @"NSNotificationCenter_inputSrearchBar_"



//重设密码系列
//短信
#define NSNotificationCenter_OperationShow_88meaasga @"NSNotificationCenter_OperationShow_88meaasga13"
//密码
#define NSNotificationCenter_OperationShow_88_2meaasga @"NSNotificationCenter_OperationShow_88_2meaasga14"
#define NSNotificationCenter_OperationShow_88_3meaasga @"NSNotificationCenter_OperationShow_88_3meaasga15"
//短信
#define NSNotificationCenter_OperationShow_81meaasga @"NSNotificationCenter_OperationShow_81meaasga16"
//密码
#define NSNotificationCenter_OperationShow_81_2meaasga @"NSNotificationCenter_Operationerror_88_2meaasga17"
//密码
#define NSNotificationCenter_ShowMidView @"NSNotificationCenter_ShowMidView"

//用户退出登录
#define YJNotificationUserLogout @"userLogout"
//用户登录成功
#define YJNotificationUserLogin @"userLogin"


//支付成功
#define YJNotificationPaySuccess @"YJNotificationPaySuccess"
//支付成功 支付宝
#define YJNotificationPaySuccessALi @"YJNotificationPaySuccessALi"

//记录-选中日期
#define YJDateDidChangeNotification @"YJDateDidChangeNotification"
//记录选中查询类型
#define YJApiTypeDidChangeNotification @"YJApiTypeDidChangeNotification"

//记录选中子账号类型
#define YJUserOperatorIdDidChangeNotification @"YJUserOperatorIdDidChangeNotification"


//AppDelegate
#define appWillResignActiveJ @"appWillResignActiveJ"


//********************************  提示语  ********************************************
// 统一错误显示
#define errorInfo @"数据请求失败"
#define tokensaveOnce @"tokensaveOncewwwwwwooo"
//储存已经进入的页面
#define MatchBeginTime @"kaishishijian"


//********************************  方法  ********************************************
#define From1(p)  [p isBeingPresented]
#define From2(p)  [p isBeingDismissed]
#define kPersionManager [PersionManager shareManager]
//添加空格
#define FillSpace(text) [NSString spaceString:text];
//添加0
#define zeroSpace(text) [text zeroString]

//********************************  其他  ********************************************
//talkingData标签
#ifdef DEBUG
#define TalkingDataLabel @"测试环境"
#else
#define TalkingDataLabel @"生产环境"
#endif

// tag
#define TagCommonSearchCellTextfiled 998

// 错误码汇总 error
// 查询超时错误：
#define ErrorCodeDelay  105
// 一般查询的账户错误
#define ErrorCodeNormal  100

//提示错误信息后，延时推出时间
#define errorDelay 1.5

// 保存的手机号
#define iphoneSave @"iphoneSave15368229863"

// 订单加密的公钥
#define kPublicKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCfzggZEJXQ4ESFzcpMAQWL5IxpGVK1tGMQMfyNpcsp/D2mDPM9dxblKDDV/f+H0pmt8PoG8oNaoZdZwD+fCnUJnycCLKF3XZPZrgLcMEY2VrCjABr2/HyjazcDWu8IX1CkRtxe4RhgORWUDgMdMG7UgqXnqB71vg2ar4bVmux8eQIDAQAB"

#define kUserManagerTool [YJUserManagerTool user]



// 打印：
#ifdef DEBUG
#   define Log(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }


#define MYLog(...) NSLog(__VA_ARGS__)
#else
#   define ULog(...)
#define MYLog(...)
#endif





#define PARAM_IS_NIL_ERROR(param) ((param == nil || [param isKindOfClass:[NSNull class]]) ? @"" : param)
#define PARAM_IS_NIL_ERROR_MONEY(param) ((param == nil) ? @"0.00" : param)
#define PARAM_IS_NIL_PLACEHOLDER(param, placeholder) ((param == nil) ? placeholder : param)


/////// 新增宏
// 通用
#define jWindow [UIApplication sharedApplication].keyWindow
// 1、Log
#ifdef DEBUG
#define JLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define JLog(...)

#endif
// 2、强弱引用

#define JWeakSelf(type)  __weak typeof(type) weak##type = type;
#define JStrongSelf(type)  __strong typeof(type) type = weak##type;
// 3、view圆角
#define JViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]
// 4、Toast
#define JToast(str)              CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle]; \
[jWindow  makeToast:str duration:0.6 position:CSToastPositionCenter style:style];\
jWindow.userInteractionEnabled = NO; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
jWindow.userInteractionEnabled = YES;\
});\



#define jPopSelfVC(VC) [self performSelector:@selector(outself) withObject:nil afterDelay:0.6];

// 5、添加方法
#define kBackView         for (UIView *item in jWindow.subviews) { \
if(item.tag == 10000) \
{ \
[item removeFromSuperview]; \
UIView * aView = [[UIView alloc] init]; \
aView.frame = [UIScreen mainScreen].bounds; \
aView.tag = 10000; \
aView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3]; \
[kWindow addSubview:aView]; \
} \
} \



// 登录页面弹出用
// 用于保证只会弹出一个登录页面,防止多次弹出
#define  baozheng_duoci_qingqiu_meici_tanchu_yige_yemian @"baozheng_duoci_qingqiu_meici_tanchu_yige_yemian"


// 用于保证只会弹出一个登录页面,防止多次弹出
#define  cookie_session_login_lmzx @"cookie_session_login_lmzx"



