//
//  LoginCommonVC.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/21.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "LoginCommonVC.h"

@interface LoginCommonVC ()

@end

@implementation LoginCommonVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:false animated:false];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:false];
    [self.navigationController.view setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]];
}


 
#pragma mark -
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
} 

#pragma mark - 校验
-(BOOL)verificatePhone:(UITextField*)textFiled {
    if ((textFiled.text == nil)|[textFiled.text isEqualToString:@""])
    {
        [self.view makeToast:@"手机号码不能为空" ifSucess:NO];
        return NO;
    }
    if (![Tool validateMobile:[textFiled.text cutAllSpace] ]) {
        [self.view makeToast:@"手机号码格式有误" ifSucess:NO];
        return NO;
    }
    return YES;
}

#pragma mark 校验格式
-(BOOL)verificatePassword:(UITextField*)textfiled
{
    if ((textfiled.text == nil)||[textfiled.text isEqualToString:@""]){
        [self.view makeToast:@"密码不能为空" ifSucess:NO];
        return NO;
    }
    if (([textfiled.text length]<6) || ([textfiled.text length]>16)){
        [self.view makeToast:@"密码长度6-16位,字母、数字和下划线至少两种的组合" ifSucess:NO];
        return NO;
    }
    if (![Tool validatePassword:textfiled.text]) {
        [self.view makeToast:@"密码长度6-16位,字母、数字和下划线至少两种的组合"];
        return NO;
    }
    return YES;
}

//校验格式
-(BOOL)verificateOldPassword:(UITextField*)_oldmm newPassword:(UITextField*)_newmm{
    if ((_oldmm.text == nil)||[_oldmm.text isEqualToString:@""])
    {
        [self.view makeToast:@"请输入旧密码" ifSucess:NO];
        return NO;
    }
    if (([_oldmm.text length]<6) || ([_oldmm.text length]>16))
    {
        [self.view makeToast:@"密码为6-16位,字母,数字组合" ifSucess:NO];
        return NO;
    }
    if ((_newmm.text == nil)||[_newmm.text isEqualToString:@""])
    {
        [self.view makeToast:@"请输入新密码"ifSucess:NO];
        return NO;
    }
    if (([_newmm.text length]<6) || ([_newmm.text length]>16))
    {
        [self.view makeToast:@"密码为6-16位,字母,数字组合" ifSucess:NO];
        return NO;
    }
    if (![Tool validatePassword:_newmm.text]) {
        [self.view makeToast:@"密码为6-16位,字母,数字组合"];
        return NO;
    }
    
    return YES;
}




#pragma mark -
- (NSString *)base64Encode:(NSString *)string {
    NSData *nsdata = [string
                      dataUsingEncoding:NSUTF8StringEncoding];
    return [nsdata base64EncodedStringWithOptions:0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
