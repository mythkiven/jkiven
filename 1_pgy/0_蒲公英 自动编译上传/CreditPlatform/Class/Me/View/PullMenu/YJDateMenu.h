//
//  YJDateMenu.h
//  下拉菜单
//
//  Created by yj on 16/9/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJBottomMenuView.h"
#import "YJDateChooseView.h"
#import "YJDatePickerView.h"

@interface YJDateMenu : YJBottomMenuView
//{
//    YJDateChooseView *_dateView;
//}

@property (nonatomic, weak) YJDateChooseView *dateView;

@property (nonatomic, assign) BOOL isHasToday;
- (instancetype)initWithToday:(BOOL)isHasToday ;


@end
