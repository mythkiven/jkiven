//
//  YJCreditWaitingView.h
//  testLIMUAnimation
//
//  Created by yj on 16/8/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJCreditWaitingView : UIView
+ (instancetype)creditWaitingView;


/**
 *  隐藏加载动画---长加载
 *
 */
+ (BOOL)yj_hideWaitingViewForView:(UIView *)view animated:(BOOL)animated;
/**
 *  显示加载动画---长加载
 *
 */
+ (void)yj_showWaitingViewAddedTo:(UIView *)view animated:(BOOL)animated;



@end
