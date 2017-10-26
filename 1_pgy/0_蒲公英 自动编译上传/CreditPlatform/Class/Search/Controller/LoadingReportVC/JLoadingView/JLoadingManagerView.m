//
//  JLoadingManagerView.m
//  JCombineLoadingAnimation
//
//  Created by https://github.com/mythkiven/ on 15/01/18.
//  Copyright © 2015年 mythkiven. All rights reserved.
//

#import "JLoadingManagerView.h"

#import "JControlLoadingCircleView.h"


@interface JLoadingManagerView ()


@property (nonatomic, strong)   JControlLoadingCircleView   *progress;
@property (nonatomic,strong)    NSMutableArray              *layerContainer;
@property (nonatomic,strong)    NSMutableDictionary         *timerContainer;



@property (nonatomic,strong)    UILabel *titleLabel;
@property (nonatomic,strong)    NSTimer *timer;

@property (nonatomic, strong) CADisplayLink *link;

@end


@implementation JLoadingManagerView
{
    UIImageView *_LoadingView;
    CGFloat                 sumPer;
    
    CGFloat time;
    CGFloat totalTime;
    BOOL on;
    BOOL isSP;
    
}
- (NSMutableDictionary *)timerContainer {
    if (!_timerContainer) {
        _timerContainer = [[NSMutableDictionary alloc] init];
    }
    return _timerContainer;
}

- (instancetype)init {
     if (self= [super init]) {
        [self defaultInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
     if (self= [super initWithFrame:frame]) {
        [self defaultInit];
    }
    return self;
}


-(void)defaultInit{
    
    
    self.progressLabel = [[UIButton alloc] initWithFrame: CGRectMake((self.bounds.size.width - 100)/2, (self.bounds.size.height + 20)/2, 134/2, 40)];
    [self.progressLabel setTitle:@"0%" forState:UIControlStateNormal];
    [self.progressLabel setTitleColor: RGB(85, 255, 0)  forState:UIControlStateNormal];
    self.progressLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.progressLabel.titleLabel.font = Font30;
    [self.progressLabel.titleLabel jSetAttributedStringRange:NSMakeRange(self.progressLabel.titleLabel.text.length-1, 1) Color:RGB(85, 255, 0) Font:Font15];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width - 160)/2, (self.bounds.size.height - 100)/2, 200, 30)];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    self.titleLabel.text =  @"账户登录中";
    self.titleLabel.textColor = RGB_white;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = Font30;
    
    
    // loading
    _progress = [[JControlLoadingCircleView alloc] initWithFrame:CGRectMake(0, 0, 570/2, 570/2)];
    _progress.backgroundColor = [UIColor clearColor];
    
    _progress.outerRadius =  508/4;
    _progress.innerRadius =  (508-16)/4;
    _progress.clockwise = YES;
    _progress.beginAngle = 360;
    
    _progress.trackColor = RGBA(255, 255, 255, 0.1);
    _progress.progressColor = RGB(85, 255, 0);
    
    _progress.gapAngle = 2;
    _progress.dotCount = 100;
    
    
    
    _progress.minValue = 0;
    _progress.maxValue = 100;
    _progress.currentValue = 0;
    
    
    
    // loading
    _LoadingView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homeLoading_Bg"]];
    _LoadingView.clipsToBounds = YES;
    [self addSubview:_LoadingView];
    
    [self addSubview:_progress];
    [self addSubview:self.progressLabel];
    [self addSubview:self.titleLabel];
    
    time=0;
    sumPer =100;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat y = 200;
    _progress.center =  CGPointMake(SCREEN_WIDTH/2, y);
    _progressLabel.center = CGPointMake(SCREEN_WIDTH/2, y+36+15);
    _titleLabel.center = CGPointMake(SCREEN_WIDTH/2, y-15);
    _LoadingView.center =  CGPointMake(SCREEN_WIDTH/2, y);
    _LoadingView.bounds = CGRectMake(0, 0, 281, 281);
    
}

-(void)setTitle:(NSString *)title{
    _title =title;
    _titleLabel.text = title;
}



