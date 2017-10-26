//
//  LMHomeViewController.h
//  LMZX_SDKDemo_OC
//
//  Created by yj on 2017/3/28.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import <UIKit/UIKit.h>

// 验证码类型
typedef enum : NSInteger {
    LMZXCommonSendMsgTypeNormal = 11,// 默认:信用卡账单邮箱验证码,京东,淘宝验证码(未单独列出)
    LMZXCommonSendMsgTypePhone,// 运营商 验证码(已单独列出)
    LMZXCommonSendMsgTypeJLDX,//吉林电信专用  验证码(已单独列出)
    LMZXCommonSendMsgTypeQQCredit,//信用卡邮箱:QQ独立密码(已单独列出)
}LMZXCommonSendMsgType;

@interface LMHomeViewController : UIViewController

@end
