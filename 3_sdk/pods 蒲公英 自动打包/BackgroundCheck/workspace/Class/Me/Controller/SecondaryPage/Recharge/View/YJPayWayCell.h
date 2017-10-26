//
//  YJHomeCell.h
//  CreditPlatform
//
//  Created by yj on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJHomeItemModel;
@interface YJPayWayCell : UITableViewCell

+ (instancetype)payWayCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) YJHomeItemModel *homeItemModel;
@end