# pragma mark - 控制
-(void)beginAnimationCompleteBlock:(jLoadingCompleteBlock)completeblock{
    isSP =YES;
    totalTime = 0;
    time = 0;
    [self startRotating];
    [self startAnimationWithPercent:0 endPercent:20 duration:24 completeBlock:completeblock];
}
-(void)reBeginAnimationCompleteBlock:(jLoadingCompleteBlock)completeblock{
    
    [self startRotating];
    if(totalTime<=24){
        [self startAnimationWithPercent:_progress.currentValue endPercent:20 duration:24-totalTime completeBlock:completeblock];
    }else if(totalTime>=24&&totalTime<=60){
        
        [self startAnimationWithPercent:_progress.currentValue endPercent:99 duration:60-totalTime completeBlock:completeblock];
    }else if(totalTime>60){
        
    }
    
}
-(void)endAnimation{
    
    [self cancelTimerWithName:@"timeNEW"];
    [self stopRotating];
    
}

-(void)successAnimation:(jLoadingCompleteBlock)completeblock{
    if (totalTime<=61) {
        [self cancelTimerWithName:@"timeNEW"];
        [self startAnimationWithPercent:_progress.currentValue endPercent:99 duration:4 completeBlock:nil];
        [self performSelector:@selector(overAinma:) withObject:completeblock afterDelay:5];
    }else{
        _progress.currentValue = 100;
        self.title = @"成功获取报告";
        [_progressLabel setImage:[UIImage imageNamed:@"homeLoading_Hook"] forState:UIControlStateNormal];
        [self cancelTimerWithName:@"timeNEW"];
        if (completeblock) {
            completeblock();
        }
    }
    
}
-(void)overAinma:(jLoadingCompleteBlock)completeblock{
    _progress.currentValue = 100;
    self.title = @"成功获取报告";
    [_progressLabel setImage:[UIImage imageNamed:@"homeLoading_Hook"] forState:UIControlStateNormal];
    [self cancelTimerWithName:@"timeNEW"];
    [self performSelector:@selector(backData:) withObject:completeblock afterDelay:0.5];
}
-(void)backData:(jLoadingCompleteBlock)completeblock{
    if (completeblock) {
        completeblock();
    }
}
# pragma mark -


-(void)startAnimationWithPercent:(CGFloat)end duration:(CGFloat)duration completeBlock:(jLoadingCompleteBlock)completeblock{
    [self startRotating];
    [self startAnimationWithPercent:0 endPercent:end duration:duration completeBlock:completeblock];
    
}

-(void)startAnimationWithPercent:(CGFloat)begin endPercent:(CGFloat)end duration:(CGFloat)duration completeBlock:(jLoadingCompleteBlock)completeblock{
    
    [self cancelTimerWithName:@"timeNEW"];
    __weak typeof(self) weakSelf = self;
    
    if(isSP){// 启用专用
        CGFloat timee =(CGFloat) (end-begin) / (_progress.maxValue/_progress.dotCount);
        
        [self scheduledDispatchTimerWithName:@"timeNEW" timeInterval:duration/timee queue:nil repeats:YES action:^{
            
            totalTime +=duration/timee;
            time +=duration/timee;
            [weakSelf settingValue:(_progress.maxValue/_progress.dotCount)];
            
            CGFloat value = _progress.currentValue;
            if (value>= sumPer) {
                if (completeblock) completeblock();
                
                
                return;
            }
            
        }];
        
    }else{//通用
        if ((end-begin)/duration<=_progress.maxValue/_progress.dotCount) {
            [self scheduledDispatchTimerWithName:@"timeNEW" timeInterval:1 queue:nil repeats:YES action:^{
                
                [weakSelf settingValue:(CGFloat)(end-begin)/duration];
                
                CGFloat value = _progress.currentValue;
                if (value>= sumPer) {
                    if (completeblock) completeblock();
                    return;
                }
                
            }];
            
        } else if ( (end-begin)/duration>_progress.maxValue/_progress.dotCount) {
            CGFloat timee =(CGFloat) (end-begin) / (_progress.maxValue/_progress.dotCount);
            
            [self scheduledDispatchTimerWithName:@"timeNEW" timeInterval:duration/timee queue:nil repeats:YES action:^{
                
                [weakSelf settingValue:(_progress.maxValue/_progress.dotCount)];
                
                CGFloat value = _progress.currentValue;
                if (value>= sumPer) {
                    if (completeblock) completeblock();
                    
                    
                    return;
                }
                
            }];
            
        }
    }
}

