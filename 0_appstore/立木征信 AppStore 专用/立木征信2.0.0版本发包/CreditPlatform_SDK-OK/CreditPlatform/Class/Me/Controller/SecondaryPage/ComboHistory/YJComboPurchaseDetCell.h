//
//  YJComboPurchaseDetCell.h
//  CreditPlatform
//
//  Created by yj on 2016/10/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJComboPurchaseDetRow;
@interface YJComboPurchaseDetCell : UITableViewCell


+ (instancetype)comboPurchaseDetCellWithTableView:(UITableView *)tableView ;

@property (nonatomic, strong) YJComboPurchaseDetRow *comboDetRow;

@property (nonatomic, assign) NSInteger index;

@end
