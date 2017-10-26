//
//  LoseLoginThree.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/20.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "ChangePhoneNum.h"
#import "LoginVC.h"

#define LoginYZMGetSMS_NetWoring @"LoginYZMGetSMS_NetWoring"
#define LoginYZMTestSMS_NetWoring @"LoginYZMTestSMS_NetWoring"
@interface ChangePhoneNum ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sure;
- (IBAction)sureClicked;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *myNum;

@property (weak, nonatomic) IBOutlet UIButton *get;
- (IBAction)getClicked;

@property (assign, nonatomic) NSInteger num;

@property (strong, nonatomic) NSTimer *timer;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h1;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h2;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getH;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getW;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation ChangePhoneNum
{
    BOOL _isOK;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更换手机号";
    self.num = 60;
    self.view.backgroundColor = RGB_gray;
    self.sure.layer.cornerRadius = 2;
    self.sure.layer.masksToBounds = YES;
    self.sure.enabled = NO;
    [self.sure setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
    [self.sure setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    [self.sure setTitleColor:RGB_white forState:UIControlStateNormal];
    [self.sure setTitleColor:RGB_white forState:UIControlStateHighlighted];
    
    
    [self configUI];
    _phone.textColor = [UIColor blackColor];
//    self.h1.constant = 50.0;
//    self.h2.constant = 35.0;
//    self.getH.constant = 30;
//    self.getW.constant = 60;
    if(self.from == 2){
        _phone.placeholder = @"请输入新手机号";
        _phone.enabled = YES;
        _phone.userInteractionEnabled =YES;
        _phoneLabel.text = @"新手机";
        [_sure setTitle:@"确认修改" forState:UIControlStateNormal];
    }else{
        _phone.text = kUserManagerTool.mobile;
        _myNum.keyboardType = UIKeyboardTypeNumberPad;
        _phone.enabled = NO;
        _phoneLabel.text = @"原手机号";
        [_sure setTitle:@"下一步" forState:UIControlStateNormal];
        
    }
    
    
    
    // 监听输入文本变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextFieldTextDidChangeNotification object:_phone];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextFieldTextDidChangeNotification object:_myNum];
}

- (void)textViewTextDidChange:(NSNotification *)noti {
    if (_phone.text.length == 0 || _myNum.text.length == 0) {
        _sure.enabled = NO;
    } else {
        _sure.enabled = YES;
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    CGRect origin = _sure.bounds;
    _phone.textColor = [UIColor blackColor];
//    _sure.bounds = CGRectMake(origin.origin.x, origin.origin.y
//                              , origin.size.width, 145);
 
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
}

- (void)configUI {
    UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
    item.title = @"";
    [item setTintColor:RGB_gray];
    
    _get.layer.cornerRadius = 2.0;
    _get.layer.borderWidth = .5;
    _get.layer.masksToBounds = YES;
//    [_get setBackgroundColor:RGB_red];
    [_get setTitle:@"获取验证码" forState:UIControlStateNormal];
    _get.titleLabel.font = JFont(11);
    
    self.get.layer.borderColor = RGB_grayNormalText.CGColor;
    [self.get setTitleColor:RGB_black forState:(UIControlStateNormal)];
}
#pragma mark - 网络
#pragma mark 获取验证码
- (void)sendNetWorking {
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_sendMobileCode,
                               @"mobile" : _phone.text,
                               @"modelCode" : APP_UDMOBLILE_AUTHCODE};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
   sself.get.userInteractionEnabled = NO;
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_sendMobileCode] params:dicParams success:^(id responseObj) {
        MYLog(@"修改手机号%@",responseObj);
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            [sself.view makeToast:@"发送成功"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                sself.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self selector:@selector(beginCount:) userInfo:nil repeats:YES];
//                sself.get.userInteractionEnabled = NO;
                sself.get.layer.borderColor = RGB_grayLine.CGColor;
                [sself.get setTitleColor:RGB_grayNormalText forState:(UIControlStateNormal)];
            });
            
        }else {
            [sself.view makeToast:responseObj[@"msg"]];
            sself.get.userInteractionEnabled = YES ;

        }
        
    } failure:^(NSError *error) {
        sself.get.userInteractionEnabled = YES ;
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:errorInfo];
    }];
    
}


#pragma mark 下一步
- (IBAction)sureClicked{
    [self.view endEditing:YES];
    
    if ([self verificateData]) {
        if (self.from == 2) {
            [self NEXT];//一次验证
        } else {
            [self checkYZM];
        }
    }
}

/////////////
// 修改手机号后不退出登录.
//
////////


