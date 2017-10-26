//
//  LMZXCreditBillWebVC.h
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/3/10.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import  "WebViewJavascriptBridge.h"
#import "LMZXToast+UIView.h"
#import "LMZXWebViewBaseVC.h"
#import "LMZXWebViewController.h"
#import "LMZXDemoAPI.h"
#import "LMZXAnalysisWebModel.h"




// 业务流程2类：使用客户端进行COOKIE操作。

@interface LMZXCreditBillWebVC : LMZXWebViewBaseVC <UIWebViewDelegate>

// 是否保存 cookie
@property ( assign,nonatomic) BOOL      saveCookie;

/**模块类型:qq=0 126=1 163=2 139=3   sina=4 aliyun=5*/
@property (assign,nonatomic) LMZXCreditCardBillMailType type;

/**  数据model */
@property (strong,nonatomic) LMZXAnalysisWebModel  *analyModel;
//@property (strong,nonatomic) NSMutableArray *configAnalyData;






/**回滚，back 退出*/
-(void)back;

@end
