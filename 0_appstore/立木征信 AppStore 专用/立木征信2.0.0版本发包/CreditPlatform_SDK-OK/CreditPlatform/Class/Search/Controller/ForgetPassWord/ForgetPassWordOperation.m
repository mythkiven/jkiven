//
//  ForgetPassWordOperation.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ForgetPassWordOperation.h"
#import "OperatorsDataTool.h"
#import "ForgetPassWordOperationS.h"
@interface ForgetPassWordOperation ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *realName;
@property (weak, nonatomic) IBOutlet UITextField *ID;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation ForgetPassWordOperation
{
    OperatorsDataTool *_operatorsDataTool;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showError:) name:NSNotificationCenter_Operationerror_meaasga object:nil];
    //先发短信
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showYZM:) name:NSNotificationCenter_OperationShow_81meaasga object:nil];
    //先发MM
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMM:) name:NSNotificationCenter_OperationShow_81_2meaasga object:nil];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [YJShortLoadingView yj_hideToastActivityInView:self.view];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)showYZM:(NSNotification*)noti{
    ForgetPassWordOperationS *ss = [[ForgetPassWordOperationS alloc]init];
    ss.yzm = YES;
    [self.navigationController pushViewController:ss animated:YES];
}
-(void)showMM:(NSNotification*)noti{
    ForgetPassWordOperationS *ss = [[ForgetPassWordOperationS alloc]init];
    ss.forgetPassMM = YES;
    [self.navigationController pushViewController:ss animated:YES];
}

#pragma mark 收到错误信息
-(void)showError:(NSNotification*)noti {
    NSDictionary *dic =noti.userInfo;
    [YJShortLoadingView yj_hideToastActivityInView:self.view];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.view makeToast:dic[@"key"]];
//    if ([dic[@"isOut"] integerValue]) {//强制退出
//        [self performSelector:@selector(outself) withObject:nil afterDelay:2.0];
//    }
}
-(void)outself{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 点击下一步
- (IBAction)clickedNext {
    [self.view endEditing:YES];
    if (![self verificateData]) {
        return;
    }
    [self sendCity];//添加有
    

    
    
}
-(void)reset{
    [YJShortLoadingView yj_makeToastActivityInView:self.view];

//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dicParams =@{@"method" :  urlJK_mobileFindPwd,
                               @"mobile" :  kUserManagerTool.mobile,
                               @"userPwd":  kUserManagerTool.userPwd,
                               @"username":_phone.text,
                               @"identityNo":_ID.text,
                               @"realName":_realName.text,
                               
                               };
    
    _operatorsDataTool = [[OperatorsDataTool alloc]init];
    _operatorsDataTool.isfrom = 81;
    [_operatorsDataTool resetInfo:dicParams OperatorsData:^(id obj) {//验证码或密码
        MYLog(@"----修改运营商密码-------%@",obj);
        // 第一步输入新密码。
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:errorInfo];
    }];
}

#pragma mark - 网络 查询手机号城市
- (void)sendCity{
    if ((_phone.text == nil)|[_phone.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入手机号" ifSucess:NO];
        return  ;
    }
    if (![Tool validateMobile:_phone.text]) {
        [self.view makeToast:@"请输入正确的手机号" ifSucess:NO];
        return ;
    }
    
    [self.view endEditing:YES];
    [YJShortLoadingView yj_makeToastActivityInView:self.view];

//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_queryMobileArea,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"mobileNo":_phone.text};
    
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_queryMobileArea] params:dicParams success:^(id responseObj) {
        MYLog(@"城市%@",responseObj);
        NSDictionary *list = [responseObj objectForKey:@"data"];
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (![list isKindOfClass:[NSNull class]]) {
            if ([list[@"code"] isEqualToString:@"0000"]) {//有数
                if ([NSString isBSGS:list[@"city"]]) {
                    [sself reset];
                    
                }else{
                    [self.view makeToast:@"目前仅支持北上深城市"];
                    [self performSelector:@selector(selfOut) withObject:nil afterDelay:2.0];
                    return ;
                }
            }else{//无数据
                [self.view makeToast: responseObj[@"data"][@"msg"] ];
            }
        } else {
            [self.view makeToast: @"请求失败" ];
        }
        
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:errorInfo];
    }];
    
    
}

-(void)selfOut{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 校验格式
-(BOOL)verificateData {
    if ((_phone.text == nil)|[_phone.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入手机号" ifSucess:NO];
        return NO;
    }
    if (![Tool validateMobile:_phone.text]) {
        [self.view makeToast:@"请输入正确的手机号" ifSucess:NO];
        return NO;
    }
    if ((_realName.text == nil)||[_realName.text isEqualToString:@""])
    {
        
        [self.view makeToast:@"请输入姓名" ifSucess:NO];
        return NO;
    }
    if (![Tool validateIdentityCard:_ID.text])
    {
        
        [self.view makeToast:@"请输入正确的身份证号码"ifSucess:NO];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
