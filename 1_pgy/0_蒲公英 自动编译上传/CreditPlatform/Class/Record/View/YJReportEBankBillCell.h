//
//  YJReportCentralBankCell.h
//  CreditPlatform
//
//  Created by yj on 16/8/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReportFirstCommonModel;
@interface YJReportEBankBillCell : UITableViewCell
@property (strong,nonatomic) ReportFirstCommonModel      *model;

+ (instancetype)reportEBankBillCellWithTableView:(UITableView *)tableView;

@end
