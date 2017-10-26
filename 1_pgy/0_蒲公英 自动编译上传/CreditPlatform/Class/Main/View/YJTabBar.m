//
//  YJTabBar.m
//  3.Lottery彩票
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "YJTabBar.h"
#import "YJButton.h"

@interface YJTabBar ()
{
    YJButton *_selectedButton;

}



@end


@implementation YJTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TabBarBack"]];

        

        self.backgroundColor = RGB_grayBar;

        
    }
    return self;
}


- (void)addButtonWithTitle:(NSString *)title imageName:(NSString *)name selectedImageName:(NSString *)selName {
    
    YJButton *button = [YJButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:name] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:selName] forState:(UIControlStateSelected)];
//    button.titleLabel.font = [UIFont systemFontOfSize:12.0];
    
//    button.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    [button setTitle:title forState:(UIControlStateNormal)];
    
    [button addTarget:self action:@selector(clickButton:) forControlEvents:(UIControlEventTouchUpInside)];
    button.userInteractionEnabled = YES;
    [self addSubview:button];
    
    //    button.tag = self.subviews.count - 1;
    //    if (button.tag == 0) {
    //        [self clickButton:button];
    //    }
    
    if (self.subviews.count == 1) {
        [self clickButton:button];
    }
    
    
}







- (void)clickButton:(YJButton *)button {
    NSInteger currentIndex = _selectedButton.tag;
    
//    NSLog(@"%ld",button.tag);
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectButtonFrom:currentIndex to:button.tag];
    }
    
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    int count = (int)self.subviews.count;
    
    CGFloat buttonW = self.frame.size.width / count;
    CGFloat buttonH = self.frame.size.height;

    
    CGFloat buttonY = 0;
    for (int i = 0; i < count; i ++) {
        
        YJButton *button = self.subviews[i];
        
        button.tag = i;
        CGFloat buttonX = buttonW * i;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}


- (void)drawRect:(CGRect)rect {
    
    [[UIImage resizedImage:@"bg"] drawInRect:rect];
    
}



@end
