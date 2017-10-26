//
//  ECommerceReportDetailTypeStatisticsCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/8/19.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJECommerceCell.h"
@class JDorderStatisticsModel;
@interface ECommerceReportDetailTypeStatisticsCell : YJECommerceCell

+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview;
@property (strong,nonatomic) JDorderStatisticsModel      *model;

@end
