//
//  JLoadingManagerView.h
//  JCombineLoadingAnimation
//
//  Created by https://github.com/mythkiven/ on 15/01/18.
//  Copyright © 2015年 mythkiven. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  Width [UIScreen mainScreen].bounds.size.width

typedef void (^jLoadingCompleteBlock)(void);


@interface JLoadingManagerView : UIView

@property (copy,nonatomic) NSString      *title;
@property (nonatomic,strong)    UIButton *progressLabel;

// 专用接口
/**  */
-(void)beginAnimationCompleteBlock:(jLoadingCompleteBlock)completeblock;
/**  */
-(void)reBeginAnimationCompleteBlock:(jLoadingCompleteBlock)completeblock;
/**  */
-(void)endAnimation;
/**  */
-(void)successAnimation:(jLoadingCompleteBlock)completeblock;


//  备用接口

/*
    启动动画
 */
-(void)startAnimationWithPercent:(CGFloat) end duration:(CGFloat)duration completeBlock:(jLoadingCompleteBlock)completeblock;

/*
    动画的控制
 */
-(void)startAnimationWithPercent:(CGFloat)begin endPercent:(CGFloat)end duration:(CGFloat)duration completeBlock:(jLoadingCompleteBlock)completeblock;

/*
  恢复动画，从上一次结束的地方恢复
 */
-(void)startAnimationCompleteBlock:(jLoadingCompleteBlock)completeblock;



@end
