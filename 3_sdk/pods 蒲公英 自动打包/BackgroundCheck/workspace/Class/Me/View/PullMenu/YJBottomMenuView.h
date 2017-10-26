//
//  TGDealBottomMenu.h
//  团购
//
//  Created by apple on 13-11-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  底部菜单(父类)

#import <UIKit/UIKit.h>

@class TGCover;
@interface YJBottomMenuView : UIView
{
    UIScrollView *_scrollView;
    UIView *_contentView;


}
@property (nonatomic, copy) void (^hideBlock)();

//- (void)settingSubtitlesView;

// 通过动画显示出来
- (void)show;
// 通过动画隐藏
- (void)hide;
@end
