//
//  JPopTextFiledView.h
//  CreditPlatform
//
//  Created by gyjrong on 16/11/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WindowView      [[UIApplication sharedApplication] keyWindow]

#define JPWIDTH   ([UIScreen mainScreen].bounds.size.width -30)
#define JPHEIGHT 218
#define JPSPACE  80

#import "CommonSendMsgVC.h"

typedef void (^jPopTextFiledClickedSureBtn)(NSString *obj);

typedef void (^jPopClickedCancleBtn)();

@interface JPopTextFiledView : UIView


@property (copy,nonatomic) NSString      *txt;
@property (copy,nonatomic) jPopTextFiledClickedSureBtn  clickedBlock;
@property (copy,nonatomic) jPopClickedCancleBtn  CancleBlock;
@property (strong, nonatomic)  UITextField *textfile;
@property (assign,nonatomic) CommonSendMsgType sendMsgType;


-(void)show;


@end
