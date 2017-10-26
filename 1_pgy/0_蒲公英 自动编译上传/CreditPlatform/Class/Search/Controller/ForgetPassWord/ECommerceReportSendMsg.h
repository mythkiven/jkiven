//
//  OperationSendMsgVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/8/3.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationSendMsgVC : UIViewController
@property (strong,nonatomic) NSString      *phone;
// 服务密码
@property (strong,nonatomic) NSString *password;
// 客服密码
@property (strong,nonatomic) NSString *otherInfo;
@end
