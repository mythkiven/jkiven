//
//  YJSocialSecurityDetailCell.h
//  CreditPlatform
//
//  Created by yj on 16/8/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJSocialSecurityModel.h"
@interface YJSocialSecurityDetailCell : UITableViewCell

@property (nonatomic, strong) YJBaseInsurance *baseInsurance;
+ (instancetype)socialSecurityDetailCellWithTableView:(UITableView *)tableView isMaternity:(BOOL)ret;
+ (instancetype)socialSecurityDetailCellWithTableView:(UITableView *)tableView ;
@end
