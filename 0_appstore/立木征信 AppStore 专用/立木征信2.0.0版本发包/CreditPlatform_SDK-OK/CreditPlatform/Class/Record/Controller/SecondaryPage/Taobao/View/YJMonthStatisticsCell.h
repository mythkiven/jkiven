//
//  YJMonthStatisticsCell.h
//  CreditPlatform
//
//  Created by yj on 16/10/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTaoBaoModel.h"

@interface YJMonthStatisticsCell : UITableViewCell

@property (nonatomic, strong) YJTaobaoConsuStatistic *monthStatistic;
+ (instancetype)monthStatisticsCellWithTableView:(UITableView *)tableView;

@end
