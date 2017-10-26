//
//  YJAuthTipView.m
//  CreditPlatform
//
//  Created by yj on 2017/6/16.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import "YJAuthTipModalView.h"
#import "YJAuthTipContentView.h"

//SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
//#define SCREEN_HEIGHT
#define kImgViewH 250

#define kTranslationY ((SCREEN_HEIGHT - kImgViewH) * 0.5)



@interface YJAuthTipModalView ()<YJAuthTipContentViewDelegate>
@property (nonatomic, strong) YJAuthTipContentView *authTipContentView;
@property (nonatomic, strong) UIButton *cover;

@end


@implementation YJAuthTipModalView

- (instancetype)init {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        
        
        UIButton *cover = [[UIButton alloc] init];
        cover.backgroundColor = [UIColor blackColor];
        [self addSubview:cover];
        cover.alpha = 0.3;
        self.cover = cover;
        
        
        
        
        [self setupSubViewss];
        
        
        
        
    }
    return self;
}




- (void)setupSubViewss {
    
    
    
    _authTipContentView = [[YJAuthTipContentView alloc] init];
    [self addSubview:_authTipContentView];
    _authTipContentView.delegate = self;
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPicView:)];
    [_authTipContentView addGestureRecognizer:pan];
    
}


- (void)panPicView:(UIPanGestureRecognizer *)pan {
    
    CGPoint transPoint = [pan translationInView:_authTipContentView];
    
    CGPoint point = _authTipContentView.center;
    
    
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            
            
            
            break;
        case UIGestureRecognizerStateChanged:
            
            if (pan.view.frame.origin.y < kTranslationY) {
                point.y += transPoint.y * 0.2;
            } else {
                point.y += transPoint.y;
                
            }
            
            _authTipContentView.center = point;
            
            [pan setTranslation:CGPointZero inView:pan.view];
            
            
            break;
        case UIGestureRecognizerStateEnded:
        {
            
            if (pan.view.frame.origin.y >= kScreenH * 0.5) {
                [self authTipContentViewDidClose:_authTipContentView];
                
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    _authTipContentView.transform = CGAffineTransformTranslate(_authTipContentView.transform, 0, kTranslationY - pan.view.frame.origin.y);
                    
                }];
            }
            
            
            
            break;
        }
            
        default:
            break;
    }
    
    
    
    
    
    
    
    
}



- (void)layoutSubviews {
    [super layoutSubviews];
    self.cover.frame = self.bounds;
}

- (void)showInRect:(CGRect)rect {
    
    self.authTipContentView.authStatus = [kUserManagerTool authStatus];
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    
    CGFloat imgViewW = 280;
    CGFloat imgViewH = kImgViewH;
    CGFloat imgViewX = (kScreenW - imgViewW) * 0.5;
    
    //    CGFloat imgVIewY = (kScreenH - imgViewH) * 0.5;
    
    
    _authTipContentView.frame = CGRectMake(imgViewX, -imgViewH, imgViewW, imgViewH);
    
    
    //    CGFloat translationY = imgVIewY;
    
    [UIView animateKeyframesWithDuration:0.35 delay:0 options:(UIViewKeyframeAnimationOptionLayoutSubviews) animations:^{
        
        _authTipContentView.transform = CGAffineTransformMakeTranslation(0, kTranslationY + kImgViewH);
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    
    
}



#pragma mark--YJAuthTipContentView Delegate
// 00-待审核 20-审核成功 99-审核失败
- (void)authTipContentViewDidAuth:(YJAuthTipContentView *)authTipContentView {
    NSString *status = [kUserManagerTool authStatus];//00-待审核 20-审核成功 99-审核失败
    
    if ([status isEqualToString:@"0"]) { //未认证
        MYLog(@"未认证");
        if (self.authBlock) {
            self.authBlock();
        }
    } else if ([status isEqualToString:@"00"]) {//待审核
        MYLog(@"待审核");
    } else if ([status isEqualToString:@"99"]) {//审核失败
        MYLog(@"审核失败");
        if (self.authBlock) {
            self.authBlock();
        }
    }
    
}


- (void)authTipContentViewDidClose:(YJAuthTipContentView *)authTipContentView {
    [UIView animateWithDuration:0.35 animations:^{
        _authTipContentView.transform = CGAffineTransformTranslate(_authTipContentView.transform, 0, 800);
        
    } completion:^(BOOL finished) {
        
        _authTipContentView.transform = CGAffineTransformIdentity;
        [self removeFromSuperview];
    }];
    
    
}

@end
