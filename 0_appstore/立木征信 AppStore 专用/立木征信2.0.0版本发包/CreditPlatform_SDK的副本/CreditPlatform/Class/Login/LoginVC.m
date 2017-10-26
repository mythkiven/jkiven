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
#import "FindLoseLoginPhone.h"
//#import "LoginNewAccountO.h"
#import "LoginNewAccountPhone.h"
#import "YJSearchViewController.h"
#import "YJTabBarController.h"

#import "YJTabBar.h"
#import "YJButton.h"

#import "AppDelegate.h"
#import "YJCompanyDetailManager.h"
#import "PDKeyChain.h"
//#import "MainTabbarController.h"
//#import "PasswordGestureViewController.h"
//extern WDCAccount *g_account;

@interface LoginVC ()<UITextFieldDelegate,UIAlertViewDelegate>
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewH;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topH;//84 5s

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (copy, nonatomic)  NSString *phoneNum;


@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UIView *mid2view;

//登录
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CtopH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgW;

@property (weak, nonatomic) IBOutlet UILabel *detail;

- (IBAction)clickedLogin;
- (IBAction)clickedMiss;
- (IBAction)clickedNew;
@property (weak, nonatomic) IBOutlet UIButton *userImg;
- (IBAction)clickedImg:(UIButton *)sender;



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
        _CtopH.constant = 162;
        _imgH.constant = 98;
        _imgW.constant = 98;
    } else if (iPhone6) {
        _CtopH.constant = 190;
        _imgH.constant = 125;
        _imgW.constant = 125;
    }else if (iPhone6P) {
        _CtopH.constant = 210;
        _imgH.constant = 172.5;
        _imgW.constant = 172.5;
    }
    self.view.backgroundColor = RGB_pageBackground;
    self.mima.delegate = self;
    self.phone.delegate = self;
    
    
    self.navigationItem.title = @"登录";
    self.loginbtn.layer.cornerRadius = 2.0;
    self.loginbtn.layer.masksToBounds = YES;
    
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
    item.title = @"";
    [item setTintColor:RGB_gray];
    self.navigationItem.backBarButtonItem = item;
    
    
////    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
//    
//    
//    // 隐藏返回按钮: 新版需求
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemtarget:self action:@selector(backK)];


    
    self.phoneNum = [[NSUserDefaults standardUserDefaults] objectForKey:iphoneSave];
    
    self.phone.text = [self.phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
//    self.phone.text = self.phoneNum;
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:iphoneSave]) {
        self.phoneNum = [[NSUserDefaults standardUserDefaults] objectForKey:iphoneSave];
    }
    
//    self.navigationController.navigationBar.shadowImage =[UIImage imageWithColor:RGB(115, 115, 115)];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    showSelf_ = YES;
    
    if (self.phone.text.length) {
        [self.mima becomeFirstResponder];
    } else {
        [self.phone becomeFirstResponder];
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    showSelf_ =NO;
}
- (NSString *)base64Encode:(NSString *)string {
    NSData *nsdata = [string
                      dataUsingEncoding:NSUTF8StringEncoding];
    return [nsdata base64EncodedStringWithOptions:0];
}

#pragma mark - 开始登陆
- (void)sendNetWorking {
    
    __weak typeof(self) sself = self;
    // 登录输入密码，使用MD5加密，其余在保存时已经MD5
    NSDictionary *dicParams =@{@"method" : urlJK_login,
                               @"mobile" : [self getPhoneNum],
                               @"userPwd": [self base64Encode: _mima.text],
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
//                user.authStatus = @"20";
                
                NSLog(@"%@",[YJUserManagerTool user].apiKey);
                
                // 密码存空值,传空值
                // user.userPwd =_mima.text;
                user.userPwd =@" ";
                //user.authStatus = user.authQualifyFlag;
                [YJUserManagerTool saveUser:user];
                [[NSUserDefaults standardUserDefaults]  setObject:user.mobile forKey:iphoneSave];
                [[NSUserDefaults standardUserDefaults]  synchronize];
                
                
                NSLog(@"%@",[YJUserManagerTool user].apiKey);
                
                //kUserManagerTool [YJUserManagerTool user]
                
                [[NSNotificationCenter defaultCenter] postNotificationName:YJNotificationUserLogin object:nil];
                
                [sself getCompanyInfoFromNet];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [sself dismissViewControllerAnimated:YES completion:nil];
                });
                

            }else{//无数据
                dispatch_async(dispatch_get_main_queue(), ^{
                    [sself.view makeToast:responseObj[@"msg"]];
                });
//                [self performSelector:@selector(selfOut) withObject:nil afterDelay:2];
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [sself.view makeToast:responseObj[@"msg"]];
            });
