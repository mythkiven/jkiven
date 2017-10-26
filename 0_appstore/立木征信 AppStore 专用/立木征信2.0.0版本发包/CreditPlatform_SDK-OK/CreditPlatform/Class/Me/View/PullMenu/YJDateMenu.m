//
//  YJDateMenu.m
//  下拉菜单
//
//  Created by yj on 16/9/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJDateMenu.h"

@interface YJDateMenu ()



@end

@implementation YJDateMenu




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
  
        
//        YJDateChooseView *dateView = [YJDateChooseView dateChooseViewHasToday:YES];
//        self.dateView =dateView;
//        dateView.frame = CGRectMake(0, 0, _scrollView.frame.size.width, 220);
//        _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, 220);
//        _contentView.frame = CGRectMake(0, 0, self.frame.size.width, 220);
//
//        dateView.hideDateChooseView = ^() {
//            [self hide];
//        };
//        [_scrollView addSubview:dateView];
        
    }
    return self;
}

- (instancetype)initWithToday:(BOOL)isHasToday {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        YJDateChooseView *dateView = [YJDateChooseView dateChooseViewHasToday:isHasToday];
        self.dateView =dateView;
        dateView.frame = CGRectMake(0, 0, _scrollView.frame.size.width, 220);
        _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, 220);
        _contentView.frame = CGRectMake(0, 0, self.frame.size.width, 220);

        dateView.hideDateChooseView = ^() {
            [self hide];
        };
        [_scrollView addSubview:dateView];
        
    }
    return self;
}

//- (void)setIsHasToday:(BOOL)isHasToday {
//    _isHasToday = isHasToday;
//    
//    YJDateChooseView *dateView = [YJDateChooseView dateChooseViewHasToday:isHasToday];
//    self.dateView =dateView;
//    dateView.frame = CGRectMake(0, 0, _scrollView.frame.size.width, 220);
//    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, 220);
//    _contentView.frame = CGRectMake(0, 0, self.frame.size.width, 220);
//    
//    dateView.hideDateChooseView = ^() {
//        [self hide];
//    };
//    [_scrollView addSubview:dateView];
//    
//}

- (void)hide {
    [super hide];
    
    [_dateView clearSelectedDateBtnStyle];
    [_dateView.picker hidden];
    
}

@end
