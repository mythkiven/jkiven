//
//  YJReportHouseFundCell.h
//  CreditPlatform
//
//  Created by yj on 16/7/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpaceLabel.h"

@class ReportFirstCommonModel;
@interface YJReportHouseFundCell : UITableViewCell
/**
 *  城市
 */
@property (weak, nonatomic) IBOutlet UILabel *cityLB;
/**if 运营商 手机号*/
@property (copy, nonatomic) NSString *account;
/**if 脉脉 领英 职位*/
@property (copy, nonatomic) NSString *position;

@property (nonatomic, copy) NSString *bizType;

+ (instancetype)reportHouseFundCellWithTableView:(UITableView *)tableView;
+ (instancetype)reportHouseFundCellWithTableView:(UITableView *)tableView isShow:(NSInteger)show;

@property (strong,nonatomic) ReportFirstCommonModel      *model;
@end
