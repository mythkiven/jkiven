//
//  YJFilingTimeCell.h
//  CreditPlatform
//
//  Created by yj on 2016/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class reportDishonestyModel;

@interface YJFilingTimeCell : UITableViewCell



@property (nonatomic, strong) reportDishonestyModel *reportDishonestyModel;

+ (instancetype)filingTimeCellWithTableView:(UITableView *)tableView ;

@end
