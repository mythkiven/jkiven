//
//  JLoadingManagerView.m
//  JCombineLoadingAnimation
//
//  Created by https://github.com/mythkiven/ on 15/01/18.
//  Copyright © 2015年 mythkiven. All rights reserved.
//

#import "LMZXLoadingManagerView.h"

#import "LMZXLoadingAnimation.h"

#import "UILabel+LMZXExtension.h"
#import "LMZXSDK.h"
#import "LMZXDemoAPI.h"

#define lmzxFont15vc [UIFont systemFontOfSize:15]
#define lmzxfirstLength  self.progressButton.titleLabel.text.length

#define lmzxNSTimeNew @"lmzxNSTimeNew"

// 最短时长
#define lmzxMinTime  0.2

// 预留的动画时长
#define lmzxAnimaTime  1.0

// 1阶段时长
static CGFloat  firstProgressTime;
// 2阶段时长
static  CGFloat twoProgressTime;
// 总时长
static CGFloat  totalProgressTime;

// 以下为正常情况下的提示语:
// 1阶段主提示语
static NSString*  MainHint1;
// 2阶段主提示语
static NSString*  MainHint2;
// 3阶段主提示语
static NSString*  MainHint3;
// 1阶段副提示语
static NSString* detailHint1;
// 2阶段副提示语
static NSString* detailHint2;
// 3阶段副提示语
static NSString* detailHint3;


// 以下是:出现超时未获取数据的情况,
static NSString* detailHint4;

// 1阶段进度
static CGFloat firstProgressValue;




@interface LMZXLoadingManagerView ()

// 待设置 具体时间
@property (assign,nonatomic) CGFloat      *title;

// 主题颜色
@property (strong,nonatomic)  UIColor      *themeColor;

/** 主提示label*/
@property (nonatomic,strong)    UILabel *mainHintLabel;
/** 副提示label */
@property (nonatomic,strong)    UILabel *detailHintLabel;

// 百分比 BUtton
@property (nonatomic,strong) UIButton  *progressButton;
// 进度 1,2,
@property (nonatomic, assign)   CGFloat  progress;
// 进度动画
@property (nonatomic, strong)   LMZXLoadingAnimation    *loadingAnimation;
// 外半径
@property (nonatomic, assign) CGFloat  outerRadius;
// 线宽
@property (nonatomic,assign) CGFloat  xlineWidth;

@property (nonatomic,strong)    NSMutableArray              *layerContainer;
@property (nonatomic,strong)    NSMutableDictionary         *timerContainer;


@property (nonatomic,strong)    NSTimer *timer;

@property (nonatomic, strong)  CADisplayLink *link;

@end


@implementation LMZXLoadingManagerView
{
    //    CGFloat time;
    
    
    // 总的百分比
    CGFloat                 sumPer;
    
    // 真实的总时间
    CGFloat totalTime;
    
//    BOOL _on;
    BOOL _isSuccess;// 标记成功
    BOOL  firstProgressEntr ;
    BOOL  twoProgressEntr ;
}



#pragma mark - 配置默认值,成功推出
- (void)setBusinessDefault{
    firstProgressEntr = NO;
    twoProgressEntr  = NO;
    
    firstProgressTime = 15;
    twoProgressTime = 30;
    firstProgressValue = 20;
    totalProgressTime = firstProgressTime+ twoProgressTime;
    MainHint1 = @"提交中...";
    MainHint2 = @"数据获取中...";
    MainHint3 = @"成功获取数据";
    detailHint1 = @"";
    detailHint2 = @"";
    detailHint3 = @"";
    detailHint4 = @"查询即将完成,请耐心等待...";
}

#pragma mark  登录推出
- (void)setBusinessTwo{
    firstProgressTime = 20;
    twoProgressTime = lmzxMinTime;
    firstProgressValue = 99;
    totalProgressTime = firstProgressTime+ twoProgressTime;
    MainHint1 = @"提交中...";
    MainHint2 = @"提交中...";
    MainHint3 = @"登录成功";
    detailHint1 = @"";
    detailHint2 = @"";
    detailHint3 = @"";
    detailHint4 = @"查询即将完成,请耐心等待...";
}

-(void)setLoginTime:(CGFloat)LoginTime{
    _LoginTime = LoginTime;
    
    if ([LMZXSDK shared].lmzxQuitOnSuccess==NO) {
        firstProgressTime = LoginTime*20/100;
        twoProgressTime = LoginTime*80/100;
        totalProgressTime = LoginTime;
        
    } else {
        firstProgressTime = LoginTime;
        if (_checkDataTime&&_LoginTime) {
            totalProgressTime = firstProgressTime+ twoProgressTime;
        }
    }
    
}
-(void)setCheckDataTime:(CGFloat)checkDataTime{
    _checkDataTime = checkDataTime;
    if ([LMZXSDK shared].lmzxQuitOnSuccess==NO) {
        
    }else {
        twoProgressTime = checkDataTime;
        if (_checkDataTime&&_LoginTime) {
            totalProgressTime = firstProgressTime+ twoProgressTime;
        }
    }
    
}
-(void)setLoginValue:(CGFloat)LoginValue{
    _LoginValue = LoginValue;
    firstProgressValue = LoginValue;
}

