//
//  MessageCode.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/20.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//
#import "JInputTextView.h"
#import "MessageCode.h"
#import "SetLoginPasswordd.h"

static UIColor *color_Bule_msg;
@interface MessageCode ()<UITextFieldDelegate,JInputTextViewDelegate>
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger num;
@property (strong, nonatomic) NSString* yzmCode;
@property (weak, nonatomic) IBOutlet UILabel *msgTitle;
@property (weak, nonatomic) IBOutlet UILabel *msgHint;
@property (weak, nonatomic) IBOutlet UIButton *ReSendBtn;
@property (weak, nonatomic) IBOutlet JInputTextView *password;

@property (weak, nonatomic) IBOutlet UITextField *textFiled1;
@property (weak, nonatomic) IBOutlet UITextField *textFiled2;
@property (weak, nonatomic) IBOutlet UITextField *textFiled3;
@property (weak, nonatomic) IBOutlet UITextField *textFiled4;
//@property (weak, nonatomic) IBOutlet UITextField *textFiled5;
//@property (weak, nonatomic) IBOutlet UITextField *textFiled6;
@end




@implementation MessageCode

//@synthesize  navColor = _ww;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_password setFirstEvent:10];
    [self setAttrib];
    
//    if ([self.modelCode isEqualToString:@"APP_REGISTER_AUTHCODE"]) {// 注册
//        self.msgTitle.text = @"设置登录密码";
//    } else  if ([self.modelCode isEqualToString:@"APP_FORGETPWD_AUTHCODE"]) {// 重置密码
//        self.msgTitle.text = @"重置登录密码";
//    }else if ([self.modelCode isEqualToString:@"APP_UDMOBLILE_AUTHCODE"]){ // 修改手机号
//        //self.msgTitle.text = @"";
//    }
    if (!self.navColor) {
        [self.navigationController setNavigationBarHidden:false animated:false];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setTranslucent:false];
        [self.navigationController.view setBackgroundColor:[UIColor clearColor]];
        [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
        
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
        self.title = @"输入验证码";
        self.msgTitle.hidden =YES;
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _textFiled1.delegate =self;
//    _textFiled2.delegate =self;
//    _textFiled3.delegate =self;
//    _textFiled4.delegate =self;
//    _textFiled5.delegate =self;
//    _textFiled6.delegate =self;
    _msgHint.text = [NSString stringWithFormat:@"短信验证码已发送至%@,\n请查看短信并输入",_phone];
    //_msgHint.numberOfLines = 0;
    
    color_Bule_msg = [UIColor colorWithHexString:@"#3071f2"];
    [_textFiled1 becomeFirstResponder];
    _textFiled1.layer.borderColor= color_Bule_msg.CGColor;
    _textFiled2.layer.borderColor= [UIColor colorWithHexString:@"#999999"].CGColor;
    _textFiled3.layer.borderColor= [UIColor colorWithHexString:@"#999999"].CGColor;
    _textFiled4.layer.borderColor= [UIColor colorWithHexString:@"#999999"].CGColor;
    
    [_ReSendBtn setTitleColor: color_Bule_msg forState:UIControlStateNormal];
    [_ReSendBtn setTitleColor: [UIColor colorWithHexString:@"#999999"] forState:UIControlStateDisabled];
    self.num = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self selector:@selector(beginCount:) userInfo:nil repeats:YES];
    
    _password.delegate = self; 
    [_password addTarget:self action:@selector(unitFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
}
-(void)setAttrib{
    NSString *t =_msgHint.text;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:t];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(9, t.length-9)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(9, t.length-9)];
    _msgHint.attributedText = attrStr;
}
- (void)unitFieldEditingChanged:(JInputTextView *)sender
{
    if(sender.text.length==4){
        _yzmCode = sender.text;
        [self  checkYZM];
    } 
}


