//
//  YJTaoBaoDeliveryAddressCell.h
//  CreditPlatform
//
//  Created by yj on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//   收货地址

#import <UIKit/UIKit.h>
#import "YJTaoBaoModel.h"
#import "YJTaoBaoDataBaseCell.h"

@interface YJTaoBaoDeliveryAddressCell : YJTaoBaoDataBaseCell

@property (nonatomic, strong) YJTaoBaoAddresses *addressModel;
+ (instancetype)taoBaoDeliveryAddressCellWithTableView:(UITableView *)tableView;

@end
