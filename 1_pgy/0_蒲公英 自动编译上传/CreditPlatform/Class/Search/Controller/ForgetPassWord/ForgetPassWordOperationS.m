//
//  ForgetPassWordOperationS.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ForgetPassWordOperationS.h"
#import "OperatorsDataTool.h"
#import "ForgetPassWordOperation.h"
#import "CommonSearchVC.h"
@interface ForgetPassWordOperationS ()
@property (weak, nonatomic) IBOutlet UITextField *messageSure;
@property (weak, nonatomic) IBOutlet UITextField *PassW;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;



@property (weak, nonatomic) IBOutlet UILabel *viewTop;
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewT;
@property (weak, nonatomic) IBOutlet UIButton *viewThree;

@end

@implementation ForgetPassWordOperationS
{
    __block NSString *Token;
    NSTimer *_timer;
    OperatorsDataTool *_operatorsDataTool;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewT.hidden = YES;
    self.viewOne.hidden = YES;
    self.viewThree.hidden = YES;
    self.viewTop.hidden = YES;
    self.title = @"修改运营商密码";
    //验证码OK
    if (_yzm) {
        self.viewOne.hidden = NO;
        self.viewThree.hidden = NO;
    }
    //输入新密码
    if (_forgetPassMM) {
        self.viewT.hidden =NO;
        self.viewThree.hidden =NO;
    }
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showYZM:) name:NSNotificationCenter_OperationShow_88meaasga object:nil];
    //密码OK
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMMM:) name:NSNotificationCenter_OperationShow_88_2meaasga object:nil];
    //重设OK
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showOver:) name:NSNotificationCenter_OperationShow_88_3meaasga object:nil];
    //验证码
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showYZMM:) name:NSNotificationCenter_OperationShow_88meaasga object:nil];
    
    //错误
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showError:) name:NSNotificationCenter_Operationerror_meaasga object:nil];
    
    
   
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [YJShortLoadingView yj_hideToastActivityInView:self.view];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //退出页面退出轮训
    [_operatorsDataTool removeTimer];
    
}
// 展示验证码
-(void)showYZMM:(NSNotification*)noti{
    [YJShortLoadingView yj_hideToastActivityInView:self.view];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [_operatorsDataTool removeTimer];
    self.viewThree.hidden = NO;
    self.viewOne.hidden = NO;
    self.viewT.userInteractionEnabled =NO;
    [self.view makeToast:@"请输入验证码,然后确认"];
    //    _ISMM = YES;
    _forgetPassMM =NO;
    _yzm =YES;
}
// 展示密码框
-(void)showMMM:(NSNotification*)noti{
    [YJShortLoadingView yj_hideToastActivityInView:self.view];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [_operatorsDataTool removeTimer];
    self.viewThree.hidden = NO;
    self.viewT.hidden = NO;
    self.viewOne.userInteractionEnabled =NO;
    [self.view makeToast:@"请输入密码,然后确认"];
    _yzm = NO;
    _forgetPassMM = YES;
}
// 展示结束
-(void)showOver:(NSNotification*)noti{
    [_operatorsDataTool removeTimer];
    [self.view makeToast:@"重置密码成功"];
    [self performSelector:@selector(outself) withObject:nil afterDelay:3.0];
}
#pragma mark 收到错误信息
-(void)showError:(NSNotification*)noti {
    NSDictionary *dic =noti.userInfo;
    [YJShortLoadingView yj_hideToastActivityInView:self.view];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.view makeToast:dic[@"key"]];
    if ([dic[@"isOut"] integerValue]) {//强制退出
        [self performSelector:@selector(outself) withObject:nil afterDelay:2.0];
    }
}

-(void)outself{
    ForgetPassWordOperation  *ff = (ForgetPassWordOperation  *)self.navigationController.viewControllers[2];
    [self.navigationController popToViewController:ff animated:YES];
}
#pragma mark 交互 下一步
- (IBAction)Sure:(id)sender {
    if (![self verificateData]) {
        return;
    }
    __block typeof(_PassW) pass = _PassW;
    if (_forgetPassMM) {//输入新密码
        NSDictionary *dicParams =@{@"method" :  urlJK_resetMobilePwd,
                                   @"mobile" :  kUserManagerTool.mobile,
                                   @"userPwd":  kUserManagerTool.userPwd,
                                   @"token":  [Tool objectForKey:tokensaveOnce],
                                   @"newPassword":  pass.text
                                   };
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [YJShortLoadingView yj_makeToastActivityInView:self.view];

        _operatorsDataTool = [[OperatorsDataTool alloc]init];
        _operatorsDataTool.isfrom = 88;
        
        [_operatorsDataTool resetInfo:dicParams OperatorsData:^(id obj) {//验证码或者OK
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
            _PassW.enabled = NO;
            
        } failure:^(NSError *error) {
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:errorInfo];
            [self performSelector:@selector(outself) withObject:nil afterDelay:2.0];
        }];
    } else if (_yzm) {//输入验证码继续轮训
        NSDictionary *dicParams =@{@"method" :  urlJK_mobileSmsCheck,
                                   @"mobile" :  kUserManagerTool.mobile,
                                   @"userPwd":  kUserManagerTool.userPwd,
                                   @"token":  [Tool objectForKey:tokensaveOnce],
                                   @"smsCode":  _messageSure.text
                                   };
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [YJShortLoadingView yj_makeToastActivityInView:self.view];

        _operatorsDataTool = [[OperatorsDataTool alloc]init];
        _operatorsDataTool.isfrom = 88;
        [_operatorsDataTool messageInfo:dicParams OperatorsDataMeaasgasuccess:^(id obj) {//密码或者OK
            _messageSure.enabled = NO;
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        } failure:^(NSError *error) {
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view makeToast:errorInfo];
            [self performSelector:@selector(outself) withObject:nil afterDelay:2.0];
        }];
    }
    
}


- (void)addTimer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(requestData) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
}
- (void)requestData {
    
}
- (void)removeTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        MYLog(@"-----定时器移除");
    }
}





//-(void)viewWillAppear:(BOOL)animated {
//    
//    
//    
//}


#pragma mark 校验格式
#pragma mark 校验格式
-(BOOL)verificateData {
    if (_yzm&&((_messageSure.text == nil)|[_messageSure.text isEqualToString:@""]))
    {
        
        [self.view makeToast:@"请输入验证码" ifSucess:NO];
        return NO;
    }
    if (_forgetPassMM&&((_PassW.text == nil)|[_PassW.text isEqualToString:@""]))
    {
        
        [self.view makeToast:@"请输入密码" ifSucess:NO];
        return NO;
    }
//    if (([_PassW.text length]<6) || ([_PassW.text length]>16))
//    {
//        [self.view makeToast:@"密码应为6-16位,字母,数字,下划线组合" ifSucess:NO];
//        return NO;
//    }
//    
//    if (![Tool validatePassword:_PassW.text]) {
//        [self.view makeToast:@"密码应为6-16位,字母,数字,下划线组合"];
//        return NO;
//    }
    
    return YES;
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
