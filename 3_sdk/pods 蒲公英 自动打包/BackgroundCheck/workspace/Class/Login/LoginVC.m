//
//  LoginVC.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/25.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "YJRecordViewController.h"
#import "LoginVC.h"
#import "YJHTTPTool.h"
#import "ForgetPassword.h"
#import "LoginRegister.h"
//#import "LoginNewAccountPhone.h"
#import "YJSearchViewController.h"
#import "YJTabBarController.h"

#import "AppDelegate.h"
#import "YJCompanyDetailManager.h"
#import "PDKeyChain.h"

#import "JENavigationController.h"
@interface LoginVC ()<UITextFieldDelegate,UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UIView *mid2view;

@property (weak, nonatomic) IBOutlet UIButton *eye;

@property (copy, nonatomic)  NSString *phoneNum;


//登录
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CtopH;

//@property (weak, nonatomic) IBOutlet UILabel *detail;

- (IBAction)clickedLogin;
- (IBAction)clickedMiss;
- (IBAction)clickedNew;



@end


@implementation LoginVC
{
    //展示YES 未展示NO
    BOOL showSelf_;
}
- (void)awakeFromNib {
    [super awakeFromNib];
      
}

#pragma mark - 生命周期
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (iPhone5 || iPhone4s) {
        _CtopH.constant = 180;
    } else if (iPhone6) {
        _CtopH.constant = 200;
    }else if (iPhone6P) {
        _CtopH.constant = 200;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.password.delegate = self;
    self.phone.delegate = self;
    
    self.loginbtn.enabled = NO;
    self.loginbtn.layer.cornerRadius = 2.0;
    self.loginbtn.layer.masksToBounds = YES;
     [self.loginbtn setBackgroundImage:[UIImage imageWithColor:[UIColor  colorWithHexString:@"#39b31b"]] forState:(UIControlStateNormal)];
    [self.loginbtn setBackgroundImage:[UIImage imageWithColor:[UIColor  colorWithHexString:@"#39b31b"]] forState:(UIControlStateHighlighted)];
//    [self.loginbtn setBackgroundImage:[UIImage imageWithColor:RGBA(57, 179, 27, 0.3)] forState:(UIControlStateDisabled)];
    
    
    [self.registerBtn setBackgroundColor:[UIColor  whiteColor]];
    [self.registerBtn setTitleColor:[UIColor colorWithHexString:@"#39b31b"] forState:UIControlStateNormal];
    self.registerBtn.layer.cornerRadius = 2.0;
    self.registerBtn.layer.masksToBounds = YES;
    [self.registerBtn.layer setBorderWidth:1.0];
    [self.registerBtn.layer setBorderColor:[UIColor  colorWithHexString:@"#60c148"].CGColor];
    
    [self.eye setBackgroundImage:[UIImage imageNamed:@"login_icon_eye_disable"] forState:UIControlStateNormal];
    [self.eye setBackgroundImage:[UIImage imageNamed:@"login_icon_eye_enable"] forState:UIControlStateSelected];
    
    self.phoneNum = [[NSUserDefaults standardUserDefaults] objectForKey:iphoneSave];
    self.phone.text = [self.phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
     
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // 监听:
    [_phone addTarget:self action:@selector(textFieldDidEndEditingP:) forControlEvents:UIControlEventEditingChanged];
    [_password addTarget:self action:@selector(textFieldDidEndEditingD:) forControlEvents:UIControlEventEditingChanged]; 
   // 返回按钮
    // self.navigationItem.leftBarButtonItem = [UIBarButtonItem loginBackBarButtonItemtarget:self action:@selector(dismiss)];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]];
    self.navigationController.navigationBar.translucent =YES;
    self.navigationController.navigationBar.alpha = 0;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
//    // 返回按钮
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self.navigationController setNavigationBarHidden:false animated:false];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [self.navigationController.navigationBar setTranslucent:false];
//    [self.navigationController.view setBackgroundColor:[UIColor clearColor]];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
 
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:iphoneSave]) {
        self.phoneNum = [[NSUserDefaults standardUserDefaults] objectForKey:iphoneSave];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    showSelf_ = YES;
    if (self.phone.text.length) {
        [self.password becomeFirstResponder];
    } else {
        [self.phone becomeFirstResponder];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];

    showSelf_ =NO;
}

