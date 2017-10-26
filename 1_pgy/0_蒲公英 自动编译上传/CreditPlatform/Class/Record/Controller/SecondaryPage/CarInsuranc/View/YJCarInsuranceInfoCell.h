//
//  YJTaoBaoOrderDetailsCell.h
//  CreditPlatform
//
//  Created by yj on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJCarInsuranceInsurance;
@interface YJCarInsuranceInfoCell : UITableViewCell
@property (nonatomic, strong) YJCarInsuranceInsurance *insurance;
+ (instancetype)carInsuranceInfoCellWithTableView:(UITableView *)tableView;
@end
