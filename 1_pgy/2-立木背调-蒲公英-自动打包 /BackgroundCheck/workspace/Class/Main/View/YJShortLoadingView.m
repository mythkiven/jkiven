//
//  YJShortLoadingView.m
//  CreditPlatform
//
//  Created by yj on 16/8/12.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJShortLoadingView.h"

@interface YJShortLoadingView ()

@property (weak, nonatomic) IBOutlet UIImageView *cycleView;

@end

@implementation YJShortLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
+ (instancetype)shortLoadingView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"YJShortLoadingView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 6;
    self.clipsToBounds = YES;
    
}


+ (void)yj_makeToastActivityInView:(UIView *)view {
    
    view.userInteractionEnabled = NO;
    YJShortLoadingView *waitingView = [self shortLoadingView];
    waitingView.alpha = 0;
    MYLog(@"-----%@",NSStringFromCGRect(view.frame));
    waitingView.centerX = view.center.x;
    waitingView.centerY = view.center.y;
    waitingView.bounds = CGRectMake(0, 0, 60, 60);
    waitingView.frame = CGRectMake((view.width-60)*.5, (view.height-60)*.4, 60, 60);


    [view addSubview:waitingView];
//    waitingView.frame = CGRectMake((SCREEN_WIDTH-75)*.5, (SCREEN_HEIGHT-75)*.5-64, 75, 75);
    [waitingView startAnimating];

    [UIView animateWithDuration:0.25 animations:^{
        waitingView.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];
    
}
+ (void)yj_hideToastActivityInView:(UIView *)view {
    view.userInteractionEnabled = YES;
    YJShortLoadingView *waitingView = [self waitingViewForView:view];
    
    if (waitingView != nil) {
        [UIView animateWithDuration:0.25 animations:^{
            waitingView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [waitingView removeFromSuperview];
        }];
    }
    
}



+ (instancetype)waitingViewForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (YJShortLoadingView *)subview;
        }
    }
    return nil;
}

// 旋转动画
- (void)startAnimating {

    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         
                         CATransform3DMakeRotation(M_PI/2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.15;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    [self.cycleView.layer addAnimation:animation forKey:nil];
    
}




- (void)setFrame:(CGRect)frame {
    CGRect myFrame = frame;
    myFrame.size.width = 60;
    myFrame.size.height = 60;
    frame = myFrame;
    [super setFrame:frame];
}

@end
