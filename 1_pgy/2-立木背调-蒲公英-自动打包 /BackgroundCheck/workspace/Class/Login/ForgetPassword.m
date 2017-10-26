//
//  FindLoseLoginPhone.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/1.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ForgetPassword.h"
//#import "LoginNewAccountLogin.h"
#import "MessageCode.h"

@interface ForgetPassword ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation ForgetPassword
- (void)dealloc {
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated]; 
    self.edgesForExtendedLayout = UIRectEdgeNone;
} 
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.phone becomeFirstResponder];
//#warning 测试
//    MessageCode *next = [[MessageCode alloc]init];
//    next.phone = @"186 2173 0299";
//    [self.navigationController pushViewController:next animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor ]; 
    self.confirmBtn.alpha = 0.3;
    self.confirmBtn.layer.cornerRadius = 2.0;
    self.confirmBtn.layer.masksToBounds = YES;
    [self.confirmBtn setBackgroundColor:[UIColor  colorWithHexString:@"#39b31b"]];
//    [self.confirmBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    [self.confirmBtn setTitleColor:RGB_white forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:RGB_white forState:UIControlStateHighlighted];
    self.confirmBtn.enabled = NO;
    
    // 监听输入文本变化
    [_phone addTarget:self action:@selector(textViewTextChanged:) forControlEvents:UIControlEventEditingChanged];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark -  交互
- (IBAction)next:(UIButton *)sender {
    if ([self verificatePhone:self.phone]) {
        [self checkMobile];
    }
}

#pragma mark - 校验手机号
-(void)checkMobile {
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_checkUserNameRegister,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" : [_phone.text cutAllSpace]};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString: urlJK_checkUserNameRegister] params:dicParams success:^(id responseObj) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {//没有注册：OK
            [sself.view makeToast:@"手机号未注册"];
        } else if ([responseObj[@"code"] isEqualToString:@"4011"]) {//已经注册： 不行
            [sself sendNetWorking];
        } else {
            [sself.view makeToast:responseObj[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:errorInfo];
    }];
}
#pragma mark 获取验证码
- (void)sendNetWorking {
    __weak typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_sendMobileCode,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" : [_phone.text cutAllSpace],
                               @"modelCode" : APP_FORGETPWD_AUTHCODE};
 
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_sendMobileCode] params:dicParams success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            MessageCode *next = [[MessageCode alloc]init];
            next.phone = _phone.text;
            next.modelCode = APP_FORGETPWD_AUTHCODE;
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

#pragma mark - 键盘处理
- (void)textViewTextChanged:(UITextField *)textField {
    if (_phone.text.length == 11+2) {
        self.confirmBtn.enabled = YES;
        self.confirmBtn.alpha = 1;
    } else {
        self.confirmBtn.enabled = NO;
        self.confirmBtn.alpha = 0.3;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int length = 0;
    if (textField == _phone) {
        length = 11+2;
        if (range.length ==0 &&(range.location==3|range.location==8)) {
            textField.text=[textField.text stringByAppendingString:@" "];
        }else if (range.length ==1 &&(range.location==3|range.location==8)) {
            textField.text=[textField.text substringToIndex:(textField.text.length-1)];
        }
    }
    if (textField.text.length > length-1) {
        NSString * newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (newStr.length>length) {
            return NO;
        }
    }
    return YES;
}

@end
