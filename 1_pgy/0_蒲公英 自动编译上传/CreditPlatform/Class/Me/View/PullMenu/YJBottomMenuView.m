//
//  TGDealBottomMenu.m
//  团购
//
//  Created by apple on 13-11-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "YJBottomMenuView.h"


#import "YJCover.h"

#define kBottomMenuItemH 260
#define kDefaultAnimDuration .3
@interface YJBottomMenuView()
{
    YJCover *_cover;

}
@end

@implementation YJBottomMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];

        // 1.添加蒙板（遮盖）
        _cover = [YJCover coverWithTarget:self action:@selector(hide)];
        _cover.frame = self.bounds;
        [self addSubview:_cover];
        
        // 2.内容view
        _contentView = [[UIView alloc] init];
//        _contentView.frame = CGRectMake(0, 0, self.frame.size.width, kBottomMenuItemH);
        _contentView.backgroundColor = [UIColor clearColor];

        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_contentView];
        
        // 3.添加UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, kBottomMenuItemH);
        scrollView.backgroundColor = [UIColor whiteColor];
        [_contentView addSubview:scrollView];
        _scrollView = scrollView;
    }
    return self;
}



#pragma mark 显示
- (void)show
{
//    _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
    _contentView.transform = CGAffineTransformTranslate(_contentView.transform, 0, -_contentView.frame.size.height);
    _contentView.alpha = 0;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        // 1.scrollView从上面 -> 下面
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        // 2.遮盖（0 -> 0.4）
        [_cover reset];
    }];
}

- (void)hide
{
    if (_hideBlock) {
        _hideBlock();
    }
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        // 1.scrollView从下面 -> 上面
//        _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
        _contentView.transform = CGAffineTransformTranslate(_contentView.transform, 0, -_contentView.frame.size.height);
        
        
        _contentView.alpha = 0;
        
        // 2.遮盖（0.4 -> 0）
        _cover.alpha = 0;
    } completion:^(BOOL finished) {
        // 从父控件中移除
        [self removeFromSuperview];
        
        // 恢复属性
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha  = 1;
        [_cover reset];
    }];
}
@end
