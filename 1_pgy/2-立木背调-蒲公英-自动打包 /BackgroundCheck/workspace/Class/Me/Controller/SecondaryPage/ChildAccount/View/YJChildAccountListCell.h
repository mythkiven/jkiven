//
//  ComboHistoryCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJChildAccountListModel;
@interface YJChildAccountListCell : UITableViewCell
+ (instancetype)childAccountListCellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) YJChildAccountListModel *listModel;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end
