//
//  ChangePhoneNumTwoStep.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/22.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "ChangePhoneNumTwoStep.h"
#import "MessageCode.h"

@interface ChangePhoneNumTwoStep () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet JEConfirmButton *confirmBtn;

@end

@implementation ChangePhoneNumTwoStep
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新手机号";
    _phone.delegate = self;
    [_phone addTarget:self action:@selector(textViewTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [_confirmBtn loadConfigEnable:NO];
}

#pragma mark - 键盘处理
- (void)textViewTextChanged:(UITextField *)textField {
    if (_phone.text.length == 11+2) {
        _confirmBtn.canClicked = YES;
    } else {
        _confirmBtn.canClicked = NO;
    }
}
 
- (IBAction)clickedBtn:(UIButton *)sender {
    if ([self verificatePhone:_phone]) {
        [self checkMobile];
    }
}


#pragma mark 校验手机号
-(void)checkMobile {
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_checkUserNameRegister,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" : [_phone.text cutAllSpace]};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[SERVE_URL stringByAppendingString: urlJK_checkUserNameRegister] params:dicParams success:^(id responseObj) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {//没有注册：OK
            // 获取验证码
            [sself sendNetWorking];
            
        }else{//已经注册： 不行
            [sself.view makeToast:@"手机号已经注册"];
        }
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        [sself.view makeToast:errorInfo];
    }];
}

#pragma mark 获取验证码
- (void)sendNetWorking {
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_sendMobileCode,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" : [_phone.text cutAllSpace],
                               @"modelCode" : APP_UDMOBLILE_AUTHCODE};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_sendMobileCode] params:dicParams success:^(id responseObj) {
        MYLog(@"修改手机号%@",responseObj);
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            //[sself.view makeToast:@"发送成功"];
            MessageCode *c = [[MessageCode alloc] init];
            c.phone = _phone.text;
            c.oldPhone = _oldPhone;
            c.modelCode = APP_UDMOBLILE_AUTHCODE;
            c.navColor = [UIColor blackColor];
            [self.navigationController pushViewController:c animated:YES];
            
        }else {
            [sself.view makeToast:responseObj[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:errorInfo];
    }];
    
}




#pragma mark - textField
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





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
