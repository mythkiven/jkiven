 //
//  moxieFund.m
//  WKWebViewDemo
//
//  Created by gyjrong on 16/12/10.
//  Copyright © 2016年 Methodname. All rights reserved.
//

#import "LMZXCreditBillWebVC.h"
#import "LMZXDemoAPI.h"
#import "UIImage+LMZXTint.h"
#import "NSString+LMZXCommon.h"
#import "UIBarButtonItem+LMZXExtension.h"
#import "LMZXTool.h"

// 成功 URL
#define LMZX_LocationSuccess_TypeURL @"LM_ZXLocationSuccSesstion_TypeURL"
// 登录 URL
#define LMZX_LocationLogin_TypeURL @"LM_ZXLocationLogiSesstion_TypeURL"
// 信用卡账单 当前哪个功能
#define LMZX_LocationFunction_TypeURL @"LM_ZXLocationfuncSesstion_TypeURL"


//  淘宝登录通知
#define LM_NotificationTB_sendSuccess @"LM_NotificationTB_sendSuccess"
#define LM_RGB(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface LMZXCreditBillWebVC ()


// JS string
@property (copy,nonatomic) NSString      *jstring;
// JS string
@property (copy,nonatomic) NSString      *jstring2;


@property (strong,nonatomic) UIView       *bottomView;

// JS URL
@property (copy,nonatomic) NSString      *jsurl;
// JS URL2
@property (copy,nonatomic) NSString      *jsurl2;
// login URL
@property (copy,nonatomic) NSString      *loginUrl;
// 代理设置
@property (copy,nonatomic) NSString      *userAgent;
// 成功的 URL
@property (copy,nonatomic) NSString      *successUrl;
// 成功的 URL2
@property (copy,nonatomic) NSString      *successUrl2;

/**入口URL，GET模块信息
 */
@property (copy,nonatomic) NSString      *entranceURL;

// 登录成功了,标记用于重新加载部分清除缓存无效的 URL.
@property ( assign,nonatomic) BOOL      LoginSuccess;

@end

@implementation LMZXCreditBillWebVC
{
    UIView       *_coverView;
    
    // 协议名称
    NSString *_protocolStr;
    // 协议地址
    NSString *_protocolUrl;
    // 提示
    NSString *_hint;
    UILabel *_hintTitle;
    
    NSString *username_,*password_;
    
    //once 用于控制JS的注入，重要！主要用于控制京东的JS的UI布局的刷新
    NSInteger once;//用于刷新JS注入后的页面,0未注入，1已注入，2已注入过，可加载其他.
    
    
    // 当前是否获取 cookie
    NSMutableString *_getCookie;
    
    // 126 163 短信验证码情形....二次进入
    NSInteger _126smsTimes;
}

- (void)dealloc {
    [self.hostReachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:lmzxkReachabilityChangedNotification object:nil];
}

#pragma mark - 周期

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (!_saveCookie) {
        [self clear];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.LoginSuccess) {
        if (self.type == LMZXCreditCardBillMailTypeQQ|self.type ==LMZXCreditCardBillMailType126|self.type ==LMZXCreditCardBillMailType163|self.type ==LMZXCreditCardBillMailTypesina                                                                                                                                               ) {
            [self loadPage:self.webView];
        }else{
            [self.webView reloadInputViews];
        }
    
    }
    
    if (!_saveCookie) {
        [self clear];
    }
    // 网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:lmzxkReachabilityChangedNotification object:nil];
    NSString *remoteHostName = @"www.baidu.com";
    self.hostReachability = [LMZXReachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认值处理:
    once = 0;
    _saveCookie = NO;
    username_ =nil;
    password_ =nil;
    self.LoginSuccess = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configUI];
    
    // 刷新
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"lm_nav_refresh" title:@"" target:self action:@selector(refresh)];
    
    // 监听网络状态
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(notifationFromNetWork:) name:LM_NotificationTB_sendSuccess object:nil];
    
    
    // GET
    [self GET];
    
}



#pragma mark - UI创建

