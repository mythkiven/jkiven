//
//  YJComboPurchaseDetHeaderView.h
//  CreditPlatform
//
//  Created by yj on 2016/10/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JComboPurchaseBModel.h"

@class YJComboPurchaseDetModel;
@interface YJComboPurchaseDetHeaderView : UIView

+ (instancetype)comboPurchaseDetHeaderView ;

@property (nonatomic, strong) YJComboPurchaseDetModel *comboDetModel;
@property (nonatomic, strong) JComboPurchaseBDataModel *jComboPurchaseBDataModel;

@end
