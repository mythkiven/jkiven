//
//  OperationSendMsgVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/8/3.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
// 通用验证码 页面

typedef enum : NSInteger {
    CommonSendMsgTypeNormal =11,//验证码发送方式不确定
    CommonSendMsgTypePhone,//验证码发送到手机
    CommonSendMsgTypeMail,//验证码发送到邮箱
    CommonSendMsgTypeJLDX,//吉林电信专用
    CommonSendMsgTypeQQCredit,//信用卡页面，输入QQ独立密码
} CommonSendMsgType;


@interface CommonSendMsgVC : UIViewController
//  确认回调,必须实现
typedef void(^Sure)(id);
//  back回调,必须实现
typedef void(^Cancel)(id);

@property (nonatomic, copy) Sure Sure;
@property (nonatomic, copy) Cancel Cancel;

//顶部提示语的关键数据：手机号\邮箱
@property (strong,nonatomic) NSString  *msg;

@property (assign,nonatomic) CommonSendMsgType sendMsgType;



// 以下弃用：保留。用于二次发送验证码
// 服务密码
@property (strong,nonatomic) NSString *password;
// 客服密码
@property (strong,nonatomic) NSString *otherInfo;
//// 提示语：吉林电信专用
////@property (copy,nonatomic) NSString *popString;
//// 提示语：已经发送验证码到 phone
//@property (strong,nonatomic) NSString      *phone;
// 提示语：已经发送验证码到 邮箱

@end
