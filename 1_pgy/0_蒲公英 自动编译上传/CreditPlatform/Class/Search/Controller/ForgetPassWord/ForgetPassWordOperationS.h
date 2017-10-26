//
//  ForgetPassWordOperationS.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPassWordOperationS : UIViewController
@property (strong,nonatomic) NSString *token;
// 第一步要输入验证码
@property (assign,nonatomic) BOOL      yzm;
// 第一步要输入新密码
@property (assign,nonatomic) BOOL      forgetPassMM;

//@property (assign,nonatomic) BOOL ISMM;
@end
