//
//  MessageCode.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/20.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCode : UIViewController

@property (copy, nonatomic) NSString *oldPhone;

@property (copy, nonatomic) NSString *phone;

// 一共有 3个服务使用此控制器
// 登录忘记密码 , 跳转到重置密码页面.     APP_FORGETPWD_AUTHCODE
// 注册发送验证码, 跳转到重置密码页面.     APP_REGISTER_AUTHCODE
// 修改手机号时  , 直接 dismiss         APP_UDMOBLILE_AUTHCODE
@property (copy, nonatomic) NSString *modelCode;

// 不同位置进入,导航颜色有差异
@property (strong, nonatomic) UIColor *navColor;

@end
