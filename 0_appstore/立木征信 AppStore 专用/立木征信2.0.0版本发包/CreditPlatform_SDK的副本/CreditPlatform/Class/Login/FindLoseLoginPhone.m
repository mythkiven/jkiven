//
//  FindLoseLoginPhone.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/1.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "FindLoseLoginPhone.h"
#import "LoginNewAccountLogin.h"
@interface FindLoseLoginPhone ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation FindLoseLoginPhone
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
    self.navigationItem.title = @"重置密码";
    self.nextBtn.layer.cornerRadius = 2;
    self.nextBtn.layer.masksToBounds = YES;
    [self.nextBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
    [self.nextBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    [self.nextBtn setTitleColor:RGB_white forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:RGB_white forState:UIControlStateHighlighted];
    self.nextBtn.enabled = NO;
    
    // 监听输入文本变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextFieldTextDidChangeNotification object:_phone];
    
}

- (void)textViewTextDidChange:(NSNotification *)noti {
    if (_phone.text.length == 11) {
        self.nextBtn.enabled = YES;
//        BOOL isPhone = [Tool validateMobile:_phone.text];
//        if (isPhone) {
//            self.nextBtn.enabled = YES;
//        } else {
//            self.nextBtn.enabled = NO;
//        }
    } else {
        self.nextBtn.enabled = NO;
    }

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int length = 11;
    
    NSString * newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newStr.length>length) {
        return NO;
    }
    return YES;
    
}
- (IBAction)next:(UIButton *)sender {
    if ([self verificateData]) {
        [self checkMobile];
       
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.phone becomeFirstResponder];

}

#pragma mark 校验格式
-(BOOL)verificateData {
    if ((_phone.text == nil)|[_phone.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入手机号" ifSucess:NO];
        return NO;
    }
    if (![Tool validateMobile:_phone.text]) {
        [self.view makeToast:@"请输入正确的手机号" ifSucess:NO];
        return NO;
    }
    return YES;
}

#pragma mark - 校验手机号
-(void)checkMobile {
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_checkUserNameRegister,
                               @"mobile" : _phone.text};
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[SERVE_URL stringByAppendingString: urlJK_checkUserNameRegister] params:dicParams success:^(id responseObj) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {//没有注册：
            [self.view makeToast:@"手机号尚未注册"];
        }else{//已经注册：
            [sself sendNetWorking];
            
        }
        
        
//        LoginNewAccountLogin *next = [[LoginNewAccountLogin alloc]init];
//        next.phone = _phone.text;
//        next.from = 2;
//        [sself.navigationController pushViewController:next animated:YES];
        
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:errorInfo];
    }];
    
}





#pragma mark - 网络 获取验证码
- (void)sendNetWorking {
    __weak typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_sendMobileCode,
                               @"mobile" : _phone.text,
                               @"modelCode" : APP_FORGETPWD_AUTHCODE};

//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_sendMobileCode] params:dicParams success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
                LoginNewAccountLogin *next = [[LoginNewAccountLogin alloc]init];
                next.phone = _phone.text;
                next.from = 2;
                [sself.navigationController pushViewController:next animated:YES];
            
        } else {
            [sself.view makeToast: responseObj[@"msg"]  ];
        }
        
        
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:errorInfo];
    }];
    
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
