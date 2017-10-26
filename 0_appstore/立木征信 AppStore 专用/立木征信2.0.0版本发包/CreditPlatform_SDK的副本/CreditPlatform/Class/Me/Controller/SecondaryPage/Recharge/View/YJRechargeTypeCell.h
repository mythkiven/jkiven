//
//  YJRechargeTypeCell.h
//  CreditPlatform
//
//  Created by yj on 16/9/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJHomeItemModel;
@interface YJRechargeTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectedView;
@property (nonatomic, strong) YJHomeItemModel *payTypeModel;
+ (instancetype)rechargeTypeCellWithTableView:(UITableView *)tableView;
@end