-(void)textFieldDidEndEditingP:(UITextField*)textFiled{
    [self setBtnStatus];
}
-(void)textFieldDidEndEditingD:(UITextField*)textFiled{
    [self setBtnStatus];
}
-(void)setBtnStatus{
    if(self.phone.text.length==11+2&&self.password.text.length>5) {
        self.loginbtn.enabled = YES;
        [self.registerBtn setBackgroundColor:[UIColor colorWithHexString:@"#eefaeb"]];
    }else if(self.phone.text.length==11&&[self.phone.text hasStr:@"****"] &&self.password.text.length>5) {
        self.loginbtn.enabled = YES;
        [self.registerBtn setBackgroundColor:[UIColor colorWithHexString:@"#eefaeb"]];
    }else{
        self.loginbtn.enabled = NO;
        [self.registerBtn setBackgroundColor:[UIColor whiteColor]];
    }
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    [self performSelector:@selector(setBtnStatus) withObject:nil afterDelay:0.3];
    return YES;
}
#pragma mark - 开始登陆
- (void)sendNetWorking {
    __weak typeof(self) sself = self;
    // 登录输入密码，使用MD5加密，其余在保存时已经MD5
    NSDictionary *dicParams =@{@"method" : urlJK_login,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" : [self getPhoneNum],
                               @"userPwd": [self base64Encode: _password.text],
                               @"deviceNum":[PDKeyChain loadUniqueIDInKeyChain],};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];

    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_login] params:dicParams success:^(id responseObj) {
        // 用于保证只会弹出一个登录页面,防止多次弹出
        [Tool setBool:NO forKey:baozheng_duoci_qingqiu_meici_tanchu_yige_yemian];
        MYLog(@"登录数据请求成功：%@",responseObj);
        NSDictionary *list = [responseObj objectForKey:@"data"];
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            if (![list isKindOfClass:[NSNull class]]) {//有数据
                
                // cookie 处理:
                [self getAndSaveCookie];
                
                // 用户信息本地化
                [YJUserManagerTool clearUserInfo];
                YJUserModel *user = [YJUserModel mj_objectWithKeyValues:list];
                user.login = YES;
                
                MYLog(@"%@",[YJUserManagerTool user].apiKey);
                
                // 密码存空值,传空值
                // user.userPwd =_password.text;
                user.userPwd =@" ";
                //user.authStatus = user.authQualifyFlag;
                [YJUserManagerTool saveUser:user];
                [[NSUserDefaults standardUserDefaults]  setObject:user.mobile forKey:iphoneSave];
                [[NSUserDefaults standardUserDefaults]  synchronize];
                
                MYLog(@"%@",[YJUserManagerTool user].apiKey);
                
                [[NSNotificationCenter defaultCenter] postNotificationName:YJNotificationUserLogin object:nil];
                
                [sself getCompanyInfoFromNet];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [sself dismissViewControllerAnimated:YES completion:nil];
                });
                
            }else{//无数据
                dispatch_async(dispatch_get_main_queue(), ^{
                    [sself.view makeToast:responseObj[@"msg"]];
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [sself.view makeToast:responseObj[@"msg"]];
            });
        }

    } failure:^(NSError *error) {
        // 用于保证只会弹出一个登录页面,防止多次弹出
        [Tool setBool:NO forKey:baozheng_duoci_qingqiu_meici_tanchu_yige_yemian];
        MYLog(@"---------%@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJShortLoadingView yj_hideToastActivityInView:sself.view];
            [sself.view makeToast:errorInfo];
        });
    }];
}

- (void)getCompanyInfoFromNet {
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        
        // 提交企业认证后，企业详情接口
        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_queryMember,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd
                               };
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryMember] params:dict success:^(id responseObj) {
            
            //"status": "00" // 00-待审核 20-审核成功 99-审核失败
            
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                MYLog(@"企业认证---%@",responseObj[@"data"]);
                CompanyDetailModel *companyDetailModel = [CompanyDetailModel mj_objectWithKeyValues:responseObj[@"data"]];
                [YJCompanyDetailManager saveCompanyInfo:companyDetailModel];

                
                NSLog(@"%@",[YJUserManagerTool user].apiKey);
                
                
                YJUserModel *user = [YJUserManagerTool user];
                user.authStatus = companyDetailModel.status;
                [YJUserManagerTool saveUser:user];
                
            } else{
                MYLog(@"企业未认证---%@",responseObj[@"data"]);
                YJUserModel *user = [YJUserManagerTool user];
                user.authStatus = @"0";
                [YJUserManagerTool saveUser:user];
            }
        } failure:^(NSError *error) {
            
            MYLog(@"企业认证详情请求失败---%@",error);
            
        }];
    }
    
}

#pragma mark -
#pragma mark - 获取并保存cookie到userDefaults
- (void)getAndSaveCookie
{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *tempCookie in cookies) {
        NSLog(@"getCookie: %@", tempCookie);
    }
    /*
     * 把cookie进行归档并转换为NSData类型
     * 注意：cookie不能直接转换为NSData类型，否则会引起崩溃。
     * 所以先进行归档处理，再转换为Data
     */
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    [Tool  setObject: cookiesData forKey: cookie_session_login_lmzx];
    
    [self deleteCookie];
    
    [self setCoookie];
    
}

