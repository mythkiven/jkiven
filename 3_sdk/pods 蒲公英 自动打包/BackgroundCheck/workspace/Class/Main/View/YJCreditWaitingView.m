//
//  YJCreditWaitingView.m
//  testLIMUAnimation
//
//  Created by yj on 16/8/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCreditWaitingView.h"
#define kLineWidth 5
#define kWidth 250
@interface YJCreditWaitingView ()
{
    UIImageView *_imgView;
    CGFloat _wordWidth;
    UIImageView *_logoView;
}
@end
@implementation YJCreditWaitingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImage *logo = [UIImage imageNamed:@"icon_shake_animation_1"];
        // logo
        UIImageView *logoView = [[UIImageView alloc] initWithImage:logo];
        _logoView = logoView;
        logoView.frame = CGRectMake((kWidth - logo.size.width)*0.5, 0,logo.size.width , logo.size.height);
        [self addSubview:logoView];


        // 文字
        NSString *title = @"努力加载中，请耐心等候。";
        UIFont *titleFont = Font15;
        UILabel *loadLB = [[UILabel alloc] init];
        loadLB.adjustsFontSizeToFitWidth =YES;
        loadLB.font = titleFont;
        loadLB.textAlignment = NSTextAlignmentCenter;
        loadLB.textColor = RGB_grayNormalText;
         loadLB.frame = CGRectMake(0, CGRectGetMaxY(logoView.frame)+1, kWidth, 21);
        loadLB.text = title;
        [self addSubview:loadLB];
        
    }
    return self;
}

+ (instancetype)creditWaitingView {
    
    return [[self alloc] init];
}

+ (BOOL)yj_hideWaitingViewForView:(UIView *)view animated:(BOOL)animated {
    view.userInteractionEnabled = YES;
    YJCreditWaitingView *waitingView = [self waitingViewForView:view];
    if (waitingView != nil) {
        if (animated) {
            [UIView animateWithDuration:0.25 animations:^{
                waitingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [waitingView removeFromSuperview];
            }];
        } else {
            
            [waitingView removeFromSuperview];
        }
        
        
        return YES;
    }
    return NO;
}

+ (void)yj_showWaitingViewAddedTo:(UIView *)view animated:(BOOL)animated {
    
    YJCreditWaitingView *waitingView = [self creditWaitingView];
    waitingView.alpha = 0;
    view.userInteractionEnabled = NO;
    waitingView.frame = CGRectMake((view.frame.size.width-kWidth)*0.5, 173.5-64, 0, 0);

    [view addSubview:waitingView];
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            waitingView.alpha = 1.0;
        } completion:^(BOOL finished) {
             [waitingView runAnimation];

        }];
    } else {
        waitingView.alpha = 1.0;
         [view addSubview:waitingView];
    }
}

+ (instancetype)waitingViewForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (YJCreditWaitingView *)subview;
        }
    }
    return nil;
}





#pragma mark-- logo动画
- (void)runAnimation
{
    if (_logoView.isAnimating) return;
    NSMutableArray *pic = [self animationImagesWithName:@"icon_shake_animation" count:40];
    
    _logoView.animationImages = pic;
    _logoView.animationRepeatCount = MAXFLOAT;
    _logoView.animationDuration = 1.5;
    [_logoView startAnimating];
    
}

/**
 *  刷新控件动画组
 *
 */
- (NSMutableArray *)animationImagesWithName:(NSString *)name count:(int)count {
    NSMutableArray *imgArr = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 1; i <= count; i ++) {
        NSString *imgName = [NSString stringWithFormat:@"%@_%d",name,i];
        
        UIImage *img = [UIImage imageNamed:imgName];
        
        [imgArr addObject:img];
    }
    return imgArr;
}


- (void)setFrame:(CGRect)frame {
    frame.size.width = kWidth;
    frame.size.height = kWidth;

    [super setFrame:frame];
}


#pragma mark-------旋转+缩小动画-----弃用

- (void)drawRect1:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint point = CGPointMake(kWidth*0.5, kWidth*0.5);
    [path addArcWithCenter:point radius:kWidth*0.5-kLineWidth+2 startAngle:0 endAngle:2*M_PI clockwise:YES];

    [self addPathSublayer:path];

}

- (void)addPathSublayer:(UIBezierPath *)path{
    CAShapeLayer *arcLayer = [CAShapeLayer layer];
    arcLayer.path = path.CGPath;
    arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.strokeColor = RGB_navBar.CGColor;
    arcLayer.lineWidth = kLineWidth;
    arcLayer.frame =CGRectMake(0, 0, kWidth, kWidth);
    [self.layer addSublayer:arcLayer];
    
    [self drawLineAnimation:arcLayer];
    
    [self animation:_imgView];
}


-(void)drawLineAnimation:(CALayer*)layer
{
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    ani.duration = 3;
    ani.repeatCount = NSNotFound;
    ani.fromValue = @(0);
    ani.toValue = @(1);
    [layer addAnimation:ani forKey:nil];
    
    
}

- (void)animation:(UIView *)view {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@1,@0.8,@.6,@0.4,@0.2,@0.4,@0.6,@0.8,@1];
    animation.removedOnCompletion = YES;
    animation.repeatCount = 20;
    animation.fillMode = kCAFillModeRemoved;
    
    animation.duration = 2.5f;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}






@end
