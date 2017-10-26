//
//  YJTaoBaoGoodsDetailCell.h
//  CreditPlatform
//
//  Created by yj on 16/10/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTaoBaoModel.h"
@interface YJTaoBaoGoodsDetailCell : UITableViewCell

@property (nonatomic, strong) yjTaoBaoOrderItem *orderItem;

+ (instancetype)taoBaoGoodsDetailCellWithTableView:(UITableView *)tableView;

@end