-(void)setIsLoginSuccess:(BOOL)isLoginSuccess{
    _isLoginSuccess = isLoginSuccess;
}

#pragma mark - 初始化
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
    // 登录退出
    if ([LMZXSDK shared].lmzxQuitOnSuccess==NO) {
        [self setBusinessTwo];
    }
    // 成功退出
    else if ([LMZXSDK shared].lmzxQuitOnSuccess) {
        [self setBusinessDefault];
    }
    
    
    _isSuccess =NO;
    self.layer.contentsScale=[[UIScreen mainScreen] scale];
    _outerRadius = 45;
    _progress = 0.0;
    _xlineWidth = 1.5;
    if ([LMZXSDK shared].lmzxProtocolTextColor) {
        _themeColor = [LMZXSDK shared].lmzxProtocolTextColor;
    }else{
        _themeColor = [UIColor blueColor];
    }
    
    
    CGFloat centerX = self.center.x;
    CGFloat centerY = self.center.y;
    
    // loading 动画
    _loadingAnimation =  [[LMZXLoadingAnimation alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width) lineWidth:_xlineWidth color:_themeColor radius:_outerRadius];
    
    _loadingAnimation.backgroundColor = [UIColor clearColor];
    
    
    // 百分比 Btn
    self.progressButton = [[UIButton alloc] initWithFrame: CGRectMake(centerX, centerY, 65, 40)];
    [self.progressButton setTitle:@"0%" forState:UIControlStateNormal];
    [self.progressButton setTitleColor:_themeColor  forState:UIControlStateNormal];
    self.progressButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.progressButton.titleLabel.font = [UIFont systemFontOfSize:30];
    
    [self.progressButton.titleLabel jSetAttributedStringRange:NSMakeRange(lmzxfirstLength-1, 1) Color:_themeColor Font:lmzxFont15vc];
    
    
    // 主提示
    self.mainHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(centerX, centerY+50, 200, 30)];
    [self.mainHintLabel setTextColor:[UIColor whiteColor]];
    self.mainHintLabel.text =  MainHint1 ;
    self.mainHintLabel.textColor = [UIColor blackColor];
    self.mainHintLabel.textAlignment = NSTextAlignmentCenter;
    self.mainHintLabel.font = [UIFont systemFontOfSize:18];
    
    // 副提示
    self.detailHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(centerX,centerY+50+10+10, 300, 30)];
    [self.detailHintLabel setTextColor:[UIColor whiteColor]];
    self.detailHintLabel.text = detailHint1;
    self.detailHintLabel.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
    self.detailHintLabel.textAlignment = NSTextAlignmentCenter;
    self.detailHintLabel.font = [UIFont systemFontOfSize:13];
    
    
    [self addSubview:self.loadingAnimation];
    [self addSubview:self.progressButton];
    [self addSubview:self.mainHintLabel];
    [self addSubview:self.detailHintLabel];
    
    
    sumPer =100;
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat centerX = self.center.x;
    CGFloat centerY = self.center.y;
    
    _loadingAnimation.center =  CGPointMake(centerX, centerY);
    _progressButton.center = CGPointMake(centerX, centerY);
    _mainHintLabel.center = CGPointMake(centerX, centerY+_outerRadius+10+_mainHintLabel.bounds.size.height/2);
    _detailHintLabel.center =  CGPointMake(centerX, CGRectGetMaxY(_mainHintLabel.frame)+5+_detailHintLabel.bounds.size.height/2);
    
}



-(void)setThemeColor:(UIColor *)themeColor{
    
    _themeColor = themeColor;
    [_progressButton setTitleColor:themeColor forState:UIControlStateNormal];
}


# pragma mark -  控制动画模式





