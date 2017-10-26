//
//  YJImageView.m
//  1.SinaWeibo
//
//  Created by qianfeng on 15/11/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "YJImageView.h"

@implementation YJImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];

        
        [deleteBtn setImage:[UIImage imageNamed:@"me_icon_delete"] forState:(UIControlStateNormal)];
        [deleteBtn setImage:[UIImage imageNamed:@"me_icon_delete"] forState:(UIControlStateHighlighted)];
        
//        [self addSubview:deleteBtn];
        
        [deleteBtn addTarget:self action:@selector(clickDeleBtn) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}


- (void)clickDeleBtn {
    
    
    
    [self removeFromSuperview];
    NSLog(@"=======");
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
//    UIButton *btn = self.subviews[0];
//    
//    CGFloat btnWH = 23;
//    CGFloat btnX = self.frame.size.width - btnWH;
//    CGFloat btnY = 0;
//    
//    btn.frame = CGRectMake(btnX, btnY, btnWH, btnWH);
    
    
}





@end
