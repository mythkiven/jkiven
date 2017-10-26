//
//  JWebBaseVC.h
//  WKWebViewDemo
//
//  Created by gyjrong on 16/12/4.
//  Copyright © 2016年 Methodname. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "WebViewJavascriptBridge.h"

#import "LMZXBaseViewController.h"

#import "LMZXWebNetWork.h"

#import "LMZXReachability.h"

///////////// UIWebView 页面通用基类//////////////////////////


@interface LMZXWebViewBaseVC : LMZXBaseViewController <UIWebViewDelegate>



/** 进度条:默认无*/
@property (strong, nonatomic) UIProgressView *progressView;

/** web 加载的 URL*/
@property (strong,nonatomic) NSString   *url;

/**本地文件名,无后缀*/
@property (strong,nonatomic) NSString   *htmlFile;

/**标题,可以设置默认，但是会实时更新为web的title*/
@property (strong,nonatomic) NSString   *viewTitle;

//@property WebViewJavascriptBridge     * webViewBridge;

/**网络提示*/
@property (nonatomic) LMZXReachability *hostReachability;


@property (strong, nonatomic)  UIWebView *webView;


/**如果有，则子类要实现 左侧按钮点击事件返回*/
//-(void)back;



/**右侧按钮点击事件功能*/
//-(void)setting;





@end