#pragma mark 删除cookie
- (void)deleteCookie {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    //删除cookie
    for (NSHTTPCookie *tempCookie in cookies) {
        [cookieStorage deleteCookie:tempCookie];
    }
}

#pragma mark 再取出保存的cookie,并重新设置
- (void)setCoookie{
    //取出保存的cookie
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //对取出的cookie进行反归档处理
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:cookie_session_login_lmzx]];
    if (cookies) {
        //设置cookie
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (id cookie in cookies) {
            [cookieStorage setCookie:(NSHTTPCookie *)cookie];
        }
    }else{
        NSLog(@"无cookie");
    }
    
}


#pragma mark -
#pragma mark - 交互
#pragma mark 显示密码
- (IBAction)showPassword:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.password.secureTextEntry = !sender.selected;
}
#pragma mark 忘记密码
- (IBAction)clickedMiss {
    ForgetPassword *f = [[ForgetPassword alloc] init];
    f.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:f  animated:YES];
}
#pragma mark 登录
- (IBAction)clickedLogin {
     [self.view endEditing:YES];
    
    if (![self verificateData]) {
        return;
    };
    [self sendNetWorking];
}
#pragma mark 注册新用户
- (IBAction)clickedNew {
    LoginRegister  *f = [[LoginRegister alloc] init];
    f.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:f animated:YES
     ];
}
#pragma mark 校验格式
-(BOOL)verificateData {
    
    if ((_phone.text == nil)|[_phone.text isEqualToString:@""]|(_phone.text.length<1)) {
        [self.view makeToast:@"手机号码不能为空" ifSucess:NO];
        return NO;
    }
    if (![Tool validateMobile:[self getPhoneNum]]) {
        [self.view makeToast:@"手机号码格式错误" ifSucess:NO];
        return NO;
    }
    if ((_password.text == nil)||[_password.text isEqualToString:@""]) {
        [self.view makeToast:@"密码不能为空" ifSucess:NO];
        return NO;
    }
    if (([_password.text length]<6) || ([_password.text length]>16))  {
        [self.view makeToast:@"密码长度6-16位,字母、数字和下划线至少两种的组合" ifSucess:NO];
        return NO;
    }
    if (![Tool validateUserPassword:_password.text]) {
        [self.view makeToast:@"密码长度6-16位,字母、数字和下划线至少两种的组合"];
        return NO;
    } 
    
    return YES;
}

/**
 *  返回不带****的号码
 */
- (NSString *)getPhoneNum {
    NSString *phoneStr = [self.phone.text cutAllSpace];
    if (phoneStr.length<=10) {
        return phoneStr;
    }
    if ([[phoneStr substringWithRange:NSMakeRange(3, 4)] isEqualToString:@"****"]) {
        if ([[phoneStr substringFromIndex:7] isEqualToString:[self.phoneNum substringFromIndex:7]]) {
            phoneStr = self.phoneNum;
        } 
    }
    return phoneStr;
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
    } else if (textField == _password) {
        length = 16;
    }
    if (textField.text.length > length-1) {
        // 用string 替换 range 位置的字符串
        NSString * newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (newStr.length>length) {
            return NO;
        }
    }
    return YES;
}
 



#pragma mark  -
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)keyboardWillChangeFrame:(NSNotification *)note{
    if (!showSelf_) {
        return;
    }
    
    CGFloat duartion = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = keyboardFrame.origin.y;
    __block CGFloat transfromY ;
    __block typeof(self) sself = self;
    if(iPhone4s){ // 246   480  264
        
        //        if (y <= 268) {
        if (460 > y) {
            transfromY =  -110;
        }else if(240 <= y && y<460){
            transfromY =  0;
        }
        [UIView animateWithDuration:duartion animations:^{
            sself.view.transform = CGAffineTransformMakeTranslation(0, transfromY);
        }];
    }
    if (iPhone5) {//568 352
        if (y <= 768) {
            if (500 > y) {
                transfromY =  -120;
            }else if(500 <= y && y<768){
                transfromY =  0;
            }
            [UIView animateWithDuration:duartion animations:^{
                self.view.transform = CGAffineTransformMakeTranslation(0, transfromY);
            }];
        }
    }
    
    if (iPhone6) {//568 352
        if (y <= 768) {
            if (500 > y) {
                transfromY =  -50;
            }else if(500 <= y && y<768){
                transfromY =  0;
            }
            [UIView animateWithDuration:duartion animations:^{
                self.view.transform = CGAffineTransformMakeTranslation(0, transfromY);
            }];
        }
    }
}

- (IBAction)clickedImg:(UIButton *)sender {
}
@end