- (void)NEXT {
    __block typeof(self) sself = self;
    if (self.from == 2) {// 新的
        if (!_isOK) {
            [self.view makeToast:@"手机号已经注册"];
            return;
        }
        NSDictionary *dicParams =@{@"method" : urlJK_modifyMobile,
                                   @"mobile" : kUserManagerTool.mobile,
                                   @"userPwd" : kUserManagerTool.userPwd,
                                   @"newMobile" : _phone.text,
                                   @"phoneCode" : _myNum.text,
                                   @"modelCode" : APP_UDMOBLILE_AUTHCODE};
        
        [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_modifyMobile] params:dicParams success:^(id responseObj) {
            MYLog(@"修改手机号%@",responseObj);
            [YJShortLoadingView yj_hideToastActivityInView:sself.view];
            
            if ([responseObj[@"code"] isEqualToString:@"0000"]) {
                [sself.view makeToast:@"修改成功"];
                [YJUserManagerTool clearUserInfo];
                [sself performSelector:@selector(outselfW) withObject:nil afterDelay:2.0];
            }else {
                [sself.view makeToast:responseObj[@"msg"]];
            }
            
        } failure:^(NSError *error) {
            [YJShortLoadingView yj_hideToastActivityInView:sself.view];
            [sself.view makeToast:errorInfo];
        }];
        
     }else{// 旧的
        ChangePhoneNum *c = [[ChangePhoneNum alloc]init];
        c.from = 2;
        [self.navigationController pushViewController:c animated:YES];
    }
}

- (void)outselfW{
    LoginVC *login = [[LoginVC alloc]init];
    //    login.isFrom = 102;
    YJNavigationController *ll =[[YJNavigationController alloc]initWithRootViewController:login];
    [self presentViewController:ll animated:YES completion:nil];
    [self performSelector:@selector(outt) withObject:nil afterDelay:0.5];
}
-(void)outt{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark 校验手机号
-(void)checkMobile {
     __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_checkUserNameRegister,
                               @"mobile" : _phone.text};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[SERVE_URL stringByAppendingString: urlJK_checkUserNameRegister] params:dicParams success:^(id responseObj) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {//没有注册：OK
            [sself.view makeToast:@"手机号尚未注册"];
            _isOK = YES;
        }else{//已经注册： 不行
            [sself.view makeToast:@"手机号已经注册"];
        }
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        [sself.view makeToast:errorInfo];
    }];
    
}



#pragma mark - 校验验证码
-(void)checkYZM{
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_checkMobileCode,
                               @"mobile" : _phone.text,
                               @"phoneCode":_myNum.text,
                               @"modelCode":APP_UDMOBLILE_AUTHCODE};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[SERVE_URL stringByAppendingString: urlJK_checkMobileCode] params:dicParams success:^(id responseObj) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            [sself NEXT];
        }else{
            [sself.view makeToast:responseObj[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        [sself.view makeToast:errorInfo];
    }];
    
}

#pragma mark 动作- 获取验证码
- (IBAction)getClicked {
    [self.view endEditing:YES];
    if (![self verificate]) {
        return;
    };
    [self sendNetWorking];
    
    
}
#pragma mark 校验格式
-(BOOL)verificateData
{
    if ((_phone.text == nil)|[_phone.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入手机号" ifSucess:NO];
        return NO;
    }
    if (![Tool validateMobile:_phone.text]) {
        [self.view makeToast:@"请输入正确的手机号" ifSucess:NO];
        return NO;
    }
    if ((_myNum.text == nil)||[_myNum.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入验证码" ifSucess:NO];
        return NO;
    }
    
    
    return YES;
}
-(BOOL)verificate
{
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
- (void)beginCount:(NSTimer *)timer {
    self.num --;
    
    [self.get setTitle:[NSString stringWithFormat:@"%lds",self.num] forState:UIControlStateNormal];
    if (self.num==0) {
        self.get.userInteractionEnabled= YES;
        [self.get setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.get.layer.borderColor = RGB_grayNormalText.CGColor;
        [self.get setTitleColor:RGB_black forState:(UIControlStateNormal)];
        [self.timer invalidate];
        self.timer =nil;
        self.num=60;
        return;
    }
}

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

#pragma mark - 文本框代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (self.from == 2  && textField.tag == 77) {
        //粘贴，有空格
        NSRange rang = [string rangeOfString:@" "];
        if (rang.length >= 1 &&string.length>11) {
            string = [string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            _myNum.text = string;
            [self checkMobile];
            return NO;
        }
        
        if (!string.length) {
            return YES;
        }
        
        if (string.length == 11) {
            [self performSelector:@selector(checkMobile) withObject:nil afterDelay:0.5];
            return YES;
        }
        
        
        if (textField.text.length>9) {
            textField.text = [textField.text stringByAppendingString:string];
            [self checkMobile];
            [self.view endEditing:YES];
            
            return YES;
        }
    }
   
    return YES;
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
