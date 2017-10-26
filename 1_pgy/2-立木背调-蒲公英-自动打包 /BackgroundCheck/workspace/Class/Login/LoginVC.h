//
//  LoginVC.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/25.
//  Copyright © 2015年 yunhoo. All rights reserved.
//
#import "LoginCommonVC.h"
 
#import <UIKit/UIKit.h>
#import "JETextFiled.h"
typedef void(^LoginSuccess)();
@interface LoginVC : LoginCommonVC
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet JETextFiled *phone;

/**10:当前为启动页面->登录后进入主页*/
@property (nonatomic, assign) NSInteger isFrom;
/**
 app 启动, 未登录要登录:左上角无返回按钮.
 app 退出登录, 直接进入登录页面:左上角无返回按钮.
 
 */

// 以下全部的back都是 dismiss。

// 101:从登录页面的[注册、修改]密码-->modal而来的。。。成功后直接去首页。
// *** 102:setting页面[修改手机号、密码]的-->modal 而来的。。成功后直接dismiss已经处理login为一层

// 103:其他页面点击事件：登录成功后，直接dismiss的。

/** 102 取消代码，101取消代码  全部页面，只需要dismiss即可 */
//@property (nonatomic, assign) NSInteger isFrom;


@property (nonatomic, strong) id  some;

@end
