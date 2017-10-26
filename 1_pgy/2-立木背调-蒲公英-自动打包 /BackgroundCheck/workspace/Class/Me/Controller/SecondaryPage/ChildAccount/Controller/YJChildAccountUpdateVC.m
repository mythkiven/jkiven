//
//  YJChildAccountUpdateVC.m
//  CreditPlatform
//
//  Created by yj on 2016/11/10.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJChildAccountUpdateVC.h"
#import "YJChildAccountListModel.h"
@interface YJChildAccountUpdateVC ()
{
    NSString *_tipString;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UITextField *updateTF;
@property (weak, nonatomic) IBOutlet UILabel *exampleLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *exampleLbHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *updateTfTrailing;
@property (weak, nonatomic) IBOutlet UIButton *eyeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation YJChildAccountUpdateVC
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.optionName;
    
    
    if ([self.optionName isEqualToString:@"修改名称"]) {
        self.titleLB.text = @"名称";
        self.updateTF.secureTextEntry = NO;
        self.updateTF.placeholder = @"3-20位字符";
        self.eyeBtn.hidden = YES;
        self.updateTfTrailing.constant = 15;
        self.exampleLbHeight.constant = 21;
        self.exampleLB.attributedText = [self exampleAttributedString];
        
    } else if ([self.optionName isEqualToString:@"修改密码"]) {
        self.titleLB.text = @"密码";
        self.updateTF.secureTextEntry = YES;
        self.updateTF.placeholder = @"6-16位,字母,数字,下划线组合";
        self.eyeBtn.hidden = NO;
         self.updateTfTrailing.constant = 22 + 30;
        self.exampleLbHeight.constant = 0;
        self.exampleLB.textColor = RGB_pageBackground;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancelUpdateChildAccount)];
    
    
    // 禁用 返回手势
    self.rt_disableInteractivePop = YES;

}

- (void)cancelUpdateChildAccount {

    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.updateTF becomeFirstResponder];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (void)textFieldTextDidChange:(NSNotification *)noti {
    
    if (self.updateTF.text.length == 0) {
        self.commitBtn.enabled = NO;
        
    } else {
        self.commitBtn.enabled = YES;
        
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int length = 0;
    
    if ([self.optionName isEqualToString:@"修改名称"]) {
        length = 20;
    } else if ([self.optionName isEqualToString:@"修改密码"]) {
       length = 16;
    }
    
    // 用string 替换 range 位置的字符串
    NSString * newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newStr.length>length) {
        return NO;
    }
    return YES;
    
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


- (IBAction)commitBtnClick:(UIButton *)sender {

    
    self.navigationItem.leftBarButtonItem.enabled = NO;

    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:
                                  @{@"method" :      urlJK_updateUserOperator,
                                    @"mobile" :      kUserManagerTool.mobile,
                                    @"userPwd" :     kUserManagerTool.userPwd,
                                    @"appVersion":   VERSION_APP_1_4_1,
                                    @"id":self.childAccountModel.id
                                    }];
    
    if ([self.optionName isEqualToString:@"修改名称"]) {
        // 校验名称
        if ((self.updateTF.text.length < 3) || (self.updateTF.text.length > 20))
        {
            [self.view makeToast:@"名称应为3-20位字符" ifSucess:NO];
            
            return;
        }
        
        [dict setObject:@"2" forKey:@"type"];
        [dict setObject:self.updateTF.text forKey:@"name"];
        [dict setObject:@"" forKey:@"password"];
        
       

        
    } else if ([self.optionName isEqualToString:@"修改密码"]) {
        // 校验密码
        if (![Tool validateUserPassword:self.updateTF.text])
        {
            [self.view makeToast:@"密码应为6-16位,字母,数字,下划线组合" ifSucess:NO];
            return;
        }
        
        [dict setObject:@"1" forKey:@"type"];
        [dict setObject:@"" forKey:@"name"];
        [dict setObject:self.updateTF.text forKey:@"password"];
        
        
        

    }
    
    // 提交修改
    [self updateUserOperatorWithDict:dict];
    
}
#pragma mark--提交修改
- (void)updateUserOperatorWithDict:(NSDictionary *)dict {
    
    // type 1：修改密码；2：修改名称
    __weak typeof(self) weakSelf = self;
    
    
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_updateUserOperator] params:dict success:^(id obj) {
        MYLog(@"修改子账号请求%@",obj);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.leftBarButtonItem.enabled = YES;

            
            if ([obj[@"code"] isEqualToString:@"0000"]) {
                
                if ([weakSelf.optionName isEqualToString:@"修改名称"]) {
                    
                    [weakSelf.view makeToast:@"子账号名称修改成功"];

                    weakSelf.updateNameSuccess(weakSelf.updateTF.text);
                } else {
                    
                    [weakSelf.view makeToast:@"子账号密码修改成功"];
                    weakSelf.updatePasswordSuccess(weakSelf.updateTF.text);
                    
                }
                
                
                [weakSelf performSelector:@selector(dismis) withObject:nil afterDelay:0.25];
                
            } else {
                [weakSelf.view makeToast:obj[@"msg"]];
            }
            
            
            
        });
        
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.leftBarButtonItem.enabled = YES;

            [weakSelf.view makeToast:@"子账号修改失败，请重试！"];
        });
        
    }];
    
}


- (void)dismis {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



/**
 是否显示密码
 
 */
- (IBAction)showPassWordClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        self.updateTF.secureTextEntry = NO;
    } else {
        self.updateTF.secureTextEntry = YES;
    }
    
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
