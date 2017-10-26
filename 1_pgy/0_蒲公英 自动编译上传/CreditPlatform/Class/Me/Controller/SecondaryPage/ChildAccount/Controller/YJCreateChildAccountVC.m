//
//  YJCreateChildAccountVC.m
//  CreditPlatform
//
//  Created by yj on 2016/11/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCreateChildAccountVC.h"

@interface YJCreateChildAccountVC ()

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UILabel *motherAccountLB;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UILabel *exampleNameLB;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation YJCreateChildAccountVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新建子账户";
    
    self.exampleNameLB.attributedText = [self exampleAttributedString];
    
    self.motherAccountLB.text = [NSString stringWithFormat:@"@%@",kUserManagerTool.mobile];
//    self.commitBtn.layer.cornerRadius = 2;
//    
//    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    _commitBtn = btn;
//    btn.frame =CGRectMake(15, self.view.height - 45 - 20 -64, SCREEN_WIDTH-30, 45);
//    [btn setTitle:@"确认提交" forState:(UIControlStateNormal)];
//    
//    btn.layer.masksToBounds = YES;


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancelCreateChildAccount)];
    
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.accountTF becomeFirstResponder];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
}

- (NSAttributedString *)exampleAttributedString {
    NSString *str = @"名称如：上海立木或LiMu";
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange ragne1 = [str rangeOfString:@"上海立木"];
    NSRange ragne2 = [str rangeOfString:@"LiMu"];
    
    [attStr addAttributes:@{NSForegroundColorAttributeName : RGB_red} range:ragne1];
    [attStr addAttributes:@{NSForegroundColorAttributeName : RGB_red} range:ragne2];
    
    return attStr;
    
    
}


/**
 监听文本框输入
 */
- (void)textFieldTextDidChange:(NSNotification *)noti {
    if (self.accountTF.text.length == 0 || self.passWordTF.text.length == 0 || self.nameTF.text.length == 0) {
        self.commitBtn.enabled = NO;
    } else {
        self.commitBtn.enabled = YES;
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int length = 0;
    if (textField == self.accountTF) {
        length = 20;
    } else if (textField == self.passWordTF) {
         length = 16;
    } else if (textField == self.nameTF) {
        length = 20;
    }
    
    // 用string 替换 range 位置的字符串
    NSString * newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newStr.length>length) {
        return NO;
    }
    return YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}




- (void)cancelCreateChildAccount {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 是否显示密码

 */
- (IBAction)showPassWordClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        self.passWordTF.secureTextEntry = NO;
    } else {
        self.passWordTF.secureTextEntry = YES;
    }
    
}


#pragma mark---提交创建
- (IBAction)commitBtnClick:(UIButton *)sender {
    // 校验
    if (![self verificateData]) return;
    
    // 创建
    sender.enabled = NO;
    
    [self createChildAccount];
    
    
}

#pragma mark 创建子账号请求
- (void)createChildAccount {

    NSDictionary *dict = @{@"method" :      urlJK_addUserOperator,
                           @"mobile" :      kUserManagerTool.mobile,
                           @"userPwd" :     kUserManagerTool.userPwd,
                           @"appVersion":   VERSION_APP_1_4_1,
                           @"operator":self.accountTF.text,
                           @"password":self.passWordTF.text,
                           @"name":self.nameTF.text
                           };
 

    __weak typeof(self) weakSelf = self;
    
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_addUserOperator] params:dict success:^(id obj) {
        MYLog(@"创建子账号请求%@",obj);

        dispatch_async(dispatch_get_main_queue(), ^{
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
            weakSelf.commitBtn.enabled = YES;
            if ([obj[@"code"] isEqualToString:@"0000"]) {
                [weakSelf.view makeToast:@"子账号创建成功"];
                [weakSelf performSelector:@selector(dismiss) withObject:nil afterDelay:0.25];
                
            } else {
                [weakSelf.view makeToast:obj[@"msg"]];
            }
            
        });
        
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
            weakSelf.commitBtn.enabled = YES;
            [weakSelf.view makeToast:@"子账号创建失败，请重试！"];
        });
        
    }];
    
    
}


#pragma mark 校验格式
-(BOOL)verificateData
{
    // 账号
    if (![Tool validateUserName:self.accountTF.text])
    {
        [self.view makeToast:@"账号应为3-20位字符(字母、数字、下划线)" ifSucess:NO];

        return NO;
    }
    
    
    // 密码
//    if ((self.passWordTF.text.length < 6) || (self.passWordTF.text.length > 16))
//    {
//        [self.view makeToast:@"密码应为6-16位,字母、数字、下划线组合" ifSucess:NO];
//        return NO;
//    }
    
    if (![Tool validateUserPassword:self.passWordTF.text])
    {
        [self.view makeToast:@"密码应为6-16位,字母、数字、下划线组合" ifSucess:NO];
        return NO;
    }

    
    
    // 名称
    if ((self.nameTF.text.length < 3) || (self.nameTF.text.length > 20))
    {
        [self.view makeToast:@"名称应为3-20位字符" ifSucess:NO];
        return NO;
    }

    return YES;
}




- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end
