//
//  JWebBaseVC.m
//  WKWebViewDemo
//
//  Created by gyjrong on 16/12/4.
//  Copyright © 2016年 Methodname. All rights reserved.
//

#import "LMZXWebViewBaseVC.h"
#import "LMZXDemoAPI.h"
@interface LMZXWebViewBaseVC ()

@end

@implementation LMZXWebViewBaseVC
- (id)init {
    self = [super init];
    if (self) {
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([LMZXSDK shared].lmzxPageBackgroundColor) {
        self.view.backgroundColor = [LMZXSDK shared].lmzxPageBackgroundColor;
    }else{
        self.view.backgroundColor = LM_RGB(245, 245, 245);
    }
    

    switch (self.webBusinesstype) {
        case LMZXWebBusinessTypeQQ:
            _viewTitle = @"";
            break;
        case LMZXWebBusinessTypeTaobao:
            _viewTitle = @"淘宝";
            break;
        case LMZXWebBusinessTypeJD:
            _viewTitle = @"京东";
            break;
        case LMZXWebBusinessTypeAlipay:
            _viewTitle = @"";
            break;
            
        default:
            break;
    }
    

    
    
//    // 桥接
//    self.webViewBridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
//    [self.webViewBridge setWebViewDelegate:self];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
