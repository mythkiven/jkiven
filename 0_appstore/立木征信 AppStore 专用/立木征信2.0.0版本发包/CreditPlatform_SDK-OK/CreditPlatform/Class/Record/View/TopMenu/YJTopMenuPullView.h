//
//  YJTopMenuPullView.h
//  CreditPlatform
//
//  Created by yj on 2017/6/30.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedIndexBlock)(int);

@interface YJTopMenuPullView : UIView

@property (nonatomic, copy) SelectedIndexBlock selectedIndexBlock;

@property (nonatomic, assign) int selectedIndex;

+ (instancetype)topMenuPullView;

@end
