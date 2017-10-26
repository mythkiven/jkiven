//
//  StaticWebVew.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "WebViewController.h"
//#import "Reachability.h"
#define wide_W [UIScreen mainScreen].bounds.size.width
@interface WebViewController ()<UINavigationControllerDelegate, UIWebViewDelegate>

@end

@implementation WebViewController
{
    UIButton *leftBtn;
    UIButton *rightBtn;
    IBOutlet UIWebView* webView;
     __weak IBOutlet UIProgressView *progressView;
        
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    return self;
}

- (IBAction)reLoadWebView:(id)sender {
    
    [self loadWebView];
    
}



- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = _viewTitle;
    self.navigationItem.title=_viewTitle;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    webView.delegate=self;
    [self loadWebView];
    
//    self.setShowsHorizontalScrollIndicator=NO;
//    webView setShow
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
     [progressView setProgress:0 animated:YES];
    
    //下滑刷新页面
    UISwipeGestureRecognizer *xx = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    xx.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:xx];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [progressView setProgress:0.3 animated:YES];
    NSRange r = [self.url rangeOfString:@"result"];
    if(r.length>=1){
        leftBtn.hidden = YES;
    }
}
#pragma mark 刷新
-(void)refreshWebView {
    if (self.url) {
        if (!webView) {
            MYLog(@"1");
        }
        if (!webView.request.URL.absoluteString) {
            self.url=webView.request.URL.absoluteString;
        }
    }
    [self loadWebView];
    
}
#pragma mark 返回
-(void)backClick {
    if ([webView canGoBack]) {
        [webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
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
#pragma mark 加载webview
-(void)loadWebView
{
    if (![self isConnectionAvailable]) {
        webView.hidden = YES;
        [self.view makeToast:@"没有网络,请检查您的网络设置"];
        return;
    }else{
        webView.hidden = NO;
        
    }
    //加载HTML
    if (_htmlStr!=nil&&![_htmlStr isEqualToString:@""]) {
    [webView loadHTMLString:_htmlStr baseURL:nil];
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
    webView.scalesPageToFit = YES;
    webView.scrollView.bounces = NO;
    [webView setOpaque:NO];
    [webView loadRequest:[NSURLRequest requestWithURL:htmlUrl]];
}
#pragma mark 加载网络
- (void)loadUrl:(NSString *)urlParam{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlParam]];
    if (!webView) {
        
    }else
        [webView loadRequest:request];
}


#pragma mark 检测网络
-(BOOL) isConnectionAvailable{
   __block BOOL isExistenceNetwork = YES;
    
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    [manger startMonitoring];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{//没有网络
                isExistenceNetwork = NO;
                break;
            }case AFNetworkReachabilityStatusUnknown:{//未知网络
                isExistenceNetwork = YES;
                break;
            }case AFNetworkReachabilityStatusReachableViaWWAN:{//34G
                isExistenceNetwork = YES;
                break;
            }case AFNetworkReachabilityStatusReachableViaWiFi:{//wifi
                isExistenceNetwork = YES;
                break;
            }default:
                break;
        }
    }];
    
    if (!isExistenceNetwork) {
        
        return NO;
    }
    
    return isExistenceNetwork;
}

#pragma mark - uiwebview delegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    MYLog(@"%@",error);
    [progressView setProgress:0 animated:YES];
    [self.view makeToast:@"网络请求错误"];
    [self performSelector:@selector(outSelf) withObject:nil afterDelay:0.8];

}
-(void)outSelf{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIView animateWithDuration:0.5 animations:^{
        [progressView setProgress:1 animated:YES];
        
    } completion:^(BOOL finished) {
        progressView.hidden=YES;
    }];
    [progressView setProgress:0 animated:YES];
}


- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script{
    return @"";
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    MYLog(@"request:%@" ,request);
//    NSURL *url = [request URL];
//    NSString *ur = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//    NSRange  r = [ur rangeOfString:@"result"];
    
    if (navigationType== UIWebViewNavigationTypeLinkClicked ) {
        
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
        
    }
    
    
    return YES;

}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    [UIView animateWithDuration:2 animations:^{
        [progressView setProgress:0.8 animated:YES];
    }];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
