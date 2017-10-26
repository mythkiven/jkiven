//
//  LoginCommonVC.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/21.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginCommonVC : UIViewController
- (NSString *)base64Encode:(NSString *)string;
//@property (assign, nonatomic) BOOL show;
-(BOOL)verificatePhone:(UITextField*)textFiled;

-(BOOL)verificateOldPassword:(UITextField*)_oldmm newPassword:(UITextField*)_newmm;

-(BOOL)verificatePassword:(UITextField*)textfiled;

@end
