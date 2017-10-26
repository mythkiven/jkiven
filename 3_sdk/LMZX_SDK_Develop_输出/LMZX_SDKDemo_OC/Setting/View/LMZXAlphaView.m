//
//  LMZXAlphaView.m
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/3/7.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXAlphaView.h"
#import "UIColor+Extension.h"
#define lmzxSliderLabelWH 25
@interface LMZXAlphaView ()

{
    UIImageView *_arrow;
    
    UIView *_line;
    
    NSMutableArray *_viewArray;
}

@end

@implementation LMZXAlphaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        

        self.backgroundColor = [UIColor clearColor];
        
        
        UILabel *lb = [[UILabel alloc] init];
        lb.font = [UIFont systemFontOfSize:14];
        lb.text = @"Opacity";
        lb.frame = CGRectMake(0, -15, 50, 20);
        [self addSubview:lb];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
        line.layer.cornerRadius = 1;
        line.clipsToBounds = YES;
        
        [self addSubview:line];
        _line = line;

        
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"theme_label"];
        _arrow.userInteractionEnabled = YES;
        [self addSubview:_arrow];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(arrowMove:)];
        [_arrow addGestureRecognizer:pan];

        
        
        
        
    }
    return self;
}



- (void)arrowMove:(UIPanGestureRecognizer *)pan {
    CGPoint transtionP = [pan translationInView:pan.view];

    CGRect frame = pan.view.frame;
    frame.origin.x += transtionP.x;
    pan.view.frame = frame;

    
    if (pan.view.frame.origin.x < 0) {
        CGRect frame = pan.view.frame;
        frame.origin.x = 0;
        pan.view.frame = frame;
    }
    
    if (pan.view.frame.origin.x >= self.frame.size.width-lmzxSliderLabelWH) {
        CGRect frame = pan.view.frame;
        frame.origin.x = self.frame.size.width-lmzxSliderLabelWH;
        pan.view.frame = frame;
    }
    
    if ([self.delegate respondsToSelector:@selector(alphaView:changeAlpha:)]) {
        [self.delegate alphaView:self changeAlpha:pan.view.frame.origin.x/(self.frame.size.width-lmzxSliderLabelWH)];
    }
    
    
    [pan setTranslation:CGPointZero inView:pan.view];
  
}

- (void)setAlphaTo1 {
    CGRect frame = _arrow.frame;
    frame.origin.x = self.frame.size.width-lmzxSliderLabelWH;
    _arrow.frame = frame;
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _arrow.frame = CGRectMake(self.frame.size.width-lmzxSliderLabelWH, 0, lmzxSliderLabelWH, lmzxSliderLabelWH);


    _line.frame = CGRectMake(0, (self.frame.size.height-10)*0.5, self.frame.size.width, 10);
    
    
}





- (void)setFrame:(CGRect)frame {
    
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, lmzxSliderLabelWH)];
}





@end
