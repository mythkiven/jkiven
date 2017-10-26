//
//  YJCitySelectCell.h
//  CreditPlatform
//
//  Created by yj on 2016/11/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJFilingTimeCell.h"
@class YJCityInfoModel;

@interface YJCitySelectCell : UITableViewCell

@property (nonatomic, copy) NSString *title;
@property (weak, nonatomic) IBOutlet UIView *topLine;

@property (nonatomic, strong) YJCityInfoModel *cityInfoModel;

+ (instancetype)citySelectCellWithTableView:(UITableView *)tableView ;

@end
