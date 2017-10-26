//
//  YJHouseFundPayCell.h
//  CreditPlatform
//
//  Created by yj on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//  公积金 存缴明细cell

#import <UIKit/UIKit.h>
@class YJHouseFundDetails;
@interface YJHouseFundPayCell : UITableViewCell
@property (nonatomic, strong) YJHouseFundDetails *detail;
+ (instancetype)houseFundPayCellWithTableView:(UITableView *)tableView;
@end