# pragma mark - 控制
# pragma mark 开始动画
-(void)beginAnimationCompleteBlock:(jLoadingCompleteBlock)completeblock{
    //LMLog(@"==开始动画 -40=====%lf ==%lf ",_progress,firstProgressTime);
    totalTime = 0;
    [_loadingAnimation startLoading];
    // 启动1阶段
    [self startAnimationWithPercent:0 endPercent:firstProgressValue duration:firstProgressTime completeBlock:completeblock];
    
}
# pragma mark 重新开始动画
-(void)reBeginAnimationCompleteBlock:(jLoadingCompleteBlock)completeblock{
    
    //LMLog(@"==重新开始动画 -41=====%lf",_progress);
    //LMLog(@"==重新开始动画 -41=====%lf===%lf====%lf",totalProgressTime,totalTime,firstProgressTime);
    
     [_loadingAnimation startLoading];
    // 阶段1
    if(_progress < firstProgressValue ){
        
        if (  totalTime<=firstProgressTime) {
            //LMLog(@"==1");
            [self startAnimationWithPercent:_progress endPercent:firstProgressValue duration:firstProgressTime-totalTime completeBlock:completeblock];
        } else {
            //LMLog(@"==1==-");
            [self startAnimationWithPercent:_progress endPercent:firstProgressValue duration:lmzxAnimaTime completeBlock:completeblock];
        }
        
    }
    // 阶段2
    else if(_progress >= firstProgressValue){
        if (totalTime<=totalProgressTime) {
            //LMLog(@"==2");
            [self startAnimationWithPercent:_progress endPercent:99 duration:totalProgressTime-totalTime completeBlock:completeblock];
        } else {
            //LMLog(@"==2==-");
            [self startAnimationWithPercent:_progress endPercent:99 duration:lmzxAnimaTime completeBlock:completeblock];
        }
        
    }
    // 阶段3
    else if(_progress>99){
//        //LMLog(@"==3");
        
    }
    
}
# pragma mark 暂停动画
-(void)endAnimation{
    //LMLog(@"==暂停动画 -1=====%lf",_progress);
    //LMLog(@"==暂停动画 -2=====%lf===%lf====%lf",totalProgressTime,totalTime,firstProgressTime);
    [_loadingAnimation  stopAnimation];
    [self cancelTimerWithName:lmzxNSTimeNew];
    
}

# pragma mark 成功动画:从当前快进到100%
-(void)successAnimation:(jLoadingCompleteBlock)completeblock{
    //LMLog(@"==成功动画 -42=====%lf",_progress);
    
    _isSuccess =YES;
    
    // 没到99,已经成功...那么快进
    if (_progress<99) {
        __block typeof(self) sself =self;
        [self cancelTimerWithName:lmzxNSTimeNew];
        [self startAnimationWithPercent:_progress endPercent:100 duration:lmzxMinTime completeBlock:^{
            
        }];
        [sself performSelector:@selector(overAinma:) withObject:completeblock afterDelay:lmzxMinTime+lmzxMinTime];
    }else{
        // 到了99...直接成功
        _progress = 100;
        self.mainHintLabel.text = MainHint3;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setSuccessAnimation];
            [self cancelTimerWithName:lmzxNSTimeNew];
            [self performSelector:@selector(overSuccess:) withObject:completeblock afterDelay:lmzxAnimaTime/2];
            
        });
    }
}
-(void)overSuccess:(jLoadingCompleteBlock)completeblock{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (completeblock) {
            completeblock();
        }
    });
}
# pragma mark 快速快进100
-(void)overAinma:(jLoadingCompleteBlock)completeblock{
    _isSuccess =NO;
    _progress = 100;
    self.mainHintLabel.text = MainHint3;
    
    [_progressButton setTitle:@"" forState:UIControlStateNormal];
    dispatch_async(dispatch_get_main_queue(), ^{
        //
        [self setSuccessAnimation];
    });
    
    [self cancelTimerWithName:lmzxNSTimeNew];
    [self performSelector:@selector(overSuccess:) withObject:completeblock afterDelay:lmzxAnimaTime/2];
}

# pragma mark 成功动画
-(void)setSuccessAnimation{
    
     self.mainHintLabel.text = MainHint3;
     self.detailHintLabel.text = detailHint3;
     [_progressButton setTitle:@"" forState:UIControlStateNormal];
     [_progressButton setTitle:@"" forState:UIControlStateSelected];
     [_loadingAnimation endAnimation];
     [_loadingAnimation setYes];
     firstProgressEntr = NO;
     twoProgressEntr = NO;
     totalTime = 0;
     _isSuccess =NO;
   
}

# pragma mark -


-(void)startAnimationWithPercent:(CGFloat)end duration:(CGFloat)duration completeBlock:(jLoadingCompleteBlock)completeblock{
    [self startAnimationWithPercent:0 endPercent:end duration:duration completeBlock:completeblock];
    
}

-(void)startAnimationWithPercent:(CGFloat)begin endPercent:(CGFloat)end duration:(CGFloat)duration completeBlock:(jLoadingCompleteBlock)completeblock{
    
    [self cancelTimerWithName:lmzxNSTimeNew];
    __weak typeof(self) weakSelf = self;
    
        CGFloat timee =(CGFloat) (end-begin) / (100/100);
    
    //LMLog(@"==添加定时器 -=-=====%lf end===%lf  begin===%lf  duration====%lf",_progress,end,begin,duration);
    
        [self scheduledDispatchTimerWithName:lmzxNSTimeNew timeInterval:duration/timee queue:nil repeats:YES action:^{
            
            totalTime += duration/timee;
            [weakSelf settingValue:(100/100)];
            
            CGFloat value = _progress;
            
            //LMLog(@"==定时器=======%lf ====%lf ====%lf",_progress,totalTime,duration/timee);
            
            if (value>= sumPer) {
                if (completeblock) completeblock();
                //LMLog(@"==++++");
                return;
            }
            
            
            
        }];
    
}