-(void)configUI{
    
    NSArray *tArr=nil;
    if ([LMZXSDK shared].lmzxProtocolTitle) {
        tArr = [[LMZXSDK shared].lmzxProtocolTitle componentsSeparatedByString:@"**"];
        if (tArr.count==5) {
        }else{
            tArr = nil;
        }
    }
    
    //  0  1  2   3    4   5
    // 163 126 qq sina 139 顺序
    

    switch (self.type) {
        case LMZXCreditCardBillMailTypeQQ:{
            self.title   = @"QQ邮箱账单";
            _hint = @"QQ邮箱";
            _protocolUrl = [LMZXSDK shared].lmzxProtocolUrl;
            if (tArr) {
                _protocolStr = tArr[2];
            }else{
                _protocolStr = [LMZXSDK shared].lmzxProtocolTitle;
            }
            break;
        }case LMZXCreditCardBillMailType126:{
            self.title = @"126邮箱账单";
            _hint = @"126邮箱";
            _protocolUrl = [LMZXSDK shared].lmzxProtocolUrl;
            if (tArr) {
                _protocolStr = tArr[1];
            }else{
                _protocolStr = [LMZXSDK shared].lmzxProtocolTitle;
            }
            break;
        }case LMZXCreditCardBillMailType163:{
            self.title = @"163邮箱账单";
            _hint = @"163邮箱";
            _protocolUrl = [LMZXSDK shared].lmzxProtocolUrl;
            if (tArr) {
                _protocolStr = tArr[0];
            }else{
               _protocolStr = [LMZXSDK shared].lmzxProtocolTitle;
            }
            
            
            break;
        }case LMZXCreditCardBillMailType139:{
            self.title = @"139邮箱账单";
            _hint = @"139邮箱";
            _protocolUrl = [LMZXSDK shared].lmzxProtocolUrl;
            if (tArr) {
                _protocolStr = tArr[4];
            }else{
                _protocolStr = [LMZXSDK shared].lmzxProtocolTitle;
            }
            break;
        }case LMZXCreditCardBillMailTypesina:{
            self.title = @"新浪邮箱账单";
            _hint = @"新浪邮箱";
            _protocolUrl = [LMZXSDK shared].lmzxProtocolUrl;
            if (tArr) {
                _protocolStr = tArr[3];
            }else{
                _protocolStr = [LMZXSDK shared].lmzxProtocolTitle;
            }
            break;
        }case LMZXCreditCardBillMailTypealiyun:{
            self.title = @"阿里云邮箱账单";
            _protocolUrl = [LMZXSDK shared].lmzxProtocolUrl;
            
            _protocolStr = @"《阿里云邮箱授权协议》";
            
            _hint = @"阿里云邮箱";
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
    title.text = [NSString stringWithFormat:@"%@加载中..",_hint] ;
    title.textColor = [UIColor whiteColor];
    title.textAlignment = 1;
    title.center = CGPointMake(_coverView.center.x, _coverView.center.y-70);
    [_coverView addSubview:title];
    _hintTitle = title;
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.8;
    [self.view addSubview:_coverView];
    
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, LM_SCREEN_HEIGHT -64-40, LM_SCREEN_WIDTH, 40)];
    self.bottomView.backgroundColor = [UIColor clearColor];
    
    UILabel *leftL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH/2, 15)];
    leftL.text = @"我已阅读并同意";
    leftL.textAlignment = 2;
    leftL.font = LM_Font(15.0);
    leftL.textColor = LM_RGB(153, 153, 153);
    UIButton *rightL = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightL setTitle:_protocolStr forState: UIControlStateNormal];
    if ([LMZXSDK shared].lmzxProtocolTextColor) {
        [rightL setTitleColor:[LMZXSDK shared].lmzxProtocolTextColor forState:UIControlStateNormal];
    }else{
        [rightL setTitleColor:LM_RGB(48, 113, 242) forState:UIControlStateNormal];
    }
    rightL.titleLabel.font =LM_Font(15.0);
    [rightL setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [rightL addTarget:self action:@selector(touchProtocol) forControlEvents:UIControlEventTouchUpInside];
    
   CGFloat w1 =  [leftL.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
   CGFloat w2 =  [rightL.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
    CGFloat x = (LM_SCREEN_WIDTH - w1- w2)/2;
    leftL.frame = CGRectMake(x, 0, w1, 15);
    rightL.frame = CGRectMake(CGRectGetMaxX(leftL.frame), 0, w2, 15);
    
    
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
//    LMLog(@"time12");
    
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
//    LMLog(@"time13");
    return yes;
}


#pragma mark - 网络请求 设置拦截 URL
-(void)GET{
    
    
    // 启动功能,重置参数
    [LMZXTool removeObjectForKey:LMZX_LocationSuccess_TypeURL];
    [LMZXTool removeObjectForKey:LMZX_LocationLogin_TypeURL];
    
    [LMZXTool removeObjectForKey:LMZX_LocationFunction_TypeURL];
    [LMZXTool setObject:@(self.type) forKey:LMZX_LocationFunction_TypeURL];
    
    //
    
    
    
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
    
    self.url = _loginUrl;
    
    [self loadPage:self.webView];
    
    [LMZXWebNetWork get:_jsurl timeoutInterval:0 success:^(id obj) {
        _jstring = obj;
    } failure:^(NSError *error) {
//        LMLog(@"%@",error);
    }];
    
    if(_jsurl2){
        // 加载 JS
        [LMZXWebNetWork get:_jsurl2 timeoutInterval:0 success:^(id obj) {
            _jstring2 = obj;
//            LMLog(@"time5");
        } failure:^(NSError *error) {
//            LMLog(@"%@",error);
        }];
    }
    
}

#pragma mark - 页面加载
- (void)loadPage:(UIWebView*)webView {
    [self header];
    
    if (nil !=self.url&&self.url.length) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        if (!webView) {
           
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
        //        [self.view makeToast:@"无UserAgent"];
    }
//    LMLog(@"time4.5");
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
    if (self.type == LMZXCreditCardBillMailTypeQQ) {
        for (NSString *url in @[@"http://ptlogin4.mail.qq.com",@"http://w.mail.qq.com",@"https://w.mail.qq.com"]) {
            [self clearUrl:url];
        }
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

    
//    if (self.type == LMZXCreditCardBillMailType126 && [pathURL isEqualToString:@"reg.163.com/httpLoginVerifyNew.jsp"]) {
//        // 126
//        BOOL headerIsPresent = [[request allHTTPHeaderFields] objectForKey:@"Cookie"]!=nil;
//        if(headerIsPresent) return YES;
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSURL *url = [request URL];
//                NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//                // set the new headers
//                [request addValue:@"SID=beca6ba7-9706-4c82-85f5-bac1eac43418; JSESSIONID=abcCiHumiEZAkgK2-1sSv" forHTTPHeaderField:@"Cookie"];
//                
//                [self.webView loadRequest:request];
//            });
//        });
//        return NO;
//    }
    
    
    // x-ntes-mailentry-location
    if ([pathURL isEqualToString:@"ssl.mail.163.com/secondauth/login_163.jsp"]) {
        _126smsTimes = 99;
    }
    
    if ([self checkURL:pathURL]) {
        // html5.mail.10086.cn/html/mailList.html
        // login  "mail.10086.cn/Login/Login.ashx"
        //  cookie:fromhtml5=1;Login_UserNumber=18393033552;Os_SSo_Sid=MTQ5MDMyNjMyNDAwMTAwOTM5019028AF000004;RMKEY=8601278158d49334;a_l=1505878324000|2758669616;a_l2=1505878324000|12|MTgzOTMwMzM1NTJ8MjAxNy0wOS0yMCAxMTozMjowNHxSbWZraXh1SFNVaHhyeDJDWXpja21DRGo2elhGM1FNeUJoWFBNN0t5bTJpWUg2cGNmcGRMUThRT2I3Wk9qK2FMY2Rid1lhTmNrQzNMamE2aVZ3bVRGZz09fDc0ZjFlZGE1NTJmNjJmM2JhNDY2M2Q5Y2M0OTdlNzdm;agentid=56a969a7-9962-4f27-8da7-cbba56a9ec5e;areaCode1039=1208;cookiepartid=12;cookiepartid1039=12;html5SkinPath1039=;provCode1039=12;
        if (self.type == LMZXCreditCardBillMailTypesina && username_==nil) { // sina 特别, username 方式多
            if ([self getSinaUserName]) {
                _getCookie = nil;
                _getCookie = [NSMutableString stringWithString: [self cookie:pathURL]];
                [self loadAnimation];
                return YES;
                
            }
        }
        if (self.type == LMZXCreditCardBillMailType126 || self.type == LMZXCreditCardBillMailType163) {
            if (username_) {
                _126smsTimes ++;
                if (_126smsTimes == 100) {
                    _getCookie = nil;
                    _getCookie = [NSMutableString stringWithString: [self cookie:pathURL]];
                    [self loadAnimation];
                }
            }
        }
        
        if (username_&&password_) { // password_ 判断:获取到了 cookie.
            _getCookie = nil;
            _getCookie = [NSMutableString stringWithString: [self cookie:pathURL]];
            [self loadAnimation];
            
        }
        
    }
    
    
    NSURL * url = [request URL] ;
    if ([[[url scheme] lowercaseString] isEqualToString:@"jxclmha"]) {
        NSArray *urls=[url.absoluteString componentsSeparatedByString:@"jxclmha://"];
        
        if (((NSString*)urls[1]).length) {
            NSArray *aa = [urls[1] componentsSeparatedByString:@"&?&"];
            
            if (aa.count==2) {
                if (((NSString*)aa[0]).length) {
                    username_ = aa[0];
                }else  if ( ((NSString*)aa[1]).length) {
                    password_ = aa[1];
                }
            } else if (aa.count>=3) {
                if ( ((NSString*)aa[0]).length) {
                    username_ = aa[0];
                }
                password_ = [url.absoluteString substringFromIndex:( @"jxclmha://&?&".length+username_.length)];
                
            }
             
        }
        return NO;
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
    
    if (once==1) {
        [self.webView stopLoading];
        _coverView.hidden =YES;
        once=2;
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
    
    self.bottomView.hidden = hidTHit;
    
    [self.webView setScalesPageToFit:YES];
    
    [self insertJS:webView];
    
    // 1、js 禁用手势缩放
    NSString *injectionJSString = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView stringByEvaluatingJavaScriptFromString:injectionJSString];
    // 要两次才行
    [self insertJS:webView];
    
}

#pragma mark 加载错误
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}



#pragma mark - JS交互
#pragma mark 加载完成 注入JS
-(void)insertJS:(UIWebView *)webView{
    
//    switch (self.type) {
//        case LMZXCreditCardBillMailTypeQQ:{
//            self.title   = @"QQ邮箱账单";
//            _jstring = @"var styleQQ = document.createElement('style');\
//            styleQQ.type = 'text/css';\
//            styleQQ.innerHTML =\"#zc_feedback{display: none;}.login_footer{display: none;}.top_announce{display: none;}\";\
//            document.body.appendChild(styleQQ);";
//            break;
//        }case LMZXCreditCardBillMailType126:{
//            self.title = @"126邮箱账单";
//            _jstring = @"var style163 = document.createElement('style');\
//            style163.type = 'text/css';\
//            style163.innerHTML =\".pop-screen{display:none;}#apkDown2{display:none;}#loginForm .reg{display:none;}.mod-footer{display:none;}\";\
//            document.body.appendChild(style163);";
//            break;
//        }case LMZXCreditCardBillMailType163:{
//            self.title = @"163邮箱账单";
//            _jstring = @"var style163 = document.createElement('style');\
//            style163.type = 'text/css';\
//            style163.innerHTML =\".pop-screen{display:none;}#apkDown2{display:none;}#loginForm .reg{display:none;}.mod-footer{display:none;}\";\
//            document.body.appendChild(style163);";
//            break;
//        }case LMZXCreditCardBillMailType139:{
//            self.title = @"139邮箱账单";
//            _jstring = @"var style139 = document.createElement('style');\
//            style139.type = 'text/css';\
//            style139.innerHTML =\"#appIconTip{display:none;}footer{display:none;}#advertisingPicture{display:none;} #pwdOperate .operateArea{display:none;}#register{display:none;}\";\
//            document.body.appendChild(style139);";
//            break;
//        }case LMZXCreditCardBillMailTypesina:{
//            self.title = @"新浪邮箱账单";
//            _jstring = @"var styleXL = document.createElement('style');\
//            styleXL.type = 'text/css';\
//            styleXL.innerHTML =\"#mailFnCoverAndroid{display:none;}#mailFnCoveriOS{display:none;}.item-option .forget-password{display:none;}.changeUrl{display:none;}#login-footer{display:none;}\";\
//            document.body.appendChild(styleXL);";
//            break;
//        }
//        default:
//            break;
//    }
    
    if (_jstring.length){
        
        [self.webView stringByEvaluatingJavaScriptFromString:_jstring];
        [self.webView reloadInputViews];
        _coverView.hidden =YES;
    }
    
}


#pragma mark - 交互

#pragma mark  刷新
-(void)refresh {
    [self.webView reload];
}
#pragma mark  back
-(void)back{
    //    NSInteger count = self.webView.pageCount;
    NSString *hosturl = [self.webView.request.URL.host stringByAppendingString:self.webView.request.URL.path];
    // 139 连续加载两次
    if ([hosturl isEqualToString:@"html5.mail.10086.cn/"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    // 163 验证码页面,多次加载进历史
    if ([hosturl isEqualToString:@"ssl.mail.163.com/secondauth/login_163.jsp"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    // 126 验证码页面,多次加载进历史
    if ([hosturl isEqualToString:@"ssl.mail.126.com/secondauth/login_126.jsp"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    // QQ 独立密码,多次加载进历史
    if ([hosturl isEqualToString:@"w.mail.qq.com/cgi-bin/loginpage"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    // [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"if( window.history.length > 1 ) { window.history.go( -( window.history.length - 1 ) ) }; window.setTimeout( \"window.location.replace( '%@' )\", 300 );", targetLocation]];
    if ([self.webView canGoBack]) {
        if (self.LoginSuccess) {
            [self.navigationController popViewControllerAnimated:YES];
            //            [self loadPage:self.webView];
            self.LoginSuccess = NO;
        }else{
            [self.webView goBack];
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
//        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark 点击协议
-(void)touchProtocol {
    LMZXWebViewController *ss = [[ LMZXWebViewController alloc] init];
    ss.viewTitle = self.lmzxProtocolTitle ;
    ss.viewTitle = [ss.viewTitle substringWithRange:NSMakeRange(1, ss.viewTitle.length-2)];
    ss.url = self.lmzxProtocolUrl;
    [self.navigationController pushViewController:ss animated:YES];
}




#pragma mark - cookie 处理

// @"status":@"1",@"code":@"qq",@"username":username_,@"password":password_,@"cookie":self.QQcid
-(void)notifationFromNetWork:(NSNotification*)noti {
    if (noti.object) {
        NSDictionary*dic = noti.object;
        
        if (!_getCookie) {
            _getCookie = [NSMutableString stringWithCapacity:0];
        }
        if(!username_){
            username_ = @"";
        }
        if(!password_){
            password_ = @"";
        }
        
        
        // 139
        if ([dic[@"code"] isEqualToString:@"139"]) {
            if(!username_.length) username_ = dic[@"username"];
            if(!password_.length) password_ = dic[@"password"];
        }
        //qq
        else if ([dic[@"code"] isEqualToString:@"qq"]){
            if(!username_.length) username_ = dic[@"username"];
            if(!password_.length) password_ = dic[@"password"];
            
        }//126
        else if ([dic[@"code"] isEqualToString:@"126"]){
            if(!username_.length) username_ = dic[@"username"];
            if(!password_.length) password_ = dic[@"password"];
        }//163
        else if ([dic[@"code"] isEqualToString:@"163"]){
            if(!username_.length) username_ = dic[@"username"];
            if(!password_.length) password_ = dic[@"password"];
        }//sina
        else if ([dic[@"code"] isEqualToString:@"sina"]){
            if(!username_.length) username_ = dic[@"username"];
            if(!password_.length) password_ = dic[@"password"];
            
            // 默认值
            if (!username_|(username_.length<1)) {
                username_ = @"username@sina.com";
            }
        }
        
        
        if ([dic[@"status"] isEqualToString:@"1"]) {
            return;
            // 使用方案 2 ...
//            [self loadAnimation];
           
        }
    }
}
-(void)loadAnimation {
    if (!username_|(username_.length<1)) {
        username_ = @"username";
    }
    if (!password_|(password_.length<1)) {
        password_ = @"password";
    }
    // 长度过长,后台不识别使用默认
    if (password_.length>48) {
        password_ = @"password";
    }
    
    switch (self.type) {
        case LMZXCreditCardBillMailTypeQQ:{
            
            break;
        }case LMZXCreditCardBillMailType126:{
            
            break;
        }case LMZXCreditCardBillMailType163:{
            
            break;
        }case LMZXCreditCardBillMailType139:{
            
            break;
        }case LMZXCreditCardBillMailTypesina:{
            
            break;
        }case LMZXCreditCardBillMailTypealiyun:{
            
            break;
        }
        default:
            break;
    }
    
//#warning TEST-TEST
//    BOC 改成 ALL
    
    LMZXQueryInfoModel *model = [[LMZXQueryInfoModel alloc]init];
    [model setDataCreditBillWithUserName:username_ password:password_ accessType:@"sdk" cookie:[NSString base64Encode:_getCookie] idNO:@"idcard" idName:@"idname" loginType:@"cookie" bankCode:@"ALL" billType:@"email"];
    
//#warning TEST-TEST
    
    [self clear];
    
    
    self.LoginSuccess = YES;
    username_ = nil; password_= nil; _getCookie =nil;
    
    
    // 轮训动画页面:
    LMZXLoadingReportBaseVC  * loadingVC = [[LMZXLoadingReportBaseVC alloc] init];
    loadingVC.lmQueryInfoModel = model;
    loadingVC.creditCardMailType = self.type;
    loadingVC.searchType = LMZXSearchItemTypeCreditCardBill;
    [self.navigationController pushViewController:loadingVC animated:YES];
    
}

#pragma mark  cookie
-(NSString*)cookie:(NSString*)ss{
    
    NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //
    for (NSHTTPCookie *str in cookieJar.cookies) {
        NSString *appendString = [NSString stringWithFormat:@"%@=%@;",str.name,str.value];
        [cookieValue appendString:appendString];
    }
   
    return cookieValue;
}

-(BOOL)getSinaUserName{
    
    if (username_&&username_.length>1) {
        return YES;
    }
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //
    for (NSHTTPCookie *str in cookieJar.cookies) {
        if ([str.name isEqualToString:@"cnmail:username"]) {
            if (str.value&&str.value.length>0) {
                username_ = str.value;
                return YES;
            }
            
        }
    }
    
    return NO;
}

//-(void)insertpro{
//    
//    
//    
//   NSString* ss = @"var script126 = document.createElement('script');script126.type = 'text/javascript';script126.innerHTML = \"function ID(name){return document.getElementById(name)};function Class(name){return document.getElementsByClassName(name)[0]};ID('apkDown2').innerHTML='';Class('reg').innerHTML='';Class('mod-footer').innerHTML='';document.getElementsByTagName('html')[0].style.height='100%';document.getElementsByTagName('body')[0].style.height='100%';Class('page').style.padding = '0';Class('page').style.height='100%';Class('mod-footer').innerHTML='<span style=color:#999>我已阅读并同意</span><a href=http://baidu.com style=text-decoration:none>《信用卡账单邮箱授权协议》</a>';Class('mod-footer').style.position='absolute';Class('mod-footer').style.bottom='20px';Class('mod-footer').style.width='100%';\";document.body.appendChild(script126);";
//    
//   NSString* sss= [self.webView stringByEvaluatingJavaScriptFromString:ss];
//}
@end



