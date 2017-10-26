//
//  ComboHistoryCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJComboPurchaseList;
@interface ComboHistoryCell : UITableViewCell
+ (instancetype)comboHistoryCellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) YJComboPurchaseList *comboPurchaseList;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end
