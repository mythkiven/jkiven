//
//  LMZXLoadingAnimation.m
//  LoadingAnimation
//
//  Created by gyjrong on 17/2/24.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXLoadingAnimation.h"
#define LM_RGB(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]


@interface LMZXLoadingAnimation ()
// 外半径
@property (nonatomic, assign) CGFloat  outerRadius;
// 主题色
@property (strong,nonatomic)  UIColor  *themeColor;


// 线宽
@property (assign,nonatomic)  CGFloat  xlineWidth;
//
@property (nonatomic,strong) CAShapeLayer *cycleLayer;

@property (assign,nonatomic) BOOL  isLoading;
@property (nonatomic,strong) UIColor* loadingTintColor;
@property (assign,nonatomic) CGFloat animationDuration;


@property (assign,nonatomic) BOOL   isLovely;

@end

@implementation LMZXLoadingAnimation
{
    CGPoint _center;
}

-(instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lindWidth color:(UIColor*)color radius:(CGFloat)radius{

    if (self = [super initWithFrame:frame]) {
        _outerRadius = radius;
        _themeColor  = color;
        _xlineWidth  = lindWidth;
        _loadingTintColor = color;
        _animationDuration = 1.0;// 1s 一圈
        _isLoading = NO;
        _isLovely = NO;
        _center = CGPointMake(self.bounds.size.width / 2,  self.bounds.size.height / 2);
        [self createBackLine];
        [self  setupUI];
    }
    
    return self;
}
-(void)setupUI{
    
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    _cycleLayer = [CAShapeLayer layer];
    _cycleLayer.lineCap = kCALineCapRound;
    _cycleLayer.lineJoin = kCALineJoinRound;
    _cycleLayer.lineWidth = _xlineWidth;
    _cycleLayer.fillColor = [UIColor clearColor].CGColor;
    _cycleLayer.strokeColor = _loadingTintColor.CGColor;
    _cycleLayer.strokeEnd = 0;
//    if (_isLovely) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:_center radius:_outerRadius startAngle:-M_PI_4 endAngle:M_PI*2-M_PI_4 clockwise:YES];
        _cycleLayer.path = bezierPath.CGPath;
//    }
     
    _cycleLayer.bounds =  CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    _cycleLayer.position = self.center;
    [self.layer addSublayer:_cycleLayer];
}


#pragma mark 动画开始
-(void)startLoading{
    if (_isLoading) {
        [self resumeLayer:_cycleLayer];
        _isLoading =YES;
        
        return;
    }
    _isLoading = YES;
    self.alpha = 1.0;
    
   
    
    if (_isLovely) {
        CABasicAnimation* strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.fromValue = @(-1);
        //    strokeStartAnimation.fromValue = @(-0.5);
        strokeStartAnimation.toValue = @1.0;
        
        
        
        CABasicAnimation*  strokeEndAnimation =[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue = @0;
        strokeEndAnimation.toValue = @1.0;
        
        
        CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
        animationgroup.animations = [NSArray arrayWithObjects:strokeStartAnimation, strokeEndAnimation, nil];
        animationgroup.duration = _animationDuration;
        animationgroup.repeatCount = MAXFLOAT;
        animationgroup.fillMode =  kCAFillModeForwards;
        animationgroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [_cycleLayer addAnimation:animationgroup forKey:@"animationGroup"];
//        animationgroup.delegate = self;
        [animationgroup setValue:@"firstAnimation" forKey:@"id"];
        
         
        CABasicAnimation*  rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotateAnimation.fromValue = @0;
        rotateAnimation.toValue = @(M_PI * 2);
        rotateAnimation.repeatCount = MAXFLOAT;// 无限循环
        rotateAnimation.duration = _animationDuration * 4;
        [_cycleLayer addAnimation:rotateAnimation forKey:@"rotateAnimation"];
        
    }else{
        
        CABasicAnimation*  strokeEndAnimation =[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue = @(0);
        strokeEndAnimation.toValue = @0.93;
        strokeEndAnimation.fillMode = kCAFillModeForwards;
        [strokeEndAnimation setRemovedOnCompletion:NO];
        strokeEndAnimation.duration = 2.0*_animationDuration / 2.0 ;
        [_cycleLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
        
        
        CABasicAnimation*  rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotateAnimation.fromValue = @0;
        rotateAnimation.toValue = @(M_PI * 2);
        rotateAnimation.duration = _animationDuration;
        [rotateAnimation setRemovedOnCompletion:NO];
        rotateAnimation.beginTime = CACurrentMediaTime() + strokeEndAnimation.duration;
        rotateAnimation.repeatCount = MAXFLOAT;// 无限循环
        [_cycleLayer addAnimation:rotateAnimation forKey:@"rotateAnimation"];
        
    }
}
#pragma mark 动画暂停
-(void)stopAnimation{
    if (!_isLoading) {
        return;
    }
    _isLoading =YES;
    [self pauseLayer:_cycleLayer];
    
    
}
#pragma mark   动画结束
-(void)endAnimation{
    if (!_isLoading) {
        return;
    }
 
    if (_isLovely) {
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.lineWidth = _xlineWidth;
        shapeLayer.strokeColor = [[UIColor redColor] CGColor];
        shapeLayer.opacity = 1.0;
        shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        UIBezierPath *path = [UIBezierPath new];
        [path addArcWithCenter:_center radius:_outerRadius startAngle:-M_PI / 2.0 endAngle:M_PI / 2 * 3 clockwise:YES];
        shapeLayer.path = path.CGPath;
        
        
        [UIView animateWithDuration:0.2 animations:^{
            //        self.alpha =0;
            [self.layer addSublayer:shapeLayer];
            
        } completion:^(BOOL finished) {
            //        [self.cycleLayer removeAllAnimations];
            self.isLoading = NO;
        }];
    }else{
        
        CABasicAnimation*  strokeEndAnimation =[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        
        strokeEndAnimation.toValue = @1;
        strokeEndAnimation.fillMode = kCAFillModeForwards;
        [strokeEndAnimation setRemovedOnCompletion:NO];
        strokeEndAnimation.duration = _animationDuration*3.0 / 4.0 ;
        [_cycleLayer addAnimation:strokeEndAnimation forKey:@"catchStrokeEndAnimation"];
        
        [UIView animateWithDuration:0.2 animations:^{
//            self.alpha = 0;
            
        } completion:^(BOOL finished) {
//                    [self.cycleLayer removeAllAnimations];
            self.isLoading = NO;
        }];
        
    }
    
}


#pragma mark 暂停CALayer的动画
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    // 让CALayer的时间停止走动
    layer.speed = 0.0;
    // 让CALayer的时间停留在pausedTime这个时刻
    layer.timeOffset = pausedTime;
}

#pragma mark 恢复CALayer的动画
-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = layer.timeOffset;
    // 1. 让CALayer的时间继续行走
    layer.speed = 1.0;
    // 2. 取消上次记录的停留时刻
    layer.timeOffset = 0.0;
    // 3. 取消上次设置的时间
    layer.beginTime = 0.0;
    // 4. 计算暂停的时间(这里也可以用CACurrentMediaTime()-pausedTime)
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    // 5. 设置相对于父坐标系的开始时间(往后退timeSincePause)
    layer.beginTime = timeSincePause;
}




#pragma mark  正确打钩
-(void) setYes {
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.6;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0];
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    UIBezierPath *yesPath = [UIBezierPath bezierPath];
    CGFloat moveX = _center.x- _outerRadius*48.0/90.0;
    CGFloat moveY = _center.y+ _outerRadius*5.0/90.0;
    [yesPath moveToPoint:CGPointMake(moveX, moveY)];
    
    [yesPath addLineToPoint:CGPointMake(_center.x- _outerRadius*15.0/90.0,_center.y+ _outerRadius*36.0/90.0)];
    [yesPath addLineToPoint:CGPointMake(_center.x+ _outerRadius*48.0/90.0, _center.y- _outerRadius*26.0/90.0)];
    
    yesPath.lineWidth = 3.0;
    
    
    CAShapeLayer *yesProgressLayer = [CAShapeLayer layer];
    yesProgressLayer.lineWidth = self.xlineWidth;
    yesProgressLayer.lineCap = kCALineCapRound;
    yesProgressLayer.strokeColor = (_themeColor).CGColor;
    yesProgressLayer.fillColor = [UIColor clearColor].CGColor;
    yesProgressLayer.path = yesPath.CGPath;
    [yesProgressLayer addAnimation:pathAnimation forKey:nil];
    
    [self.layer addSublayer:yesProgressLayer];
}
#pragma mark  错误打叉
-(void) setError {

    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.5;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0];
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    UIBezierPath *yesPath = [UIBezierPath bezierPath];
    CGFloat moveX = _center.x - 1/4;
    CGFloat moveY = CGRectGetHeight(self.frame)/4;
    [yesPath moveToPoint:CGPointMake(moveX, moveY)];
    [yesPath addLineToPoint:CGPointMake(3 *moveX ,3 *moveY)];
    
    [yesPath moveToPoint:CGPointMake(3 * moveX, moveY)];
    [yesPath addLineToPoint:CGPointMake(moveX, 3 * moveY)];
    
    yesPath.lineWidth = 1.5;
    
    
    CAShapeLayer *yesProgressLayer = [CAShapeLayer layer];
    yesProgressLayer.lineWidth = self.xlineWidth;
    yesProgressLayer.lineCap = kCALineCapRound;
    yesProgressLayer.strokeColor = [UIColor blueColor].CGColor;
    yesProgressLayer.fillColor = [UIColor clearColor].CGColor;
    yesProgressLayer.path = yesPath.CGPath;
    [yesProgressLayer addAnimation:pathAnimation forKey:nil];
    
    [self.layer addSublayer:yesProgressLayer];
}

#pragma mark 底纹

-(void)createBackLine {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = _xlineWidth;
    shapeLayer.strokeColor = [LM_RGB(204, 204, 204) CGColor];
    shapeLayer.opacity = 1.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:_center radius:_outerRadius startAngle:-M_PI / 2.0 endAngle:M_PI / 2 * 3 clockwise:YES];
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
}



@end
