//
//  moxieFund.m
//  WKWebViewDemo
//
//  Created by gyjrong on 16/12/10.
//  Copyright © 2016年 Methodname. All rights reserved.
//

#import "LMZXWebBusinessVC.h"
#import "LMZXTaoBaoLoadingVC.h"
#import "UIImage+LMZXTint.h"
#import "NSString+LMZXCommon.h"
#import "UIBarButtonItem+LMZXExtension.h"
#import "LMZXTool.h"

// 成功 URL
#define LMZX_LocationSuccess_TypeURL @"LM_ZXLocationSuccSesstion_TypeURL"
// 登录 URL
#define LMZX_LocationLogin_TypeURL @"LM_ZXLocationLogiSesstion_TypeURL"

//  淘宝登录通知
#define LM_NotificationTB_sendSuccess @"LM_NotificationTB_sendSuccess"
#define LM_RGB(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface LMZXWebBusinessVC ()

// JS URL
@property (copy,nonatomic) NSString      *jsurl;
// JS URL2
@property (copy,nonatomic) NSString      *jsurl2;
// JS string
@property (copy,nonatomic) NSString      *jstring;
// JS string2
@property (copy,nonatomic) NSString      *jstring2;


// login URL
@property (copy,nonatomic) NSString      *loginUrl;
// 代理设置
@property (copy,nonatomic) NSString      *userAgent;
// 成功的 URL
@property (copy,nonatomic) NSString      *successUrl;
// 成功的 URL2
@property (copy,nonatomic) NSString      *successUrl2;



@property (assign,nonatomic) BOOL          LoginSuccess;

@property (strong,nonatomic) UIView       *bottomView;


/**  数据model */
@property (strong,nonatomic) LMZXAnalysisWebModel  *analyModel;
@property (strong,nonatomic) NSMutableArray *configAnalyData;
@end

@implementation LMZXWebBusinessVC
{
    UIView       *_coverView;
    
    // 协议名称
    NSString *_protocolStr;
    // 协议地址
    NSString *_protocolUrl;
    //  提示
    NSString *_hint;
    UILabel *_hintTitle;
    
    
    NSString *username_,*password_;
    
    //once 用于控制JS的注入，重要！主要用于控制京东的JS的UI布局的刷新
    NSInteger _once;//用于刷新JS注入后的页面,0未注入，1已注入，2已注入过，可加载其他.
    
    
    
    
    
    // 当前是否获取 cookie
    NSString *_getCookie;
}

- (void)dealloc {
    [self.hostReachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    
    
//    LMLog(@"======%@销毁了",self);
}

#pragma mark - 周期
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self clear];
    if (self.LoginSuccess) {
        [self.webView reload];
        [self insertJS1];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.LoginSuccess) {
        [self.webView reloadInputViews];
    }

    // 网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    NSString *remoteHostName = @"www.baidu.com";
    self.hostReachability = [LMZXReachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    
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
    
    [self configUI];
    _once = 0;
    username_ = nil;
    password_ = nil;
    self.LoginSuccess = NO;
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"lm_nav_refresh" title:@"" target:self action:@selector(refresh)];

    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(notifationFromNetWork:) name:LM_NotificationTB_sendSuccess object:nil];
    
    // 加载页面
    if (self.url) {
        [self loadPage:self.webView];
    }
    // GET
    [self GET];
    
}



