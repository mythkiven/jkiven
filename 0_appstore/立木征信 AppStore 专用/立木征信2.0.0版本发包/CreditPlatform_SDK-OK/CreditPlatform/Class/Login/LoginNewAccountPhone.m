//
//  LoginNewAccountPhone.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/1.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LoginNewAccountPhone.h"
#import "LoginNewAccountLogin.h"
#import "WebViewController.h"
@interface LoginNewAccountPhone ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UIButton *checkBox;
@property (weak, nonatomic) IBOutlet UIButton *xieyiBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation LoginNewAccountPhone
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB_pageBackground;
    self.navigationItem.title = @"注册";
    self.nextBtn.layer.cornerRadius = 2;
    self.nextBtn.layer.masksToBounds = YES;
    [self.nextBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
    [self.nextBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    [self.nextBtn setTitleColor:RGB_white forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:RGB_white forState:UIControlStateHighlighted];
    _checkBox.selected = YES;
    
    
    // 监听输入文本变化
    self.nextBtn.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextFieldTextDidChangeNotification object:_phone];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
}
- (void)textViewTextDidChange:(NSNotification *)noti {
    if (_phone.text.length == 11 && _checkBox.selected == YES) {
        self.nextBtn.enabled = YES;
    } else {
        self.nextBtn.enabled = NO;
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int length = 11;
    
    // 用string 替换 range 位置的字符串
    NSString * newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newStr.length>length) {
        return NO;
    }
    return YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
#pragma mark 选框
- (IBAction)clickedGX:(UIButton *)sender {
    _checkBox.selected = !_checkBox.selected;
}

#pragma mark 进入协议页面
- (IBAction)clickedXY:(id)sender {
     WebViewController *ss = [[ WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    ss.viewTitle = @"用户服务协议";
//    ss.htmlFile = @"UserServeProtocol";
    ss.url = @"https://www.limuzhengxin.com/regProtocol";
    [self.navigationController pushViewController:ss animated:YES];
}
#pragma mark 下一步
- (IBAction)next:(UIButton *)sender {

    if ([self verificateData] ) {
        [self checkMobile];
    }
    
}

#pragma mark 校验格式
-(BOOL)verificateData {
    if ((_phone.text == nil)|[_phone.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入手机号" ifSucess:NO];
        return NO;
    }
    if (![Tool validateMobile:_phone.text]) {
        [self.view makeToast:@"手机号码不合法" ifSucess:NO];
        return NO;
    }
    if(!_checkBox.selected){
        [self.view makeToast:@"请阅读并同意协议" ifSucess:NO];
        return NO;
    }
    return YES;
}


#pragma mark - 校验手机号
-(void)checkMobile {
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_checkUserNameRegister,
                               @"mobile" : _phone.text};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];

    [YJHTTPTool post:[SERVE_URL stringByAppendingString: urlJK_checkUserNameRegister] params:dicParams success:^(id responseObj) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {//没有注册：OK
            [sself sendNetWorking];
        } else if ([responseObj[@"code"] isEqualToString:@"4011"]) {//已经注册： 不行
            [sself.view makeToast:@"手机号已经注册"];
        } else {
            [sself.view makeToast:responseObj[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:errorInfo];
    }];
 
}


#pragma mark   获取验证码
- (void)sendNetWorking {
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_sendMobileCode,
                               @"mobile" : _phone.text,
                               @"modelCode" :APP_REGISTER_AUTHCODE};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_sendMobileCode] params:dicParams success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            [[NSUserDefaults standardUserDefaults]  setObject:_phone.text forKey:iphoneSave];
            [sself performSelectorOnMainThread:@selector(outself) withObject:nil waitUntilDone:2.0f];
        }else {
            [sself.view makeToast:responseObj[@"msg"] ];
        }
          
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        [sself.view makeToast:errorInfo];
    }];
    
}
-(void)outself{
    LoginNewAccountLogin *next = [[LoginNewAccountLogin alloc]init];
    next.phone = _phone.text;
    next.from = 1;
    [self.navigationController pushViewController:next animated:YES];
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
