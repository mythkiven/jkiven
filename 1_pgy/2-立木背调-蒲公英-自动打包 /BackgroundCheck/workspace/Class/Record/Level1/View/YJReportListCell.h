//
//  YJReportCentralBankCell.h
//  CreditPlatform
//
//  Created by yj on 16/8/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJListModel;

@interface YJReportListCell : UITableViewCell
@property (nonatomic, strong) YJListModel *listModel;
+ (instancetype)reportEBankBillCellWithTableView:(UITableView *)tableView;

@end
