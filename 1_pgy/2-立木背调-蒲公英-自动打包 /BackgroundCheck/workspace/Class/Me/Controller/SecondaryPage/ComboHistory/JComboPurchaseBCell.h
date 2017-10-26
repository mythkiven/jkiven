//
//  JComboPurchaseBCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/11/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JComboPurchaseBModel.h"
@interface JComboPurchaseBCell : UITableViewCell
@property (copy,nonatomic) JComboPurchaseBListModel      *jComboPurchaseBModel;
+ (instancetype)jComboPurchaseBCellWithTableView:(UITableView *)tableView ;
@property (nonatomic, assign) NSInteger index;

@end
