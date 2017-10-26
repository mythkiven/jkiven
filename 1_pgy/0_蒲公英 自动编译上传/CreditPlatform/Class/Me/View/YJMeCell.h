//
//  YJMoreCell.h
//  inZhua
//
//  Created by yj on 16/5/25.
//  Copyright © 2016年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJaccessoryArrowBtn.h"

@class YJBaseItem;

@interface YJMeCell : UITableViewCell

@property (nonatomic, strong) YJBaseItem *item;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) YJaccessoryArrowBtn *accessoryArrowBtn;

+ (instancetype)meCell:(UITableView *)tableView;

@end
