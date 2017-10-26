//
//  YJTopMenuView.h
//  顶部菜单
//
//  Created by yj on 16/7/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMenuHeight 40

//listTabBar 的高度
#define kMenuWidth  120

//导航栏的Y
#define kNavY 64.0

//plist文件中的title
#define kPlistTitle @"title"

//plist文件中的urlString
#define kPlistUrlString @"urlString"


//listtabBarItem的间距
#define kItemsPadding 0.0

//#define klistTabBarBundleName           @"HZYResource.bundle"

//#define klistTabBarResourcesPath(file) [klistTabBarBundleName stringByAppendingPathComponent:file]

@class YJTopMenuView;
@protocol YJTopMenuViewDelegate <NSObject>

@optional
/**
 *  选中当前item的代理方法
 */
- (void)topMenuView:(YJTopMenuView *)topMenuView didSelectedItemIndex:(NSInteger)index;


@end
@interface YJTopMenuView : UIView
@property (nonatomic, weak) id <YJTopMenuViewDelegate>delegate;

/**
 *  tabBar当前选中的item的索引
 */
@property (nonatomic, assign) NSInteger currentItemIndex;

/**
 *  tabBar上所有要显示的item标题
 */
@property (nonatomic, strong) NSArray *itemsTitle;

@property (nonatomic, assign) CGFloat itemWidth;

@property (nonatomic, strong) UIView *contentView;


- (void)setProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex ;

@end













