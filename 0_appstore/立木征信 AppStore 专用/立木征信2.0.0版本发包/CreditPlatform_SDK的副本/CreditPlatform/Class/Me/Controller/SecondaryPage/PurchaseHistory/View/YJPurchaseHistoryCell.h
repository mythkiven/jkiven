//
//  YJPurchaseHistoryCell.h
//  CreditPlatform
//
//  Created by yj on 16/9/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseHistoryModel.h"

@class YJPurchaseHistoryListModel;
@interface YJPurchaseHistoryCell : UITableViewCell
+ (instancetype)purchaseHistoryCellWithTableView:(UITableView *)tableView;
@property (strong,nonatomic) PurchaseHistoryModel      *model;
@property (strong,nonatomic) YJPurchaseHistoryListModel      *listModel;
@end
