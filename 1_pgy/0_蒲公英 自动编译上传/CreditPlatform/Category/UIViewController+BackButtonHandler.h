//
//  UIViewController+BackButtonHandler.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/14.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>
@optional
// 重写back方法
-(BOOL)navigationShouldPopOnBackButton;
@end
@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>
@end
