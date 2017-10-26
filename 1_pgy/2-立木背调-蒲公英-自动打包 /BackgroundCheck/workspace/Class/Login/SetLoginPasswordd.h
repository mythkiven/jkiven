//
//  SetLoginPassword.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/21.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "LoginCommonVC.h"

@interface SetLoginPasswordd : LoginCommonVC
//@interface SetLoginPasswordd : UIViewController

@property (strong,nonatomic) NSString      *phone;
@property (strong,nonatomic) NSString      *smsCode;
/**
 11 登录忘记密码
 12 注册
 */
@property (assign,nonatomic) NSInteger     soureVC;

@end

