//
//  YJTypeMenu.h
//  下拉菜单
//
//  Created by yj on 16/9/22.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJBottomMenuView.h"

typedef enum {
    YJMenuTypeRecharge, // 充值
    YJMenuTypePurchase, // 标准消费
    YJMenuTypeComboPurchase // 套餐消费
}YJMenuType;

@interface YJTypeMenu : YJBottomMenuView

@property (nonatomic, assign) YJMenuType menuType;

@end
