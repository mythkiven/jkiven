//
//  RechargeHistoryNormalCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RechargeHistoryModel;
@interface RechargeHistoryNormalCell : UITableViewCell
@property (strong,nonatomic) RechargeHistoryModel      *model;
+ (instancetype)purchaseHistoryCellWithTableView:(UITableView *)tableView;
@end
