//
//  YJShortLoadingView.h
//  CreditPlatform
//
//  Created by yj on 16/8/12.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJShortLoadingView : UIView

+ (instancetype)shortLoadingView;

+ (void)yj_makeToastActivityInView:(UIView *)view;
+ (void)yj_hideToastActivityInView:(UIView *)view;

@end
