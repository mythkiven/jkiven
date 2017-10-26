//
//  YJCreditCardMonthBillCell.h
//  CreditPlatform
//
//  Created by yj on 2016/11/4.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class reportCreditBilldetails;
@interface YJCreditCardMonthBillCell : UITableViewCell
@property (nonatomic, strong) UIView *bottomLine;

@property (strong,nonatomic) reportCreditBilldetails    *cellmodel;
+ (instancetype)creditCardMonthBillCelWithTableView:(UITableView *)tableView ;


@end
