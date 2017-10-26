//
//  LoginNewAccountLogin.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/1.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LoginNewAccountLogin.h"
#import "LoginVC.h"
@interface LoginNewAccountLogin ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *yanzhengma;
@property (weak, nonatomic) IBOutlet UITextField *mima;
@property (weak, nonatomic) IBOutlet UIButton *yzmBtn;
@property (weak, nonatomic) IBOutlet UIButton *zcBtn;
- (IBAction)clickedLogin:(UIButton *)sender;

- (IBAction)clickedYZM:(UIButton *)sender;

@property (assign, nonatomic) NSInteger num;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *selectedSee;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;

@end

@implementation LoginNewAccountLogin
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB_pageBackground;
    self.zcBtn.layer.cornerRadius = 2;
    self.zcBtn.layer.masksToBounds = YES;
    [self.zcBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
    [self.zcBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    [self.zcBtn setTitleColor:RGB_white forState:UIControlStateNormal];
    [self.zcBtn setTitleColor:RGB_white forState:UIControlStateHighlighted];
    self.zcBtn.enabled = NO;
    
    if (self.from == 1) {
        self.title = @"注册";
        [self.zcBtn setTitle:@"注册" forState:UIControlStateNormal];
    } else {
        self.title = @"重置密码";
        [self.zcBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    
    }
    self.num = 60;
    
    NSString *str =  [_phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.topLabel.text = [NSString stringWithFormat:@"短信验证码已经发送至%@，请注意查收",str];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self selector:@selector(beginCount:) userInfo:nil repeats:YES];
    self.yzmBtn.enabled = NO;
    self.yzmBtn.layer.cornerRadius = 2;
    self.yzmBtn.layer.masksToBounds = YES;
    self.yzmBtn.layer.borderWidth = 0.5;
    self.yzmBtn.layer.borderColor = RGB_grayLine.CGColor;
    [self.yzmBtn setTitleColor:RGB_grayNormalText forState:(UIControlStateNormal)];
    
    // 系统手势返回
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    
    // 监听输入文本变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_yanzhengma];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_mima];
    
    
}

- (void)textFieldTextDidChange:(NSNotification *)noti {
    if (_yanzhengma.text.length != 0 && _mima.text.length != 0) {
        self.zcBtn.enabled = YES;
    } else {
        self.zcBtn.enabled = NO;
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int length = 0;
    
    if (textField == _yanzhengma) {
        length = 4;
    } else if (textField == _mima) {
        length = 16;
    }
    
    // 用string 替换 range 位置的字符串
    NSString * newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newStr.length>length) {
        return NO;
    }
    return YES;
    
}

#pragma mark--UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}
#pragma mark 验证码
- (IBAction)clickedYZM:(UIButton *)sender {
    NSDictionary *dicParams;
    if ([self.title isEqualToString:@"注册"]) {
        dicParams =@{@"method" : urlJK_sendMobileCode,
                                   @"mobile" : _phone,
                                   @"modelCode" :APP_REGISTER_AUTHCODE};
    }else{
        dicParams =@{@"method" : urlJK_sendMobileCode,
                     @"mobile" : _phone,
                     @"modelCode" :APP_FORGETPWD_AUTHCODE};
    }
    
    
//#warning -- 后台-- 此处如果是手机号码有问题，也会返回处理成功的提示。
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [YJShortLoadingView yj_makeToastActivityInView:self.view];

    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_sendMobileCode] params:dicParams success:^(id responseObj) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self selector:@selector(beginCount:) userInfo:nil repeats:YES];
        self.yzmBtn.enabled = NO;
        self.yzmBtn.layer.borderColor = RGB_grayLine.CGColor;
        [self.yzmBtn setTitleColor:RGB_grayNormalText forState:(UIControlStateNormal)];


//        NSDictionary *list = [responseObj objectForKey:@"list"];
        
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
//            if (![list isKindOfClass:[NSNull class]]) {//有数据
//            }else{//无数据
            [self.view makeToast:@"发送成功"];
//            }
        } else{
            [self.view makeToast: responseObj[@"msg"] ];
        }
        
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:errorInfo];
    }];
    
}
#pragma mark 注册
- (IBAction)clickedLogin:(UIButton *)sender {
//    [self outselfQ];
//    return;
    if ([self verificateData]) {
        [self sendNetWorking];
    }
    
}

