//
//  moxieFund.h
//  WKWebViewDemo
//
//  Created by gyjrong on 16/12/10.
//  Copyright © 2016年 Methodname. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "WebViewJavascriptBridge.h"
#import "LMZXToast+UIView.h"
#import "LMZXWebViewBaseVC.h"
#import "LMZXWebViewController.h"

#import "LMZXAnalysisWebModel.h"

// 业务流程2类：使用客户端进行COOKIE操作。

@interface LMZXWebBusinessVC : LMZXWebViewBaseVC <UIWebViewDelegate>






/**回滚，back 退出*/
-(void)back;

@end


// 采用标准格式书写 demo
// 基于WebView + 中间件 WebJS
