//
//  YJCover.m
//  下拉菜单
//
//  Created by yj on 16/9/26.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCover.h"

#define kAlpha 0.3

@implementation YJCover

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.背景色
        self.backgroundColor = [UIColor blackColor];
        
        // 2.自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        // 3.透明度
        self.alpha = kAlpha;
    }
    return self;
}

- (void)reset
{
    self.alpha = kAlpha;
}

+ (id)cover
{
    return [[self alloc] init];
}

+ (id)coverWithTarget:(id)target action:(SEL)action
{
    YJCover *cover = [self cover];
    
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    
    return cover;
}


@end