#pragma mark UI创建
-(void)configUI{
    switch (self.webBusinesstype) {
        case LMZXWebBusinessTypeQQ:{
            self.title = @"QQ";
            break;
        }case LMZXWebBusinessTypeTaobao:{
            self.title = @"淘宝";
            _protocolStr =  [LMZXSDK shared].lmzxProtocolTitle;
            _protocolUrl = [LMZXSDK shared].lmzxProtocolUrl;
            _hint = @"淘宝";
            break;
        }case LMZXWebBusinessTypeJD:{
            self.title = @"京东";
            _protocolStr = [LMZXSDK shared].lmzxProtocolTitle;
            _protocolUrl = [LMZXSDK shared].lmzxProtocolUrl;
            _hint = @"京东";
            break;
        }case LMZXWebBusinessTypeAlipay:{
            self.title = @"Alipay";
            break;
        }
        default:
            break;
    }
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.webView ];
    [self.webView sizeToFit ];
    // UIWebView滚动设置为正常速度
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.webView setScalesPageToFit:YES];
    self.webView.delegate = self;
    if (self.viewTitle) {
        self.title = self.viewTitle;
        self.navigationItem.title= self.viewTitle;
    }
    [self.webView setBackgroundColor:[UIColor grayColor]];
    
    // coverView
    _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH, LM_SCREEN_HEIGHT)];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    title.text =[NSString stringWithFormat:@"%@加载中..",_hint];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = 1;
    title.center = CGPointMake(_coverView.center.x, _coverView.center.y-70);
    [_coverView addSubview:title];
    _hintTitle = title;
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.8;
    _coverView.hidden = NO;
    [self.view addSubview:_coverView];
    
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, LM_SCREEN_HEIGHT -64-40, LM_SCREEN_WIDTH, 40)];
    self.bottomView.backgroundColor = [UIColor clearColor];
    
    UILabel *leftL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH/2, 15)];
    leftL.text = @"我已阅读并同意";
    leftL.textAlignment = 2;
    leftL.font = LM_Font(15.0);
    leftL.textColor = LM_RGB(153, 153, 153);
    UIButton *rightL = [UIButton buttonWithType:UIButtonTypeCustom];
    rightL.frame = CGRectMake(LM_SCREEN_WIDTH/2, 0, LM_SCREEN_WIDTH/2, 15);
    [rightL setTitle:_protocolStr forState: UIControlStateNormal];
    if ([LMZXSDK shared].lmzxProtocolTextColor) {
        [rightL setTitleColor:[LMZXSDK shared].lmzxProtocolTextColor forState:UIControlStateNormal];
    }else{
        [rightL setTitleColor:LM_RGB(48, 113, 242) forState:UIControlStateNormal];
    }
    rightL.titleLabel.font =LM_Font(15.0);
    [rightL setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [rightL addTarget:self action:@selector(touchProtocol) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomView addSubview:leftL];
    [self.bottomView addSubview:rightL];
    self.bottomView.hidden = YES;
    [self.view addSubview:self.bottomView];
}







