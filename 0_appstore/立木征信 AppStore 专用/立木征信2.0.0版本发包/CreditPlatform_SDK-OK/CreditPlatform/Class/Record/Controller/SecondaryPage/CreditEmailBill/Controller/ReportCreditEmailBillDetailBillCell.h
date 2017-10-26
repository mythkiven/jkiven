//
//  ReportCreditEmailBillDetailBillCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "reportCreditBillModel.h"

@interface ReportCreditEmailBillDetailBillCell : UITableViewCell


// cell
@property (strong,nonatomic) reportCreditBilldetails    *cellmodel;
+ (instancetype)reportCreditEmailBillDetailBillCellWithTableView:(UITableView *)tableView ;

+(CGFloat)cellHelight:(NSString*)str;


@end
