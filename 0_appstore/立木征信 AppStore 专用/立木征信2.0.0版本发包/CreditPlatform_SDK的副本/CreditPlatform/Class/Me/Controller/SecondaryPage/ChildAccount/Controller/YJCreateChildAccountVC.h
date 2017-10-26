//
//  YJCreateChildAccountVC.h
//  CreditPlatform
//
//  Created by yj on 2016/11/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^CancelBlock)(void);
@interface YJCreateChildAccountVC : UIViewController
@property (nonatomic, copy) CancelBlock cancelBlock;
@end
