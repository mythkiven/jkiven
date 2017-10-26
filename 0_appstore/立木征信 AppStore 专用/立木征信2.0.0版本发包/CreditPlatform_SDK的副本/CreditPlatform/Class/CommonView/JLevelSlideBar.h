//
//  JLevelSlideBar.h
//  CreditPlatform
//
//  Created by gyjrong on 16/11/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
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


#import <UIKit/UIKit.h>

@class JLevelSlideBar;
@protocol JLevelSlideBarDelegate <NSObject>
@optional
- (void)jLevelSlideBar:(JLevelSlideBar *)topMenuView didSelectedItemIndex:(NSInteger)index;
@end

@interface JLevelSlideBar : UIView
@property (nonatomic, weak) id <JLevelSlideBarDelegate>delegate;

/** tabBar当前选中的item的索引 */
@property (nonatomic, assign) NSInteger currentItemIndex;

/** tabBar上所有要显示的item标题 */
@property (nonatomic, strong) NSArray *itemsTitle;

/** item的宽度，间隙均分 */
@property (nonatomic, assign) CGFloat itemWidth;
@end














