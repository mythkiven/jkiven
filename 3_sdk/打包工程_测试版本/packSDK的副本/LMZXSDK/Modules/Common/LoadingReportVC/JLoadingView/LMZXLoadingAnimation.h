//
//  LMZXLoadingAnimation.h
//  LoadingAnimation
//
//  Created by gyjrong on 17/2/24.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LMZXLoadingAnimation : UIView


// 两种业务模式,会在类内部自动检测,并使用不同的动画方式.
// 但需要传入登录成功的标注.



-(instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lindWidth color:(UIColor*)color radius:(CGFloat)radius;


/**
 包括第一次启动\暂停后再次启动
  */
-(void)startLoading;

/** 
 来了验证码的时候使用: 暂停动画,
  */
-(void)stopAnimation;

/** 
 退出页面,结束掉动画: 动画结束
  */
-(void)endAnimation;

/** 
 打对号
  */
-(void) setYes;


@end