#pragma mark 眼睛
- (IBAction)selectSee:(UIButton *)sender {
    [self.mima setFont:nil];
    [self.mima setFont:Font15];
    
    _selectedSee.selected = !_selectedSee.selected;
    if (_selectedSee.selected) {
        _mima.secureTextEntry = NO;
    }else{
        _mima.secureTextEntry = YES;
    }
}
#pragma mark 定时器
- (void)beginCount:(NSTimer *)timer {
    self.num --;
    
    [self.yzmBtn setTitle:[NSString stringWithFormat:@"%lds",self.num] forState:UIControlStateNormal];
    if (self.num==0) {
        self.yzmBtn.enabled = YES;
        
        [self.yzmBtn setTitle:@"重新获取" forState:UIControlStateNormal];
//        self.yzmBtn.layer.cornerRadius = 2;
//        self.yzmBtn.layer.masksToBounds = YES;
//        self.yzmBtn.layer.borderWidth = 0.5;
        self.yzmBtn.layer.borderColor = RGB_grayNormalText.CGColor;
        [self.yzmBtn setTitleColor:RGB_black forState:(UIControlStateNormal)];
        [self.timer invalidate];
        self.timer =nil;
        self.num=60;
        return;
    }
}


#pragma mark - 注册 
- (void)sendNetWorking {
    NSDictionary *dicParams;
    NSString *url;
    if (self.from == 1) {//注册
        dicParams =@{@"method" : urlJK_register,
                     @"mobile" : _phone,
                     @"userPwd" :[self base64Encode:  _mima.text],
                     @"phoneCode" :_yanzhengma.text,
                     @"modelCode" :APP_REGISTER_AUTHCODE};
        url =urlJK_register;
    } else {//重置密码
        dicParams =@{@"method" : urlJK_resetPwdForForgetPwd,
                     @"mobile" : _phone,
                     @"userPwd" : [self base64Encode:  _mima.text],
                     @"phoneCode" :_yanzhengma.text,
                     @"modelCode" :APP_FORGETPWD_AUTHCODE};
        url = urlJK_resetPwdForForgetPwd;
    }
    __block typeof(self) sself = self;
    [YJShortLoadingView yj_makeToastActivityInView:self.view];

    [YJHTTPTool post:[SERVE_URL stringByAppendingString:url] params:dicParams success:^(id responseObj) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        MYLog(@"%@",responseObj);
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
                if (sself.from == 1) {//注册
                    [Tool setObject:_phone forKey:iphoneSave];
                    [sself.view makeToast:@"注册成功"];
                    
                    [TalkingData trackEvent:@"注册成功" label:TalkingDataLabel];
                    
                    
                }else{//重置密码
                    [sself.view makeToast:@"重置密码成功"];
                }
            [sself performSelector:@selector(outselfQ) withObject:nil afterDelay:1.5f];

            
        }else{
            [sself.view makeToast:responseObj[@"msg"]];
        }
        
       
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:errorInfo];
    }];
}


- (NSString *)base64Encode:(NSString *)string {
    NSData *nsdata = [string
                      dataUsingEncoding:NSUTF8StringEncoding];
    return [nsdata base64EncodedStringWithOptions:0];
}


-(void)outselfQ{
    
    LoginVC *ll = (LoginVC*)self.navigationController.viewControllers[0];
    ll.mima.text = @"";
    [self.navigationController popToRootViewControllerAnimated:NO];
    
//    LoginVC *next = [[LoginVC alloc]init];
//    next.isFrom = 101;
//    YJNavigationController *nn = [[YJNavigationController alloc]initWithRootViewController:next];
//    [self presentViewController:nn animated:YES completion:nil];
    
//    [self performSelector:@selector(outQ) withObject:nil afterDelay:0.5];
}
//-(void)outQ{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
#pragma mark 校验格式
-(BOOL)verificateData
{
    if ((_yanzhengma.text == nil)|[_yanzhengma.text isEqualToString:@""])
    {
        if (!_yzmBtn.isEnabled) {
            [self.view makeToast:@"请输入验证码" ifSucess:NO];
        } else {
            [self.view makeToast:@"请点击发送验证码并输入验证码" ifSucess:NO];
        }
        
        return NO;
    }
    if ((_mima.text == nil)||[_mima.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入密码" ifSucess:NO];
        return NO;
    }
    
    if (([_mima.text length]<6) || ([_mima.text length]>16))
    {
        [self.view makeToast:@"密码应为6-16位,字母,数字,下划线组合" ifSucess:NO];
        return NO;
    }
    
    if (![Tool validatePassword:_mima.text]) {
        [self.view makeToast:@"密码应为6-16位,字母,数字,下划线组合"];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - 其他
//退回键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    return YES;
    
}

@end