//            [self performSelector:@selector(selfOut) withObject:nil afterDelay:2];
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
#pragma mark 忘记密码
- (IBAction)clickedMiss {
    FindLoseLoginPhone *f = [[FindLoseLoginPhone alloc] init];
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
    LoginNewAccountPhone *l = [[LoginNewAccountPhone alloc] init];
    
    l.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:l animated:YES
     ];
    
}
#pragma mark 校验格式
-(BOOL)verificateData {
    if ((_phone.text == nil)|[_phone.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入手机号" ifSucess:NO];
        return NO;
    }
    

    
    if (![Tool validateMobile:[self getPhoneNum]]) {
        [self.view makeToast:@"请输入正确的手机号" ifSucess:NO];
        return NO;
    }
    
    
    if ((_mima.text == nil)||[_mima.text isEqualToString:@""])
    {
         
        [self.view makeToast:@"请输入密码" ifSucess:NO];
        return NO;
    }
    
    if (([_mima.text length]<6) || ([_mima.text length]>16))
    {
        [self.view makeToast:@"密码应为6-16位,字母,数字,下划线组合" ifSucess:NO];
        return NO;
    }
    if (![Tool validateUserPassword:_mima.text]) {
        [self.view makeToast:@"密码应为6-16位,字母,数字,下划线组合"];
        return NO;
    }
    
    if ((_mima.text == nil)||[_mima.text isEqualToString:@""])
    {
        [self.view makeToast:@"请再次输入密码"ifSucess:NO];
        return NO;
    }
    if (![_mima.text isEqualToString:_mima.text])
    {
        
        [self.view makeToast:@"两次输入的密码不一致"ifSucess:NO];
        return NO;
    }
    
    return YES;
}

/**
 *  返回不带****的号码
 *
 *  @return
 */
- (NSString *)getPhoneNum {
    NSString *phoneStr = nil;
    
//  MYLog(@"%ld-------%@",self.phone.text.length,[self.phone.text substringFromIndex:7]);
    
    
    if (self.phone.text.length<=10) {
        return self.phone.text;
    }

    if ([[self.phone.text substringWithRange:NSMakeRange(3, 4)] isEqualToString:@"****"]) {
        
        if ([[self.phone.text substringFromIndex:7] isEqualToString:[self.phoneNum substringFromIndex:7]]) {
            phoneStr = self.phoneNum;
        } else {
            phoneStr = self.phone.text;

        }
        
    } else {
        phoneStr = self.phone.text;
    }
    return phoneStr;
}


#pragma mark textField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int length = 0;
    
    if (textField == _phone) {
        length = 11;
    } else if (textField == _mima) {
        length = 16;
    }
    
    // 用string 替换 range 位置的字符串
    NSString * newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newStr.length>length) {
        return NO;
    }
    return YES;
    
}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    short newLen = [newString length];
//    short len = [textField.text length];
//    if (len > newLen) {
//        return YES;
//    }
//    if (textField == _mima && _mima.text.length > 19) {
//        return NO;
//    }
//    if (textField == _mima && _mima.text.length > 19) {
//        return NO;
//    }
//    return YES;
//}
#pragma mark 退回键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
    
}


#pragma mark  返回
- (void)backK{
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    if ((self.isFrom == 101)) {
//        YJTabBarController *yy = [YJTabBarController shareManager];
//        yy.selectedViewController = yy.viewControllers[0];
//        yy.tabBarr.selectedButton.selected =NO;
//        yy.tabBarr.selectedButton = yy.tabBarr.subviews[0];
//        yy.tabBarr.selectedButton.selected =YES;
//        self.view.window.rootViewController = yy;
//        [self.view.window makeKeyAndVisible];
//    }
    
//    
//    if(self.isFrom == 103){
//        [self dismissViewControllerAnimated:YES completion:nil];
//        
//    }else if(self.isFrom == 101){
//        
//        [self dismissViewControllerAnimated:YES completion:nil];
//        
//        
//    }else {
//        [self dismissViewControllerAnimated:YES completion:nil];
//
//        YJTabBarController *yy = [YJTabBarController shareManager];
//        
//        yy.selectedViewController = yy.viewControllers[0];
//        yy.tabBarr.selectedButton.selected =NO;
//        yy.tabBarr.selectedButton = yy.tabBarr.subviews[0];
//        yy.tabBarr.selectedButton.selected =YES;
//        self.view.window.rootViewController = yy;
//        [self.view.window makeKeyAndVisible];
//        //        [self.view removeFromSuperview];
//    }
    
}


#pragma mark - 键盘的处理
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
                transfromY =  -100;
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
