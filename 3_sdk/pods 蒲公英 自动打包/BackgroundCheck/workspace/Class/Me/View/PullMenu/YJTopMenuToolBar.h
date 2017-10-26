//
//  YJTopMenuToolBar.h
//  下拉菜单
//
//  Created by yj on 16/9/21.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTypeMenu.h"
#import "YJDateMenu.h"
#import "YJChildAccountListMenuView.h"
#define kTopMenuToolBarH    40

//typedef void(^TopMenuButtonOption)(NSInteger index);

typedef enum {
    YJTopMenuToolBarFormType = 20,
    YJTopMenuToolBarFormDate,
    YJTopMenuToolBarFormChildAccount
}YJTopMenuToolBarForm;

@interface YJTopMenuToolBar : UIView

// 容纳底部菜单
@property (nonatomic, weak) UIView *contentView;

@property (nonatomic, assign) YJMenuType menuType;

@property (nonatomic, strong) YJDateMenu *dateMenu;

@property (nonatomic, strong) YJChildAccountListMenuView *ChildAccountMenu;

@property (nonatomic, assign) BOOL isHasToday;

@property (nonatomic, assign) BOOL isHasChildAccount;




@end
