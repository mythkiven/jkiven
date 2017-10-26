//
//  JPopTextFiledView.h
//  CreditPlatform
//
//  Created by gyjrong on 16/11/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define lmzxWindowView      [[UIApplication sharedApplication] keyWindow]

#define lmzxJPWIDTH   ([UIScreen mainScreen].bounds.size.width -30)
#define lmzxJPHEIGHT 208
#define lmzxJPSPACE  80

#import "LMZXDemoAPI.h"
#import "LMZXSMSTextFiled.h"



typedef void (^jPopTextFiledClickedSureBtn)(NSString *obj);

typedef void (^jPopClickedCancleBtn)();

@interface LMZXPopTextFiledView : UIView

/** 手机号/邮箱等主题字 */
@property (copy,nonatomic) NSString      *txt;

@property (copy,nonatomic) jPopTextFiledClickedSureBtn  clickedBlock;
@property (copy,nonatomic) jPopClickedCancleBtn  CancleBlock;
@property (strong, nonatomic)  LMZXSMSTextFiled *textfile;
@property (assign,nonatomic) LMZXCommonSendMsgType sendMsgType;

// 运营商提示语
@property (strong,nonatomic) NSString* mobileSmsMsg;



-(void)show;


@end