#pragma mark -  检测网络
- (void) reachabilityChanged:(NSNotification *)note {
    LMZXReachability* curReach = [note object];
    if([curReach isKindOfClass:[LMZXReachability class]]){
        [self updateInterfaceWithReachability:curReach];
    }

    
}
- (BOOL)updateInterfaceWithReachability:(LMZXReachability *)reachability {
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL yes=NO;
    switch (netStatus) {
        case NotReachable:        {
            [self.view makeToast:@"暂无网络连接"];
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


#pragma mark - 网络服务
#pragma mark GET请求
-(void)GET{
    
    __block typeof(self) sself = self;
    if (!_configAnalyData) {
        _configAnalyData = [NSMutableArray arrayWithCapacity:0];
    }else{
        [_configAnalyData removeAllObjects];
    }
    
    __block NSString *side=@"";
    
    [LMZXTool removeObjectForKey:LMZX_LocationSuccess_TypeURL];
    [LMZXTool removeObjectForKey:LMZX_LocationLogin_TypeURL];
    
    switch (self.webBusinesstype) {
        case LMZXWebBusinessTypeQQ:{
            break;
        }case LMZXWebBusinessTypeTaobao:{
            side = @"?bizType=taobao";
            break;
        }case LMZXWebBusinessTypeJD:{ //
            side = @"?bizType=jd";
            break;
        }case LMZXWebBusinessTypeAlipay:{
            break;
        }
        default:
            break;
    }
    
    
    [LMZXWebNetWork get:[LMZXSDK_webConfig_URL stringByAppendingString:side] timeoutInterval:LMZX_WebTimeIntervale success:^(id obj) {
        BOOL obj1 =[obj isKindOfClass:[NSNull class]];
        BOOL obj2 =[obj isKindOfClass:[NSString class]];
        
        if (obj1 | obj2) {
            dispatch_async (dispatch_get_main_queue(),^{
                _hintTitle.text =  @"数据请求失败,请稍后重试";
            });
        }else if ([obj isKindOfClass:[NSArray class]] ) {
            NSArray *arr = (NSArray*)obj;
            if (arr && arr.count) {
                // 淘宝
                if ([side isEqualToString:@"?bizType=taobao"]) {
                    LMZXAnalysisWebModel *model  = [[LMZXAnalysisWebModel alloc]initWithDic:arr[0]];
                    _analyModel = model;
                }
                // 京东
                if ([side isEqualToString:@"?bizType=jd"]) {
                    LMZXAnalysisWebModel *model  = [[LMZXAnalysisWebModel alloc]initWithDic:arr[0]];
                    _analyModel = model;
                }
                
                if (_analyModel.items.loginInputUrl) {
                    [LMZXTool setObject:_analyModel.items.loginInputUrl forKey: LMZX_LocationLogin_TypeURL];
                }
                if (_analyModel.items.successUrl) {
                    
                    [LMZXTool setObject:_analyModel.items.successUrl forKey: LMZX_LocationSuccess_TypeURL];
                }
                
                
                _loginUrl = _analyModel.items.loginUrl;
                _userAgent = _analyModel.items.userAgent;
                _jsurl = _analyModel.items.jsUrl[0];
                if (_analyModel.items.jsUrl.count==2) {
                    _jsurl2 = _analyModel.items.jsUrl[1];
                }
                sself.url = _loginUrl;
                
                
                [sself loadPage:sself.webView];
     
                
                // 加载 JS
                [LMZXWebNetWork get:_jsurl timeoutInterval:0 success:^(id obj) {
                    _jstring = obj;
                } failure:^(NSError *error) {
//                    LMLog(@"%@",error);
                }];
                
                if(_jsurl2){
                    // 加载 JS
                    [LMZXWebNetWork get:_jsurl2 timeoutInterval:0 success:^(id obj) {
                        _jstring2 = obj;
                        
                    } failure:^(NSError *error) {
//                        LMLog(@"%@",error);
                    }];
                }
                
            }
            else{
                dispatch_async (dispatch_get_main_queue(),^{
                    _hintTitle.text =  @"数据请求失败,请稍后重试";
                });
            }
        }else{
            dispatch_async (dispatch_get_main_queue(),^{
                _hintTitle.text =  @"数据请求失败,请稍后重试";
            });
        }
        
    } failure:^(NSError *error) {
        
        dispatch_async (dispatch_get_main_queue(),^{
            _hintTitle.text =  @"数据请求失败,请稍后重试";
        });
    }];
    
    
    
    
}
#pragma mark - 页面加载
- (void)loadPage:(UIWebView*)webView {
    [self header];
    
    
    if (nil !=self.url&&self.url.length) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        if (!webView) {
            //            LMLog(@"error 未能初始化");
        }else [webView loadRequest:request];
    } else if (nil !=self.htmlFile&&self.htmlFile.length){
        NSString* htmlPath = [[NSBundle mainBundle] pathForResource:self.htmlFile ofType:nil];
        NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
        NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
        [webView loadHTMLString: appHtml baseURL:baseURL];
    }
    
}
#pragma mark  请求头
-(void)header{
    NSDictionary *dictionary;
    if (_userAgent) {
        dictionary = @{@"UserAgent": _userAgent};
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    } else {
        
        
    }
    
}// request里面设置的无效。。这里是OK的
#pragma mark 缓存/cookie 处理
-(void)clear{
    
    // all
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    // cookie
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    
}
-(void)clearUrl:(NSString *)url{
    
    NSArray * cookArray = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:url]];
    for (NSHTTPCookie*cookie in cookArray) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
    // URL
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    // all
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
}


