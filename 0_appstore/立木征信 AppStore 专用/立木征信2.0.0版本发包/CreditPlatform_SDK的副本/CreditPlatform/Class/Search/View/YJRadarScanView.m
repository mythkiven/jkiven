//
//  YJRadarScanView.m
//  testCycle
//
//  Created by yj on 16/8/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJRadarScanView.h"
@implementation MyStarView



@end


@interface YJRadarScanView ()
{
    UIImageView *_cycleView;
    
    UIImageView *_wordView;
    
    NSMutableArray *_starArr;
    
    CGFloat _angle;
    UIView *_scanView;
    
    int _a ;
    int _b;
}
@property (nonatomic, strong) CADisplayLink *link;

@end

@implementation YJRadarScanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _starArr = [NSMutableArray array];
        // 星星
        [self setupStar];
        
        
        
        
        // 雷达
        UIImageView *cycleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radar_cycle"]];
        _cycleView = cycleView;
        [self addSubview:cycleView];
        self.clipsToBounds = YES;
        
        _scanView = [[UIView alloc] init];
        _scanView.backgroundColor = [UIColor clearColor];
//        _scanView.alpha = 0.3;
        [cycleView addSubview:_scanView];
        
   
        UIImageView *wordView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_banner_word"]];
        _wordView = wordView;
        [self addSubview:wordView];
        
        

        
    }
    return self;
}




- (void)setupStar {
    //1
    CGFloat margin = 0;
    if (iPhone4s || iPhone5) {
        margin = 20.5;
    }
    [self creatStarImageName:@"point_7" frame:CGRectMake(140.5-margin, 181-margin, 3.5, 3.5)];
    [self creatStarImageName:@"point_10" frame:CGRectMake(209.5-margin, 176.5-margin, 5, 5)];
    [self creatStarImageName:@"point_14" frame:CGRectMake(183-margin, 190.5-margin, 7, 7)];

    //2
    [self creatStarImageName:@"point_7" frame:CGRectMake(80.5-margin, 68.5, 3.5, 3.5)];
    [self creatStarImageName:@"point_10" frame:CGRectMake(95.5-margin, 56.5, 5, 5)];

    //3
    [self creatStarImageName:@"point_7" frame:CGRectMake(249.5-margin, 53.5, 3.5, 3.5)];
    [self creatStarImageName:@"point_10" frame:CGRectMake(257-margin, 32.5, 5, 5)];
    [self creatStarImageName:@"point_14" frame:CGRectMake(287.5-margin, 40, 7, 7)];
    
 
}


- (MyStarView *)creatStarImageName:(NSString *)name frame:(CGRect)frame  {
    
    MyStarView *star = [[MyStarView alloc] initWithImage:[UIImage imageNamed:name]];
    star.alpha = 0;
    star.frame = frame;
    [self addSubview:star];
    star.layer.cornerRadius = frame.size.width * 0.5;
    star.clipsToBounds = YES;
    [_starArr addObject:star];
    return star;
    
}







- (void)rotating {
    // M_PI/270 一圈9s  M_PI/240 一圈8s
    _cycleView.transform = CGAffineTransformRotate(_cycleView.transform, M_PI/225);
    
    
//    CGRect rect = [_cycleView convertRect:_scanView.frame toView:self];
    
    
    
    CGRect rect1 = [self convertRect:_scanView.frame fromView:_cycleView];

    
    for (int i = 0; i < _starArr.count; i ++) {
        MyStarView *star = _starArr[i];
        

//        CGRect rect1 = [self convertRect:star.frame toView:_cycleView];
//        if (CGRectContainsRect(_scanView.frame, rect1)) {
        
        if (CGRectContainsPoint(rect1, star.center)) {
            star.isAnimating = YES;

            [UIView animateWithDuration:1.5 animations:^{
                star.alpha = 1;
                
                star.transform = CGAffineTransformScale(star.transform, 1.005, 1.005);
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:1.5 animations:^{
                    star.transform = CGAffineTransformScale(star.transform, 0, 0);
                } completion:^(BOOL finished) {
                    star.isAnimating = NO;
                    star.alpha = 0;
                    star.transform = CGAffineTransformIdentity;
                }];
                
            }];
        }
    }
    
    

    
}
- (void)startRadarScan {
    if (self.link) return;
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotating)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.link = link;
}

- (void)stopRadarScan  {
    if (self.link) {
        [self.link invalidate];
        self.link = nil;
    }
    
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [[UIImage imageNamed:@"bg_banner"] drawInRect:rect];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    _cycleView.centerX = self.centerX;
    _cycleView.centerY = self.centerY +64;
    _cycleView.bounds = CGRectMake(0, 0, 281, 281);
    
    _scanView.frame = CGRectMake(281*.5, 281*.5-10, 281*.5, 10);

    
    _wordView.centerX = self.centerX;
    _wordView.centerY = self.centerY +64+30;
    _wordView.bounds = CGRectMake(0, 0, 298, 33);
    
}



#pragma mark-- 废弃
- (void)animation1:(UIImageView *)star {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0),@(0.4),@(0.8),@(1.1),@(1.1),@(0.5),@(0)];
    animation.removedOnCompletion = YES;
    
    animation.fillMode = kCAFillModeRemoved;
    
    animation.duration = 0.5f;
    animation.delegate = self;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [star.layer addAnimation:animation forKey:nil];
    
    
    
}


- (void)animation:(UIImageView *)star {
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.fromValue = @(0);
    
    anim.toValue = @(1.1);
    anim.removedOnCompletion = YES;
    anim.fillMode = kCAFillModeForwards;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 2.0;
    anim.repeatCount = 1;
    anim.delegate = self;
    [star.layer addAnimation:anim forKey:nil];
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSLog(@"------animationDidStop");
    
    
    //    for (int i = 0; i < 8; i ++) {
    //        UIImageView *star = _starArr[i];
    ////        star.alpha = 0;
    //        [star.layer removeAllAnimations];
    //    }
    
}

@end
