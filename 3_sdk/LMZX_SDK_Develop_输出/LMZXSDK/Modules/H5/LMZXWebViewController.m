//
//  StaticWebVew.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXWebViewController.h"
#import "LMZXReachability.h"
#import "LMZXDemoAPI.h"
#define lmzxwide_W [UIScreen mainScreen].bounds.size.width
@interface LMZXWebViewController ()<UINavigationControllerDelegate, UIWebViewDelegate>

/**网络提示*/
@property (nonatomic) LMZXReachability *hostReachability;
@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation LMZXWebViewController
{
    UIButton *leftBtn;
    UIButton *rightBtn;
    UIWebView * _webView;
    UIProgressView * progressView;
    BOOL _once;
}
-(void)dealloc {
    [self.hostReachability stopNotifier];
}
#pragma mark - 初始化
- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
        _activityIndicatorView.center = CGPointMake(LM_SCREEN_WIDTH * 0.5, LM_SCREEN_WIDTH * 0.5);
        [self.view addSubview:self.activityIndicatorView];
        
    }
    return _activityIndicatorView;
}

-(void)configSubView{
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_webView];
    progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH, 1)];
    // 背景 color
//    progressView.backgroundColor = [UIColor redColor];
    // 进度条颜色
    if ([LMZXSDK shared].lmzxThemeColor) {
        progressView.progressTintColor = [LMZXSDK shared].lmzxThemeColor;
    }
//    progressView.trackTintColor = [UIColor redColor];
    [self.view addSubview:progressView];
    
}


#pragma mark - 生命周期

- (void)viewDidLoad{
    [super viewDidLoad];
    [self configSubView];
    
    self.title = _viewTitle;
    self.navigationItem.title=_viewTitle;
    if ([LMZXSDK shared].lmzxPageBackgroundColor) {
        self.view.backgroundColor = [LMZXSDK shared].lmzxPageBackgroundColor;
    }else{
        self.view.backgroundColor = LM_RGB(245, 245, 245);
    }
    
    _webView.delegate=self;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
     [progressView setProgress:0 animated:YES];
    
    //下滑刷新页面
    UISwipeGestureRecognizer *xx = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    xx.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:xx];
    
    
    // 监听网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    NSString *remoteHostName = @"www.baidu.com";
    self.hostReachability = [LMZXReachability reachabilityWithHostName:remoteHostName];
    
    
    // 加载动画
    [self.view addSubview:  self.activityIndicatorView];
    [self.view bringSubviewToFront:self.activityIndicatorView];
    
    [_webView sizeToFit ];
    [_webView scalesPageToFit];
    [self loadWebView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [progressView setProgress:0.3 animated:YES];
    NSRange r = [self.url rangeOfString:@"result"];
    if(r.length>=1){
        leftBtn.hidden = YES;
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!_once) {
        _once =YES;
        [self.hostReachability startNotifier];
    }
    
}

#pragma mark - 加载webview
-(void)loadWebView {
    if (![self updateInterfaceWithReachability:self.hostReachability]) {
        _webView.hidden = YES;
        [self.view makeToast:@"没有网络,请检查您的网络设置"];
        return;
    }else{
        _webView.hidden = NO;
        
    }
    
    [self.activityIndicatorView startAnimating];
    
    //加载HTML
    if (_htmlStr!=nil&&![_htmlStr isEqualToString:@""]) {
    [_webView loadHTMLString:_htmlStr baseURL:nil];
        return;
    }
    //加载URL
    if (self.url.length &&([_htmlFile isEqualToString:@""] || _htmlFile == nil)) {
        [self loadUrl:_url];
    }
    //加载静态页面
    if ([_url isEqualToString:@""] || _url == nil) {
        if (self.htmlFile) {
            [self loadDocument:_htmlFile];
        }
    }
    
}
#pragma mark 加载文件
-(void)loadDocument:(NSString *)docName{
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:docName ofType:@"html"];
    NSURL *htmlUrl = [NSURL fileURLWithPath:htmlPath];
    _webView.scalesPageToFit = YES;
    _webView.scrollView.bounces = NO;
    [_webView setOpaque:NO];
    [_webView loadRequest:[NSURLRequest requestWithURL:htmlUrl]];
}
#pragma mark 加载url
- (void)loadUrl:(NSString *)urlParam{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlParam]];
    if (!_webView) {
        
    }else
        [_webView loadRequest:request];
}


#pragma mark -

#pragma mark 检测网络
- (void) reachabilityChanged:(NSNotification *)note {
    LMZXReachability* curReach = [note object];
//    NetworkStatus netStatus;
    if([curReach isKindOfClass:[LMZXReachability class]]){
        [self updateInterfaceWithReachability:curReach];
    }
    
    
}
#pragma mark 检测网络
- (BOOL)updateInterfaceWithReachability:(LMZXReachability *)reachability {
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL yes=NO;
    switch (netStatus) {
        case NotReachable:        {
//            [self.view makeToast:@"暂无网络连接"];
            break;
        }
        case ReachableViaWWAN:        {
            yes=YES;
            break;
        }
        case ReachableViaWiFi:        {
            yes=YES;
            break;
        }
    }
    return yes;
}


#pragma mark - uiwebview delegate
#pragma mark 开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    [UIView animateWithDuration:2 animations:^{
        [progressView setProgress:0.8 animated:YES];
    }];
    
}
#pragma mark 加载错误
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    LMLog(@"%@",error);
    [progressView setProgress:0 animated:YES];
    [self.view makeToast:@"网络请求错误"];
    [self performSelector:@selector(outSelf) withObject:nil afterDelay:0.8];
    // 移除动画
    [self.activityIndicatorView stopAnimating  ];
}
#pragma mark 结束加载
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIView animateWithDuration:0.5 animations:^{
        [progressView setProgress:1 animated:YES];
        
    } completion:^(BOOL finished) {
        progressView.hidden=YES;
    }];
    [progressView setProgress:0 animated:YES];
    
    // 移除动画
    [self.activityIndicatorView stopAnimating  ];
    
    [_webView setScalesPageToFit:YES];
    
    
}

#pragma mark request
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    LMLog(@"request:%@" ,request);
//    NSURL *url = [request URL];
//    NSString *ur = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//    NSRange  r = [ur rangeOfString:@"result"];
    
    if (navigationType== UIWebViewNavigationTypeLinkClicked ) {
        
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
        
    }
    
    
    return YES;

}

#pragma mark -  刷新
-(void)refreshWebView {
    if (self.url) {
        if (!_webView) {
//            LMLog(@"1");
        }
        if (!_webView.request.URL.absoluteString) {
            self.url=_webView.request.URL.absoluteString;
        }
    }
    [self loadWebView];
    
}
#pragma mark 返回
-(void)backClick {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        //        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark 手势
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if(sender.direction == UISwipeGestureRecognizerDirectionDown){
        [self refreshWebView];
    }
}


#pragma mark - 
#pragma mark 注入JS
- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script{
    return @"";
}
#pragma mark 退出
-(void)outSelf{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
