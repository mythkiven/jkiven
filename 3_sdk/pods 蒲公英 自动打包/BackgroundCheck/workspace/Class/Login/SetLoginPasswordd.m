//
//  SetLoginPassword.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/21.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "SetLoginPasswordd.h"

@interface SetLoginPasswordd ()
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *eye;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *confirmBtn;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *password;

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.confirmBtn.enabled = NO;
    self.confirmBtn.alpha = 0.3;
    self.confirmBtn.layer.cornerRadius = 2.0;
    self.confirmBtn.layer.masksToBounds = YES;
    [self.confirmBtn setBackgroundColor:[UIColor  colorWithHexString:@"#39b31b"]];
    [self.confirmBtn setTitleColor:RGB_white forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:RGB_white forState:UIControlStateHighlighted];
    
    [_password addTarget:self action:@selector(textFieldDidEndEditingD:) forControlEvents:UIControlEventEditingChanged];
    
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
            [sself performSelector:@selector(dismiss) withObject:nil afterDelay:1.0f];
            
        }else{
            [sself.view makeToast:responseObj[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:errorInfo];
    }];
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