# pragma mark 设置数值



-(void)settingValue:(CGFloat)sum{
    
    //LMLog(@"====%lf===%lf",sum,_progress);
    //LMLog(@"==ttt -0=====%lf  ==%d",totalTime,_isSuccess);
    CGFloat value = _progress;
    
    
    
    
    // 0< x <20
    if (value< firstProgressValue) {
        
        _progress = value + sum;
        [self settitle1];
        
        // 登录成功
        if (self.isLoginSuccess && !firstProgressEntr) {
            self.mainHintLabel.text =  MainHint2;
            self.detailHintLabel.text = detailHint2;
            [self cancelTimerWithName:lmzxNSTimeNew];
            firstProgressEntr = YES;
            if ([LMZXSDK shared].lmzxQuitOnSuccess==NO) { // 变更业务模式
                [self startAnimationWithPercent:_progress endPercent:100 duration:twoProgressTime completeBlock:nil];
            }else{ // 变更业务模式
                [self startAnimationWithPercent:_progress endPercent:99 duration:twoProgressTime completeBlock:nil];
            }
        }
        
        
    }
    // 20<= x <21
    else if (value >=firstProgressValue &&value <firstProgressValue+1 &&!twoProgressEntr) {
        
        // ==20  登录成功
        if (self.isLoginSuccess) {
            //LMLog(@"+_+_3333_");
            self.mainHintLabel.text =  MainHint2;
            self.detailHintLabel.text = detailHint2;
        }
        
        // ==20  成功获取数据
        if(_isSuccess){
            //LMLog(@"+_+_1111_");
            [self cancelTimerWithName:lmzxNSTimeNew];
            self.mainHintLabel.text = MainHint3;
            self.detailHintLabel.text = detailHint3;
            twoProgressEntr = YES;
            [self startAnimationWithPercent:firstProgressValue+1 endPercent:100 duration:lmzxMinTime completeBlock:nil];
        }
        
        else{ // 正常的二阶段 数据获取中的状态,由登录成功控制
            //LMLog(@"+_+_2222_");
            [self cancelTimerWithName:lmzxNSTimeNew];
//            self.mainHintLabel.text = MainHint2;
            twoProgressEntr = YES;
            [self startAnimationWithPercent:firstProgressValue+1 endPercent:99 duration:twoProgressTime completeBlock:nil];
        }
        
    }
    // 阶段2
    else if (value >=firstProgressValue && value<=98) {
        _progress = value + sum;
        [self settitle1];
        // 登录成功
        if (self.isLoginSuccess) {
            self.mainHintLabel.text =  MainHint2;
            self.detailHintLabel.text = detailHint2;
        }
        
    }
    // 阶段3
    else if (value>=99 ) {
        if (_isSuccess) {
            
            _progress = 100;
            self.mainHintLabel.text =  MainHint2;
            self.detailHintLabel.text = detailHint2;
            [self settitle1];
        }else if (totalTime>totalProgressTime) {
            self.mainHintLabel.text =  MainHint2;
            self.detailHintLabel.text = detailHint4;
        }
    }

}

// 阶段
-(void)settitle1{
    [_progressButton setTitle:[NSString stringWithFormat:@"%ld%%",(long)_progress] forState:UIControlStateNormal];
    [self.progressButton.titleLabel jSetAttributedStringRange:NSMakeRange(lmzxfirstLength-1, 1) Color:self.themeColor Font:lmzxFont15vc];
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


# pragma  mark -  很少使用

# pragma mark 登录成功结束动画:从当前快进到100%
-(void)loginSuccessAnimation:(jLoadingCompleteBlock)completeblock{
    
    if (totalTime<=totalProgressTime+1) {
        __block typeof(self) sself =self;
        [self cancelTimerWithName:lmzxNSTimeNew];
        [self startAnimationWithPercent:_progress endPercent:100 duration:lmzxMinTime completeBlock:^{
            
        }];
        [sself performSelector:@selector(overAinma:) withObject:completeblock afterDelay:lmzxMinTime+lmzxMinTime];
    }else{
        _progress = 100;
        self.mainHintLabel.text = MainHint3;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setSuccessAnimation];
            
            [self cancelTimerWithName:lmzxNSTimeNew];
            if (completeblock) {
                completeblock();
            }});
    }
}


@end
