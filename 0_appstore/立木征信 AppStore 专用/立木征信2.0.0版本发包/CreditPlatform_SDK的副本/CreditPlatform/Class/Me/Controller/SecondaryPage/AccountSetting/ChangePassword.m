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
@property (weak, nonatomic) IBOutlet UIButton *sure;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置登录密码";
    self.view.backgroundColor = RGB_pageBackground;
    self.sure.layer.cornerRadius = 2;
    self.sure.layer.masksToBounds = YES;
    self.sure.enabled = NO;
    [self.sure setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
    [self.sure setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    [self.sure setTitleColor:RGB_white forState:UIControlStateNormal];
    [self.sure setTitleColor:RGB_white forState:UIControlStateHighlighted];
    // 监听输入文本变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextFieldTextDidChangeNotification object:_newmm];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextFieldTextDidChangeNotification object:_oldmm];
    
    [self configUI];
    
}
- (void)textViewTextDidChange:(NSNotification *)noti {
    if (_newmm.text.length == 0 || _oldmm.text.length == 0) {
        _sure.enabled = NO;
    } else {
        _sure.enabled = YES;
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
}
- (void)configUI {
    
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



#pragma mark - 开始登陆
- (void)sendNetWorking {
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_modifyPwd,
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
                [sself performSelector:@selector(outself) withObject:nil afterDelay:errorDelay];
                
            }else{//无数据
                [sself.view makeToast:[NSString stringWithFormat:@"%@",[responseObj objectForKey:@"msg"]]];
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


- (void)outself{
   
    LoginVC *login = [[LoginVC alloc]init];
//    login.isFrom = 102;
    YJNavigationController *ll =[[YJNavigationController alloc]initWithRootViewController:login];
    [self presentViewController:ll animated:YES completion:nil];
    [self performSelector:@selector(outt) withObject:nil afterDelay:0.5];
}
-(void)outt{
     [self.navigationController popToRootViewControllerAnimated:NO];
}
#pragma mark 确认
- (IBAction)sureClicked {
    if (![self verificateData]) {
        return;
    }
    [self.view endEditing:YES];
    [self sendNetWorking];
    
    
    
}
//校验格式
#pragma mark 校验格式
//校验格式
-(BOOL)verificateData
{
    
    if ((_oldmm.text == nil)||[_oldmm.text isEqualToString:@""])
    {
        [self.view makeToast:@"请输入旧密码" ifSucess:NO];
        return NO;
    }
    if (([_oldmm.text length]<6) || ([_oldmm.text length]>16))
    {
        [self.view makeToast:@"密码应为6-16位,字母,数字,下划线组合" ifSucess:NO];
        return NO;
    }
    
    if ((_newmm.text == nil)||[_newmm.text isEqualToString:@""])
    {
        [self.view makeToast:@"请输入新密码"ifSucess:NO];
        return NO;
    }
    if (([_newmm.text length]<6) || ([_newmm.text length]>16))
    {
        [self.view makeToast:@"密码应为6-16位,字母,数字,下划线组合" ifSucess:NO];
        return NO;
    }
    if (![Tool validatePassword:_newmm.text]) {
        [self.view makeToast:@"密码应为6-16位,字母,数字,下划线组合"];
        return NO;
    }
    
    return YES;
}
#pragma mark - 网络

#pragma mark - 其他
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
#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
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
