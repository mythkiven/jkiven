//
//  LoginMima.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/20.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "ChangePassword.h"
#import "LoginVC.h"
@interface ChangePassword ()<UITextFieldDelegate>
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h1;
//@property (weak, nonatomic) IBOutlet UITextField *newPhone;
@property (weak, nonatomic) IBOutlet JEConfirmButton *sure;
- (IBAction)sureClicked;
@property (weak, nonatomic) IBOutlet UIButton *seeBtn;
@property (weak, nonatomic) IBOutlet UIButton *seeBtn2;
@property (weak, nonatomic) IBOutlet UITextField *newmm;
@property (weak, nonatomic) IBOutlet UITextField *oldmm;

@end

@implementation ChangePassword
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置登录密码";
    self.view.backgroundColor = RGB_pageBackground;
    
    // 监听输入文本变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextFieldTextDidChangeNotification object:_newmm];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextFieldTextDidChangeNotification object:_oldmm];
    [_sure loadConfigEnable:NO];
    
}
- (void)textViewTextDidChange:(NSNotification *)noti {
    if (_newmm.text.length >=6 && _oldmm.text.length >=6) {
        [_sure setCanClicked:YES];
    } else {
         [_sure setCanClicked:NO];
    }
    
}



#pragma mark - 开始登陆
- (void)sendNetWorking {
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_modifyPwd,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : [self base64Encode:_oldmm.text],
                               @"newUserPwd" : [self base64Encode: _newmm.text]};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_modifyPwd] params:dicParams success:^(id responseObj) {
        MYLog(@"根据原始密码-修改密码%@",responseObj);
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
            if ([responseObj[@"code"] isEqualToString:@"0000"]) {
                [sself.view makeToast:@"修改成功"];
                [YJUserManagerTool clearUserInfo];
                
            }else{//无数据
                [sself.view makeToast:[NSString stringWithFormat:@"%@",[responseObj objectForKey:@"msg"]]];
            }
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:errorInfo];
    }];
    
}

#pragma mark - 交互
- (IBAction)sureClicked {
    if (![self verificateOldPassword:_oldmm newPassword:_newmm]) {
        return;
    }
    [self.view endEditing:YES];
    [self sendNetWorking];
}
#pragma mark 查看密码 11上 22下
- (IBAction)clickedSee:(UIButton *)sender {
    if (sender.tag ==11) {
        [self.oldmm setFont:nil];
        [self.oldmm setFont:Font15];
        _seeBtn.selected =!_seeBtn.selected;
        _oldmm.secureTextEntry = !_oldmm.secureTextEntry;
    }else if ( sender.tag == 22){
        [self.newmm setFont:nil];
        [self.newmm setFont:Font15];
        _seeBtn2.selected =!_seeBtn2.selected;
        _newmm.secureTextEntry = !_newmm.secureTextEntry;
    }
    
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
