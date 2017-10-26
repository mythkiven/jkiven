//
//  SetLoginPassword.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/21.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "YJCompanyDetailManager.h"

#import "SetLoginPasswordd.h"
#import "AppDelegate.h"
#import "PDKeyChain.h"
#import "YJTabBarController.h"
@interface SetLoginPasswordd ()
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *eye;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *confirmBtn;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *tipsTitle;

@end

@implementation SetLoginPasswordd
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eye.alpha =1.0;
    self.eye.hidden =NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.confirmBtn.enabled = NO;
    self.confirmBtn.alpha = 0.3;
    self.confirmBtn.layer.cornerRadius = 2.0;
    self.confirmBtn.layer.masksToBounds = YES;
    [self.confirmBtn setBackgroundColor:[UIColor  colorWithHexString:@"#39b31b"]];
    [self.confirmBtn setTitleColor:RGB_white forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:RGB_white forState:UIControlStateHighlighted];
    
    [_password addTarget:self action:@selector(textFieldDidEndEditingD:) forControlEvents:UIControlEventEditingChanged];
    
    if (_soureVC ==11) {
        _tipsTitle.text = @"设置登录密码";
    } else {
         _tipsTitle.text = @"设置登录密码";
    } 
}

#pragma mark 交互
-(void)textFieldDidEndEditingD:(UITextField*)textFiled{
    [self setBtnStatus];
}
-(void)setBtnStatus{
    if (self.password.text.length>=6 && self.password.text.length<=16) {
        self.confirmBtn.alpha = 1;
        self.confirmBtn.enabled =YES;
    }else{
        self.confirmBtn.alpha = 0.3;
        self.confirmBtn.enabled =NO;
    }
}
- (IBAction)showPassword:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.password.secureTextEntry = !sender.selected;
}
- (IBAction)clickBtn:(UIButton *)sender {
    if ([self verificatePassword:self.password]){
        [self sendNetWorking];
    }
}

#pragma mark - 注册
- (void)sendNetWorking {
    NSDictionary *dicParams;
    NSString *url;
    if (self.soureVC == 12) {//注册
        dicParams =@{@"method" : urlJK_register,
                     @"appVersion" : ConnectPortVersion_1_0_0,
                     @"mobile" : _phone,
                     @"userPwd" :[self base64Encode:  _password.text],
                     @"phoneCode" :_smsCode,
                     @"deviceNum":[PDKeyChain loadUniqueIDInKeyChain],
                     @"modelCode" :APP_REGISTER_AUTHCODE};
        url =urlJK_register;
    } else if (self.soureVC == 11) {// 登录忘记密码
        dicParams =@{@"method" : urlJK_resetPwdForForgetPwd,
                     @"appVersion" : ConnectPortVersion_1_0_0,
                     @"mobile" : _phone,
                     @"userPwd" : [self base64Encode:  _password.text],
                     @"phoneCode" :_smsCode,
                     @"modelCode" :APP_FORGETPWD_AUTHCODE};
        url = urlJK_resetPwdForForgetPwd;
    }
    __block typeof(self) sself = self;
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:url] params:dicParams success:^(id responseObj) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        MYLog(@"%@",responseObj);
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            if (sself.soureVC == 12) {// 注册
                [Tool setObject:_phone forKey:iphoneSave];
                [sself.view makeToast:@"注册成功"];
                [TalkingData trackEvent:@"注册成功" label:TalkingDataLabel];
            }else if (sself.soureVC == 11) {// 登录忘记密码
                [sself.view makeToast:@"重置密码成功"];
            }
            
            NSDictionary *list = [responseObj objectForKey:@"data"];
            if (![list isKindOfClass:[NSNull class]]) {//有数据
                // cookie 处理:
                [self getAndSaveCookie];
                // 用户信息本地化
                [YJUserManagerTool clearUserInfo];
                YJUserModel *user = [YJUserModel mj_objectWithKeyValues:list];
                user.login = YES;
                // 密码存空值,传空值
                // user.userPwd =_password.text;
                user.userPwd =@" ";
                //user.authStatus = user.authQualifyFlag;
                [YJUserManagerTool saveUser:user];
                [[NSUserDefaults standardUserDefaults]  setObject:user.mobile forKey:iphoneSave];
                [[NSUserDefaults standardUserDefaults]  synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:YJNotificationUserLogin object:nil];
                [sself getCompanyInfoFromNet];
            }
                
            [sself performSelector:@selector(pop) withObject:nil afterDelay:1.0f];
            
        }else{
            [sself.view makeToast:responseObj[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:errorInfo];
    }];
}

-(void)pop{
    if(_soureVC==11) // 忘记密码
        [self dismissViewControllerAnimated:YES completion:nil];
    else{ // 注册
        [self dismissViewControllerAnimated:YES completion:nil];
        YJTabBarController *yy = [YJTabBarController shareTabBarVC];
        yy.selectedViewController = yy.viewControllers[0];
        self.view.window.rootViewController = yy;
        [self.view.window makeKeyAndVisible];
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - 获取并保存cookie到userDefaults
- (void)getAndSaveCookie
{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *tempCookie in cookies) {
        NSLog(@"getCookie: %@", tempCookie);
    }
    /*
     * 把cookie进行归档并转换为NSData类型
     * 注意：cookie不能直接转换为NSData类型，否则会引起崩溃。
     * 所以先进行归档处理，再转换为Data
     */
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    [Tool  setObject: cookiesData forKey: cookie_session_login_lmzx];
    
    [self deleteCookie];
    
    [self setCoookie];
    
}

#pragma mark 删除cookie
- (void)deleteCookie {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    //删除cookie
    for (NSHTTPCookie *tempCookie in cookies) {
        [cookieStorage deleteCookie:tempCookie];
    }
}

#pragma mark 再取出保存的cookie,并重新设置
- (void)setCoookie{
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
    }
    
}

- (void)getCompanyInfoFromNet {
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        
        // 提交企业认证后，企业详情接口
        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_queryMember,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd
                               };
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryMember] params:dict success:^(id responseObj) {
            
            //"status": "00" // 00-待审核 20-审核成功 99-审核失败
            
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                MYLog(@"企业认证---%@",responseObj[@"data"]);
                CompanyDetailModel *companyDetailModel = [CompanyDetailModel mj_objectWithKeyValues:responseObj[@"data"]];
                [YJCompanyDetailManager saveCompanyInfo:companyDetailModel];
                
                
                NSLog(@"%@",[YJUserManagerTool user].apiKey);
                
                
                YJUserModel *user = [YJUserManagerTool user];
                user.authStatus = companyDetailModel.status;
                user.companyName = companyDetailModel.companyName;
                [YJUserManagerTool saveUser:user];
                
            } else{
                MYLog(@"企业未认证---%@",responseObj[@"data"]);
                YJUserModel *user = [YJUserManagerTool user];
                user.authStatus = @"0";
                [YJUserManagerTool saveUser:user];
            }
        } failure:^(NSError *error) {
            
            MYLog(@"企业认证详情请求失败---%@",error);
            
        }];
    }
    
}


@end

