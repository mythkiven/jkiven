//
//  ComboHistoryCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface YJChildAccountManagerCell : UITableViewCell
+ (instancetype)childAccountManagerCellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *title;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end
