//
//  YJTaoBaoOrderDetailsCell.h
//  CreditPlatform
//
//  Created by yj on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTaoBaoModel.h"
#import "YJTaoBaoDataBaseCell.h"
@interface YJTaoBaoOrderDetailsCell : YJTaoBaoDataBaseCell
@property (nonatomic, strong) YJTaoBaoOrderDetails *orderDetails;
@property (weak, nonatomic) IBOutlet UILabel *receiveAddressLB;

+ (instancetype)taoBaoOrderDetailsCellWithTableView:(UITableView *)tableView;
@end
