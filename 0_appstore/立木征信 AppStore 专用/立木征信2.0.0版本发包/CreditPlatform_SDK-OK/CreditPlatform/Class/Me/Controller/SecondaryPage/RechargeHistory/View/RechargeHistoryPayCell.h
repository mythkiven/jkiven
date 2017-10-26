//
//  RechargeHistoryPayCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJRechargeHistoryListModel;

@class RechargeHistoryModel;
// 00 取消支付。11 支付
typedef void(^ClickedRechargeHistoryPayBtn)(NSString *str,RechargeHistoryModel *);


@interface RechargeHistoryPayCell : UITableViewCell
@property (strong,nonatomic) YJRechargeHistoryListModel      *model;

//@property (strong,nonatomic) RechargeHistoryModel      *model;
@property(strong,nonatomic) ClickedRechargeHistoryPayBtn clickedRechargePayBtn;

+ (instancetype)purchaseHistoryCellWithTableView:(UITableView *)tableView;

@end
