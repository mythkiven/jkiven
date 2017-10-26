//
//  ReportCreditEmailBillDetailfenqiCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "reportCreditBillModel.h"
@interface ReportCreditEmailBillDetailfenqiCell : UITableViewCell
@property (strong,nonatomic) reportCreditBillinstallments      *model;
@property (strong,nonatomic) NSString      *coinSign;
+ (instancetype)reportCreditEmailBillDetailfenqiCellWithTableView:(UITableView *)tableView ;
@end
