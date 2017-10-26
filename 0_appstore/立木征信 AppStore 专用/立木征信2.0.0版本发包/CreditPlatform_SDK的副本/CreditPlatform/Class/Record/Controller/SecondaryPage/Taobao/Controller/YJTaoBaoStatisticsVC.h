//
//  YJTaoBaoStatisticsVC.h
//  CreditPlatform
//
//  Created by yj on 16/10/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTaoBaoModel.h"
typedef enum {
    YJTaoBaoStatisticTypeAddress,
    YJTaoBaoStatisticTypeMonth
}YJTaoBaoStatisticType;
@interface YJTaoBaoStatisticsVC : UITableViewController
@property (nonatomic, assign) YJTaoBaoStatisticType statisticType;
@property (nonatomic, strong) YJTaobaoStatisticsModel *statisticsModel;
@end