-(void)startAnimationCompleteBlock:(jLoadingCompleteBlock)completeblock{
//    [self startRotating];
//    [self startAnimationWithPercent:_progress.currentValue endPercent:stopEnd duration:stopDuration completeBlock:completeblock];
//    
    
}



# pragma mark 设置数值


-(void)settingValue:(CGFloat)sum{
    CGFloat value = _progress.currentValue;
    
    if (isSP) {
        
        if (value< 20) {
            
            _progress.currentValue = value + sum;
            [_progressLabel setTitle:[NSString stringWithFormat:@"%ld%%",(long)_progress.currentValue] forState:UIControlStateNormal];
            [self.progressLabel.titleLabel jSetAttributedStringRange:NSMakeRange(self.progressLabel.titleLabel.text.length-1, 1) Color:RGB(85, 255, 0) Font:Font15];
            
        }else if (value >=20 &&value <21 &&!on) {
            [self cancelTimerWithName:@"timeNEW"];
            self.title = @"数据获取中";
            on = YES;
            [self startAnimationWithPercent:21 endPercent:99 duration:36 completeBlock:nil];
            
        }else if (value >=20 && value<=98) {
            
            _progress.currentValue = value + sum;
            [_progressLabel setTitle:[NSString stringWithFormat:@"%ld%%",(long)_progress.currentValue] forState:UIControlStateNormal];
            [self.progressLabel.titleLabel jSetAttributedStringRange:NSMakeRange(self.progressLabel.titleLabel.text.length-1, 1) Color:RGB(85, 255, 0) Font:Font15];
        }else if (value>=99 ) {
            
        }
        
    } else {
        if (value>= sumPer) {
            [self cancelTimerWithName:@"timeNEW"];
            return;
        }
        _progress.currentValue = value + sum;
        [_progressLabel setTitle:[NSString stringWithFormat:@"%ld%%",(long)_progress.currentValue] forState:UIControlStateNormal];
        [self.progressLabel.titleLabel jSetAttributedStringRange:NSMakeRange(self.progressLabel.titleLabel.text.length-1, 1) Color:RGB(85, 255, 0) Font:Font15];
        
        if (_progress.currentValue>=100) {
            
            [_progressLabel setImage:[UIImage imageNamed:@"homeLoading_Hook"] forState:UIControlStateNormal];
        }
    }
    
}



# pragma mark - 定时器
- (void)scheduledDispatchTimerWithName:(NSString *)timerName
                          timeInterval:(double)interval
                                 queue:(dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                                action:(dispatch_block_t)action
{
    if (nil == timerName)
        return;
    
    if (nil == queue)
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        [self.timerContainer setObject:timer forKey:timerName];
    }
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            action();
        });
        
        if (!repeats) {
            [weakSelf cancelTimerWithName:timerName];
        }
    });
    
}

# pragma mark 暂停
- (void)cancelTimerWithName:(NSString *)timerName {
    dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
    
    if (!timer) {
        return;
    }
    
    [self.timerContainer removeObjectForKey:timerName];
    dispatch_source_cancel(timer);
    
}


# pragma mark - 设置旋转的图片

- (void)startRotating {
    if (self.link){
        return;
    }
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotating)];
    link.frameInterval =1;
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.link = link;
}

- (void)stopRotating  {
    if (self.link) {
        [self.link invalidate];
        self.link = nil;
    }
    
}
- (void)rotating {
    // 1s1圈:::1/60s 6°
    _LoadingView.transform = CGAffineTransformRotate(_LoadingView.transform, 6*(M_PI/180));
    
}




@end