#pragma mark 定时器
- (void)beginCount:(NSTimer *)timer {
    self.num --;
    _ReSendBtn.enabled =NO;
    [_ReSendBtn setTitle:[NSString stringWithFormat:@"%ld秒后可重发验证码",self.num] forState:UIControlStateNormal];
    
    if (self.num==0) {
        _ReSendBtn.enabled =YES;
        [_ReSendBtn setTitle:@"重发短信验证码" forState:UIControlStateNormal];
        [_ReSendBtn setTitleColor: color_Bule_msg forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer =nil;
        self.num=60;
        return;
    }
}

#pragma mark - 校验验证码
-(void)checkYZM{
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_checkMobileCode,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" : [_phone cutAllSpace],
                               @"phoneCode":_yzmCode,
                               @"modelCode":_modelCode};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[SERVE_URL stringByAppendingString: urlJK_checkMobileCode] params:dicParams success:^(id responseObj) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            
            if ([self.modelCode isEqualToString:APP_UDMOBLILE_AUTHCODE]  ) { // 修改手机号
                [sself  resetMobile];
            } else if ([self.modelCode isEqualToString:APP_REGISTER_AUTHCODE]  ) { // 注册
                SetLoginPasswordd *psd = [[SetLoginPasswordd alloc]initWithNibName:@"SetLoginPasswordd" bundle:nil];
                psd.phone = [_phone cutAllSpace];
                psd.smsCode =sself.yzmCode;
                psd.soureVC = 12;
                [self.navigationController pushViewController:psd animated:YES];
            }else { // 修改密码
                SetLoginPasswordd *psd = [[SetLoginPasswordd alloc]initWithNibName:@"SetLoginPasswordd" bundle:nil];
                psd.phone = [_phone cutAllSpace];
                psd.smsCode =sself.yzmCode;
                psd.soureVC = 11;
                [self.navigationController pushViewController:psd animated:YES];
            }
        }else{
            [_password setFirstEvent:11];
            [sself.view makeToast:responseObj[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [_password setFirstEvent:11];
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        [sself.view makeToast:errorInfo];
    }];
    
}

#pragma mark 修改手机号
-(void)resetMobile{
    
    __weak typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_modifyMobile,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" :_oldPhone,
                               @"newMobile":[_phone cutAllSpace],
                               @"phoneCode":_yzmCode,
                               @"modelCode" : _modelCode};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_modifyMobile] params:dicParams success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            
            // 更换手机号后, 修改本地的手机号
            YJUserModel *user =  [YJUserManagerTool user] ;
            user.mobile = [_phone cutAllSpace];
            [YJUserManagerTool saveUser:user];
            [[NSUserDefaults standardUserDefaults]  setObject:user.mobile forKey:iphoneSave];
            [[NSUserDefaults standardUserDefaults]  synchronize];
            
            [sself.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [sself.view makeToast: responseObj[@"msg"]  ];
        }
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:errorInfo];
    }];
    
}

#pragma mark 重发-验证码
- (IBAction)ReSendMsg:(UIButton *)sender {
    __weak typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_sendMobileCode,
                               @"mobile" : [_phone cutAllSpace],
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"modelCode" : _modelCode};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_sendMobileCode] params:dicParams success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            MYLog(@"发送成功");
            sself.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target: sself selector:@selector(beginCount:) userInfo:nil repeats:YES];
        } else {
            [sself.view makeToast: responseObj[@"msg"]  ];
        }
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:errorInfo];
    }];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
     [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([toBeString length] == 1) {
        switch (textField.tag) {
            case 20:{
                textField.text = [toBeString substringToIndex:1];
                [_textFiled2 becomeFirstResponder];
                _textFiled2.layer.borderColor= color_Bule_msg.CGColor;
                return NO;
                break;
            }case 21:{
                textField.text = [toBeString substringToIndex:1];
                [_textFiled3 becomeFirstResponder];
                _textFiled3.layer.borderColor= color_Bule_msg.CGColor;
                return NO;
                break;
            }case 22:{
                textField.text = [toBeString substringToIndex:1];
                [_textFiled4 becomeFirstResponder];
                _textFiled4.layer.borderColor= color_Bule_msg.CGColor;
                return NO;
                break;
            }case 23:{
                return YES;
                break;
            }
            default:
                break;
        }
        
    }else if([toBeString length] == 0){
        switch (textField.tag) {
            case 24:{
                textField.text = [toBeString substringToIndex:0];
                [_textFiled3 becomeFirstResponder];
                _textFiled3.layer.borderColor= color_Bule_msg.CGColor;
                return NO;
                break;
            }case 23:{
                textField.text = [toBeString substringToIndex:0];
                [_textFiled2 becomeFirstResponder];
                _textFiled2.layer.borderColor= color_Bule_msg.CGColor;
                return NO;
                break;
            }case 22:{
                textField.text = [toBeString substringToIndex:0];
                [_textFiled1 becomeFirstResponder];
                _textFiled1.layer.borderColor= color_Bule_msg.CGColor;
                return NO;
                break;
            }case 21:{
                textField.text = [toBeString substringToIndex:0];
                [_textFiled1 becomeFirstResponder];
                _textFiled1.layer.borderColor= color_Bule_msg.CGColor;
                return NO;
                break;
            }
            default:
                break;
        }
        
        return YES;
    }
    return NO;
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

@end