#pragma mark -  WEBVIEW
#pragma mark  开始请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    NSString *pathURL = [request.URL.host stringByAppendingString:request.URL.path];
    // LMTLog(@"=====___%@",pathURL);

    if ([self checkURL:pathURL]) {
//        if ([pathURL isEqualToString:@"login.m.taobao.com/login.htm"]) {
//            return YES;
//        }
//        if ([pathURL isEqualToString:@"login.m.taobao.com/msg_login.htm"]) {
//            return YES;
//        }
        if (username_&&username_.length>0) {
            _getCookie = nil;
            _getCookie = [NSMutableString stringWithString: [self cookie:pathURL]];
            if (_getCookie.length>10) {
                [self loadAnimation];
            }
        }
    }
    
    
    return YES;
}
-(BOOL)checkURL:(NSString*)url{
    NSArray *arr = [LMZXTool objectForKey:LMZX_LocationSuccess_TypeURL];
    if (arr.count) {
        for (NSString *str in arr) {
            if ([str isEqualToString:url]) {
                return YES;
            }
        }
    }
    
    return NO;
}


#pragma mark 开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    if (_once==1) {
        [self.webView stopLoading];
        _once=2;
    }
    
    
}

#pragma mark  加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *url1 =[webView.request.URL.host stringByAppendingString:webView.request.URL.path];
    NSURL *url0 =   [NSURL URLWithString:_loginUrl];
    NSString *url2 =[url0.host stringByAppendingString:url0.path];
    
    BOOL hidTHit =YES;
    if ([url2 isEqualToString:url1]) {
        hidTHit =NO;
    }
    if ([url1 isEqualToString:@"login.m.taobao.com/msg_login.htm"]) {
        hidTHit =NO;
    }
    
    self.bottomView.hidden = hidTHit;
    
    [self.webView setScalesPageToFit:YES];
    
    // 必须是连续注入 JS 1
    [self insertJS1];
    
    // 1、js 禁用手势缩放
    NSString *injectionJSString = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView stringByEvaluatingJavaScriptFromString:injectionJSString];
    
    // 必须是连续注入 JS 2
    [self insertJS1];
}

#pragma mark 加载错误
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}




