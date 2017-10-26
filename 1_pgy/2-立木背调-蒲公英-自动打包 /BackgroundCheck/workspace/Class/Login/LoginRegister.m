//
//  LoginRegister.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/21.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "LoginRegister.h"
#import "MessageCode.h"

@interface LoginRegister ()<UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
//@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet JETextFiled *phone;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CtopH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgW;



@end

@implementation LoginRegister
{ 
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (iPhone5 || iPhone4s) {
        _CtopH.constant = 162;
        _imgH.constant = 80;
        _imgW.constant = 80;
    } else if (iPhone6) {
        _CtopH.constant = 180;
        _imgH.constant = 80;
        _imgW.constant = 80;
    }else if (iPhone6P) {
        _CtopH.constant = 180;
        _imgH.constant = 80;
        _imgW.constant = 80;
    }
    self.view.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    self.view.backgroundColor = [UIColor whiteColor];
    self.phone.delegate = self;
    
    self.loginbtn.enabled=NO;
    self.loginbtn.alpha = 0.3;
    self.loginbtn.layer.cornerRadius = 2.0;
    self.loginbtn.layer.masksToBounds = YES;
    [self.loginbtn setBackgroundColor:[UIColor  colorWithHexString:@"#39b31b"]];
    
//    [self.registerBtn setBackgroundColor:[UIColor  whiteColor]];
//    [self.registerBtn setTitleColor:[UIColor colorWithHexString:@"#39b31b"] forState:UIControlStateNormal];
//    self.registerBtn.layer.cornerRadius = 2.0;
//    self.registerBtn.layer.masksToBounds = YES;
//    [self.registerBtn.layer setBorderWidth:1.0];
//    [self.registerBtn.layer setBorderColor:[UIColor  colorWithHexString:@"#60c148"].CGColor];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // 监听:
    [_phone addTarget:self action:@selector(textFieldDidEndEditingP:) forControlEvents:UIControlEventEditingChanged];
   
 }

-(void)setAttrib{
    NSString *t =_hintLabel.text;
    NSRange  r = NSMakeRange(7, t.length-7);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:t];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:r];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#3071f2"] range:r];
    _hintLabel.attributedText = attrStr;
}
////
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.window.backgroundColor = [UIColor whiteColor];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    [self setAttrib];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.phone becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
////
#pragma mark - 监听控制
-(void)textFieldDidEndEditingP:(UITextField*)textFiled{
    [self setBtnStatus];
}
-(void)setBtnStatus{
    if (self.phone.text.length==11+2) {
        self.loginbtn.alpha = 1;
        self.loginbtn.enabled=YES;
    }else{
        self.loginbtn.alpha = 0.3;
        self.loginbtn.enabled=NO;
    }
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    [self performSelector:@selector(setBtnStatus) withObject:nil afterDelay:0.3];
    return YES;
}

#pragma mark -  - 交互
#pragma mark 登录
- (IBAction)clickedLogin:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 注册
- (IBAction)clickedRegister:(UIButton *)sender {
    if ([self verificatePhone:self.phone]) {
        [self checkMobile];
    }
}
#pragma mark 注册协议
- (IBAction)clickedRegisterProtocol:(id)sender {
    // 251453530  251453530
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
            [sself sendNetWorking];
        } else if ([responseObj[@"code"] isEqualToString:@"4011"]) {//已经注册： 不行
            [sself.view makeToast:@"手机号已经注册"];
        } else {
            [sself.view makeToast:responseObj[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:errorInfo];
    }];
}
#pragma mark   获取验证码
- (void)sendNetWorking {
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_sendMobileCode,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" : [_phone.text cutAllSpace],
                               @"modelCode" :APP_REGISTER_AUTHCODE};
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_sendMobileCode] params:dicParams success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        
        if ([responseObj[@"code"] isEqualToString:@"0000"]) {
            MessageCode *next = [[MessageCode alloc]init];
            next.phone = _phone.text;
            next.modelCode = APP_REGISTER_AUTHCODE;
            [sself.navigationController pushViewController:next animated:YES];
        }else {
            [sself.view makeToast:responseObj[@"msg"] ];
        }
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        [sself.view makeToast:errorInfo];
    }];
    
}

- (NSString *)getPhoneNum {
    NSString *phoneStr = [self.phone.text cutAllSpace];
    if (phoneStr.length<=10) {
        return phoneStr;
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
    }
    if (textField.text.length > length-1) {
        NSString * newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (newStr.length>length) {
            return NO;
        }
    }
    return YES;
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)keyboardWillChangeFrame:(NSNotification *)note{
//    __block typeof(self) sself = self;
//    if(!showSelf_){
//        self.view.transform = CGAffineTransformIdentity;
//        return;
//    }
//    CGFloat duartion = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat y = keyboardFrame.origin.y;
//    __block CGFloat transfromY ;
//    if (iPhone5) {
//        if (y <= 768) {
//            if (500 > y) {
//                transfromY =  -140;
//            }else if(500 <= y && y<768){
//                transfromY =  0;
//            }
//            [UIView animateWithDuration:duartion animations:^{
//                sself.view.transform = CGAffineTransformMakeTranslation(0, transfromY);
//            }];
//        }
//    }else if (iPhone6) {
//        if (y <= 768) {
//            if (500 > y) {
//                transfromY =  -50;
//            }else if(500 <= y && y<768){
//                transfromY =  0;
//            }
//            [UIView animateWithDuration:duartion animations:^{
//                sself.view.transform = CGAffineTransformMakeTranslation(0, transfromY);
//            }];
//        }
//    }
//}
// [[UIScreen mainScreen] currentMode].size
// 640 1136  === iPhone5
// 750 1334  ===
- (IBAction)clickedImg:(UIButton *)sender {
}






@end
