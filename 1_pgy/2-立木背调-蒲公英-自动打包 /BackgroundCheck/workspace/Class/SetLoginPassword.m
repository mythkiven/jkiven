//
//  SetLoginPassword.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/21.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "SetLoginPassword.h"

@interface SetLoginPassword ()
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *eye;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *confirmBtn;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *password;

@end

@implementation SetLoginPassword
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
    if (self.password.text.length>5) {
        self.confirmBtn.alpha = 1;
        self.confirmBtn.enabled =YES;
    }
}
- (IBAction)showPassword:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.password.secureTextEntry = !sender.selected;
}
- (IBAction)clickBtn:(UIButton *)sender {
    if ([self verificateData]){
        
    }
}

#pragma mark - 注册
- (void)sendNetWorking {
    NSDictionary *dicParams;
    NSString *url;
    if (self.soureVC == 12) {//注册
        dicParams =@{@"method" : urlJK_register,
                     @"mobile" : _phone,
                     @"userPwd" :[self base64Encode:  _password.text],
                     @"phoneCode" :_smsCode,
                     @"modelCode" :APP_REGISTER_AUTHCODE};
        url =urlJK_register;
    } else if (self.soureVC == 11) {// 登录忘记密码
        dicParams =@{@"method" : urlJK_resetPwdForForgetPwd,
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
#pragma mark 校验格式
-(BOOL)verificateData
{
    if ((_password.text == nil)||[_password.text isEqualToString:@""]){
        [self.view makeToast:@"请输入密码" ifSucess:NO];
        return NO;
    }
    if (([_password.text length]<6) || ([_password.text length]>16)){
        [self.view makeToast:@"密码应为6-16位数字、字母的组合" ifSucess:NO];
//        [self.view makeToast:@"密码应为6-16位,字母,数字,下划线组合" ifSucess:NO];
        return NO;
    }
    if (![Tool validatePassword:_password.text]) {
        [self.view makeToast:@"密码应为6-16位数字、字母的组合"];
        return NO;
    }
    return YES;
}

- (NSString *)base64Encode:(NSString *)string {
    NSData *nsdata = [string
                      dataUsingEncoding:NSUTF8StringEncoding];
    return [nsdata base64EncodedStringWithOptions:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
