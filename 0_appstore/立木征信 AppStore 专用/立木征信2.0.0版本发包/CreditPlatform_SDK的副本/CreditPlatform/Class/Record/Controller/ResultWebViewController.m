//
//  ResultWebViewController.m
//  CreditPlatform
//
//  Created by gyjrong on 2017/6/16.
//  Copyright © 2017年 kangcheng. All rights reserved.
//



#import "ResultWebViewController.h"

@interface ResultWebViewController ()<UIWebViewDelegate>




@property (strong, nonatomic)  UIWebView *webView;



@end

@implementation ResultWebViewController
{
    NSString*_lastURL;
    BOOL _lasturl;
}


- (void)dealloc {
    
    
}

#pragma mark - 周期
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.view endEditing:YES];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
 
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (UIView *_aView in [self.webView subviews]) {
        if ([_aView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO];
            [(UIScrollView *)_aView setShowsHorizontalScrollIndicator:NO];
            for (UIView *_inScrollview in _aView.subviews) {
                if ([_inScrollview isKindOfClass:[UIImageView class]]) {
                    _inScrollview.hidden = YES;
                }
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _lastURL=@"";
    self.url =  [NSString stringWithFormat:@"%@/data/query",self.url];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"lm_nav_refresh" title:@"" target:self action:@selector(refresh)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemtarget:self action:@selector(backK)];
    
    [self creatwebview];
    [self loadPage:self.webView];
    
    if ([self.biztype isEqualToString:kBizType_housefund]) {
        self.title = @"公积金查询报告";
    } else if ([self.biztype isEqualToString:kBizType_socialsecurity]) {
       self.title = @"社保查询报告";
    } else if ([self.biztype isEqualToString:kBizType_mobile]) {
        self.title = @"运营商查询报告";
    } else if ([self.biztype isEqualToString:kBizType_jd]) {
        self.title = @"京东查询报告";
    } else if ([self.biztype isEqualToString:kBizType_credit]) {
        self.title = @"央行征信查询报告";
    } else if ([self.biztype isEqualToString:kBizType_education]) {
        self.title = @"学历学籍查询报告";
    } else if ([self.biztype isEqualToString:kBizType_taobao]) {
        self.title = @"淘宝查询报告";
    } else if ([self.biztype isEqualToString:kBizType_linkedin]) {
        self.title = @"领英查询报告";
    } else if ([self.biztype isEqualToString:kBizType_maimai]) {
        self.title = @"脉脉查询报告";
    } else if ([self.biztype isEqualToString:kBizType_bill]) {
        self.title = @"信用卡账单查询报告";
    } else if ([self.biztype isEqualToString:kBizType_shixin]) {
        self.title = @"失信被执行查询报告";
    } else if ([self.biztype isEqualToString:kBizType_autoinsurance]) {
        self.title = @"车险查询报告";
        _lasturl =YES;
    } else if ([self.biztype isEqualToString:kBizType_ebank]) {
        self.title = @"网银流水查询报告";
        _lasturl =YES;
    }else if ([self.biztype isEqualToString:kBizType_ctrip]) {
        self.title = @"携程查询报告";
    } else if ([self.biztype isEqualToString:kBizType_diditaxi]) {
        self.title = @"滴滴查询报告";
    }
   
}




#pragma mark UI创建
-(void)creatwebview{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    [self.view addSubview:self.webView ];
    [self.webView sizeToFit ];
    // UIWebView滚动设置为正常速度
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.webView setScalesPageToFit:YES];
    self.webView.delegate = self;
//    if (self.viewTitle) {
//        self.title = self.viewTitle;
//        self.navigationItem.title= self.viewTitle;
//    }
    
    self.view.backgroundColor = RGB(229, 229, 229);
    self.webView.backgroundColor = RGB(229, 229, 229);
    
}


#pragma mark -  WEBVIEW
#pragma mark  开始请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSLog(@"--%@",request.URL.absoluteString);
    if (_lasturl) {
        _lastURL = request.URL.absoluteString;
    }
    return YES;
}

#pragma mark 开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView{
}

#pragma mark  加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView{
//        // 1、js 禁用手势缩放
//    NSString *injectionJSString = @" var script = document.createElement('meta');"
//    "script.name = 'viewport';"
//    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
//    "document.getElementsByTagName('head')[0].appendChild(script);";
//    [webView stringByEvaluatingJavaScriptFromString:injectionJSString];
//    
}

#pragma mark 加载错误
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}



#pragma mark -  交互
#pragma mark 刷新
-(void)refresh {
//    http://192.168.117.239:8180/diditaxi/result?token=99367ad717d34629a4fde4fe218ced27
//    http://192.168.117.239:8180/linkedin/result?token=b3f46475c83b49dab2ad5a74686f8aa9
    
//    http://192.168.117.239:8180/autoinsurance/result?token=c9f22c5d97f54444b3ce72238fc624b4
//    http://192.168.117.239:8180/autoinsurance/resultByPolicyNo?id=c6b4b3c7e0c44f9783b3de21a3c00a50&policyNo=PDAA201331020000015013
    
    if (_lasturl&&_lastURL.length) {
        [self setCoookie];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL: [NSURL URLWithString:_lastURL]];
        [self.webView loadRequest: request];
    }else{
        [self loadPage:self.webView];
    }
}

#pragma mark  back
-(void)back{
    NSString *url = self.webView.request.URL.absoluteString;
    if ([url isEqualToString:self.url]) {
        
    }
    if ([self.webView canGoBack]) {
       [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)backK{
    NSString *url = self.webView.request.URL.absoluteString;
    if ([url isEqualToString:self.url]) {
        
    }
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - 页面加载
- (void)loadPage:(UIWebView*)webView {
//    [self header];
    
    
    if (nil !=self.token&&self.token.length && nil !=self.biztype&&self.biztype.length ) {
        
        if (webView) {
            [self setCoookie];
            NSString *body = [NSString stringWithFormat: @"getResult=%@&token=%@&bizType=%@",self.getResult,self.token,self.biztype];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: [NSURL URLWithString:self.url]];
            [request setHTTPMethod: @"POST"];
            [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
            
            
            [webView loadRequest: request];
            
        }else {
            // 没有数据
            
        }
        
    } else {
        
    }
    
}
- (void)setCoookie {
    //取出保存的cookie
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //对取出的cookie进行反归档处理
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:cookie_session_login_lmzx]];
    if (cookies) {
        //设置cookie
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (id cookie in cookies) {
            [cookieStorage setCookie:(NSHTTPCookie *)cookie];
        }
    }else{
        NSLog(@"无cookie");
        //        // 登录
        //        [self showLoginView];
        
    }
}

//#pragma mark  请求头
//-(void)header{
//    NSDictionary *dictionary;
//    if (_userAgent) {
//        dictionary = @{@"UserAgent": _userAgent};
//        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
//    }
//}


@end




