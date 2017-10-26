//
//  YJAlertView.m
//  YJAlertView
//
//  Created by yj on 16/9/12.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJAlertView.h"

#define kAlertWidth ([UIScreen mainScreen].bounds.size.width-30)
#define kAlertBtnHeight 50

@interface YJAlertView ()
{
    UIView *_alertView;


    
    CGFloat _alertHeight;
}
@property (nonatomic, strong) NSMutableArray *buttonTitles;
@end
@implementation YJAlertView

- (NSMutableArray *)buttonTitles {
    if (_buttonTitles == nil) {
        _buttonTitles = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _buttonTitles;
}
- (instancetype)initWithTitle:( NSString *)title message:( NSString *)message {
    self = [super init];
    
    if (self) {
        self.title  = title;
        self.message = message;
        
        [self setupSubViews];
        
        
    }
    return self;
    
}
- (void)setupSubViews {
    
    // 半透明背景
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = [UIScreen mainScreen].bounds;
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = .3;
    [self addSubview:bgView];
    
    
    _alertHeight = 0;
    _alertView =  [[UIView alloc] init];
    _alertView.layer.cornerRadius = 10;
    _alertView.clipsToBounds = YES;
    _alertView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_alertView];
    
    
    CGFloat margin = 20; // Y
    CGFloat marginX = 30;
    if (_title.length) {
         UILabel *titleLB = [[UILabel alloc] init];
        self.titleLB = titleLB;
        _titleLB.text = _title;
        _titleLB.textAlignment = NSTextAlignmentLeft;
        _titleLB.font = [UIFont boldSystemFontOfSize:18];
        _titleLB.frame = CGRectMake(marginX, margin, kAlertWidth-marginX*2, 22);
        [_alertView addSubview:_titleLB];
        
        _alertHeight = CGRectGetMaxY(_titleLB.frame) + margin;
    }
    
    
    if (_message.length) {
        UILabel *messageLB = [[UILabel alloc] init];
        self.messageLB = messageLB;
        _messageLB.numberOfLines = 0;
        CGFloat messageLbW = kAlertWidth - marginX*2;
        
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_message];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _message.length)];
        
        _messageLB.attributedText = attributedString;
        CGSize size = CGSizeMake(messageLbW, 500000);
        CGSize labelSize = [_messageLB sizeThatFits:size];
//        CGRect frame = _messageLB.frame;
//        frame.size = labelSize;
//        _messageLB.frame = frame;
        
        CGFloat messageLbH = labelSize.height;
        MYLog(@"messageLbH----------%f",messageLbH);
//        CGFloat messageLbH = [_message boundingRectWithSize:CGSizeMake(messageLbW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : Font13} context:nil].size.height+5;
        
//        _messageLB.text = _message;
        _messageLB.textColor = RGB(102,102,102);
        _messageLB.textAlignment = NSTextAlignmentLeft;
        _messageLB.font = Font15;
        _messageLB.frame = CGRectMake(marginX, _alertHeight, messageLbW, messageLbH);
        [_alertView addSubview:_messageLB];
        
        _alertHeight = CGRectGetMaxY(_messageLB.frame)+margin;
    }
    
}





- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLB.text = title;
    
}

- (void)setMessage:(NSString *)message {
    _message = message;
    _messageLB.text = message;

}


- (void)addButtonWithTitle:( NSString *)title{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.titleLabel.font = Font18;
    if ([title isEqualToString:@"取消"]) {
        [btn setTitleColor:RGB_navBar forState:(UIControlStateNormal)];
    } else {
        [btn setTitleColor:RGB_navBar forState:(UIControlStateNormal)];
    }
    
    [btn addTarget:self action:@selector(btnClcik:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:btn];

    [self.buttonTitles addObject:btn];
    
    
}

- (UIView *)line {
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB_grayLine;
     [_alertView addSubview:line];
    return line;
    
    
}

- (void)btnClcik:(UIButton *)btn {
    
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = .3;
        _alertView.alpha = .3;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];

    }];
    
    if (self.handler) {
        self.handler((int)btn.tag);
    }
    
    
    
}

- (void)layoutBtns {
    int count = (int)self.buttonTitles.count;
    
    if (count == 1) {
        UIView *line = [self line];
        line.frame = CGRectMake(0, _alertHeight, kAlertWidth, .5);
        
        UIButton *btn = self.buttonTitles[0];
        btn.tag = 0;
        btn.frame = CGRectMake(0, _alertHeight, kAlertWidth, kAlertBtnHeight);
        _alertHeight = CGRectGetMaxY(btn.frame);
    } else if (count == 2) {
        CGFloat btnW = kAlertWidth *.5;
        UIView *lineH = [self line];
        lineH.frame = CGRectMake(0, _alertHeight, kAlertWidth, .5);
        UIView *lineV = [self line];
        lineV.frame = CGRectMake(btnW, _alertHeight, .5, kAlertBtnHeight);
        
        for (int i = 0; i < 2; i ++) {
            UIButton *btn = self.buttonTitles[i];
             btn.tag = i;
            btn.frame = CGRectMake(i * btnW, _alertHeight, btnW, kAlertBtnHeight);
            if (i == 1) {
                _alertHeight = CGRectGetMaxY(btn.frame);

            }
        }
        
        
        
        
    } else {
        for (int i = 0; i < self.buttonTitles.count; i ++) {
            UIButton *btn = self.buttonTitles[i];
            btn.frame = CGRectMake(0, i * kAlertBtnHeight+_alertHeight, kAlertWidth, kAlertBtnHeight);
            btn.tag = i;
            
            UIView *lineH = [self line];
            lineH.frame = CGRectMake(0, i * kAlertBtnHeight+_alertHeight, kAlertWidth, .5);
            
            if (i == self.buttonTitles.count - 1) {
                _alertHeight = CGRectGetMaxY(btn.frame);
                
            }
        }
        
        
    }
    
    
    _alertView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-kAlertWidth)*.5, ([UIScreen mainScreen].bounds.size.height-_alertHeight)*.5, kAlertWidth, _alertHeight);
}

- (void)show {
    
    [self layoutBtns];
    
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    
    self.frame = [UIScreen mainScreen].bounds;
    [window addSubview:self];
    
    
    
    [self animationWithView:_alertView duration:.25];
    
    
}



- (void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, .95, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
     animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [view.layer addAnimation:animation forKey:nil];
}



@end
