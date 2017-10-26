//
//  JLevelSlideBar.h
//  CreditPlatform
//
//  Created by gyjrong on 16/11/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#define lmzxkMenuHeight 40
//listTabBar 的高度
#define lmzxkMenuWidth  120
//导航栏的Y
#define lmzxkNavY 64.0
//plist文件中的title
#define lmzxkPlistTitle @"title"
//plist文件中的urlString
#define lmzxkPlistUrlString @"urlString"
//listtabBarItem的间距
#define lmzxkItemsPadding 0.0


#import <UIKit/UIKit.h>

@class LMZXLevelSlideBar;
@protocol LMZXLevelSlideBarDelegate <NSObject>
@optional
- (void)jLevelSlideBar:(LMZXLevelSlideBar *)topMenuView didSelectedItemIndex:(NSInteger)index;
@end

@interface LMZXLevelSlideBar : UIView
@property (nonatomic, weak) id <LMZXLevelSlideBarDelegate>delegate;

/** tabBar当前选中的item的索引 */
@property (nonatomic, assign) NSInteger currentItemIndex;

/** tabBar上所有要显示的item标题 */
@property (nonatomic, strong) NSArray *itemsTitle;

/** item的宽度，间隙均分 */
@property (nonatomic, assign) CGFloat itemWidth;
@end