#pragma mark -  交互
#pragma mark   刷新
-(void)refresh {
    // 加载页面
    if (self.url) {
        [self loadPage:self.webView];
    }else{
        // GET
        [self GET];
    }
    
}
#pragma mark   back
-(void)back{
    
    NSURL *rurl = self.webView.request.URL;
    
    if (self.webBusinesstype == LMZXWebBusinessTypeTaobao) {
        // 淘宝在验证码登录和密码登录多次加载页面.
        if ( [[rurl.host stringByAppendingString:rurl.path] isEqualToString:@"login.m.taobao.com/msg_login.htm"]) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            return; 
        }
        if ( [[rurl.host stringByAppendingString:rurl.path] isEqualToString:@"login.m.taobao.com/login.htm"]) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            return;
        }
    }
    
    if ([self.webView canGoBack]) {
        if (self.LoginSuccess) {
            [self.navigationController popViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            self.LoginSuccess = NO;
        }else{
            [self.webView goBack];
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark 点击协议
-(void)touchProtocol {
    LMZXWebViewController *ss = [[ LMZXWebViewController alloc] init];
    ss.viewTitle = self.lmzxProtocolTitle ;
    ss.viewTitle = [ss.viewTitle substringWithRange:NSMakeRange(1, ss.viewTitle.length-2)];
    NSString *urlStr = self.lmzxProtocolUrl;
    if ( urlStr && urlStr.length) {
        ss.url = self.lmzxProtocolUrl;
    }else{
        ss.url = LMZXSDK_GetProtocol_URL ;
    }
    
    
    [self.navigationController pushViewController:ss animated:YES];
    
//    LMZXWebViewController *ss = [[ LMZXWebViewController alloc] init];
//    ss.viewTitle = self.lmzxProtocolTitle ;
//    NSString *urlStr =  [LMZXSDK shared].lmzxProtocolUrl;;
//    if ( urlStr && urlStr.length) {
//        ss.url = urlStr;
//    }
//    ss.url = LMZXSDK_GetProtocol_URL ;
//    [self.navigationController pushViewController:ss animated:YES];
    
    
}


#pragma mark - 动画
-(void)notifationFromNetWork:(NSNotification*)noti {
    if (noti.object) {
        NSDictionary*dic = noti.object;
        
        username_ = nil;password_ = @"";
        
        if ([dic[@"cookie"] isEqualToString:@"NULL"]) {
            
            // taobao
            if ([dic[@"code"] isEqualToString:@"taobao"]) {
                username_ = dic[@"username"];
                password_ = dic[@"password"];
                
            }
            //JD
            else if ([dic[@"code"] isEqualToString:@"jd"]){
                username_ = dic[@"username"];
                password_ = dic[@"password"];
                
        }
        }
        
        
    }
    
    
}
-(void)loadAnimation {
    
    LMZXQueryInfoModel *model = [[LMZXQueryInfoModel alloc]init];
    
    switch (self.webBusinesstype) {
        case LMZXWebBusinessTypeQQ:{
            
            break;
        }case LMZXWebBusinessTypeTaobao:{
            
            [model setDataTaoBaoWithUserName:username_ password:@"taobaopassword" accessType:@"sdk" cookie:[NSString base64Encode: _getCookie ] idNO:@"222" idName:@"222" loginType:@"cookie"];
       
            break;
        }case LMZXWebBusinessTypeJD:{
            
            [model setDataJDWithUserName:username_ password:@"jdpassword" accessType:@"sdk" cookie:[NSString base64Encode: _getCookie ] idNO:@"222" idName:@"222" loginType:@"cookie"];
            break;
        }case LMZXWebBusinessTypeAlipay:{
            
            break;
        }
        default:
            break;
    }
    
    if (username_&&password_) {
        [self clear];
        [self loadPage:self.webView];
        self.LoginSuccess = YES;
        // 轮训动画页面:
        LMZXTaoBaoLoadingVC  * loadingVC = [[LMZXTaoBaoLoadingVC alloc] init];
        loadingVC.lmQueryInfoModel = model;
        loadingVC.lmQueryInfoModel.identityNo = @"6666";
        loadingVC.type = self.webBusinesstype;
        [self.navigationController pushViewController:loadingVC animated:YES];
        
        username_ = nil; password_= @"";
        _getCookie = nil;
    }
}

#pragma mark - cookie
-(NSString*)cookie:(NSString*)ss{
    
    NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //
    for (NSHTTPCookie *str in cookieJar.cookies) {
        NSString *appendString = [NSString stringWithFormat:@"%@=%@;",str.name,str.value];
        [cookieValue appendString:appendString];
    }
//    LMLog(@"\n<<<<<\n\n\n\n%@",ss);
//    LMLog(@"\n\nURL:%@ \n\n cookie:%@\n\n\n\n>>>\n",self.webView.request.URL.absoluteString,cookieValue);
    return cookieValue;
}



#pragma mark - JS交互
#pragma mark 加载完成 注入JS

//  false  表示注入成功.
-(void)insertJS1{
    
    if (_jstring2.length){
        
        [self.webView stringByEvaluatingJavaScriptFromString:_jstring2];
       
        [self.webView reloadInputViews];
        _coverView.hidden =YES;
        [_coverView removeFromSuperview];
        _coverView = nil;
        
    }
    if (_jstring.length){
        
       [self.webView stringByEvaluatingJavaScriptFromString:_jstring];
        
        [self.webView reloadInputViews];
        _coverView.hidden =YES;
        [_coverView removeFromSuperview];
        _coverView = nil;
    }
    
    
    
}

//#pragma mark 拦截alert
//- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {
//
//    UIAlertView* customAlert = [[UIAlertView alloc] initWithTitle:@""
//                                                          message:message
//                                                         delegate:nil
//                                                cancelButtonTitle:@"确定"
//                                                otherButtonTitles:nil];
//
//    [customAlert show];
//
//}



@end



