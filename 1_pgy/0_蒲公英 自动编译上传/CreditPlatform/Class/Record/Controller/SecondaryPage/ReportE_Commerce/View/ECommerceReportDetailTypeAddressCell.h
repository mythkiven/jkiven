//
//  ECommerceReportDetailTypeAddressCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJECommerceCell.h"

@class JDaddressInfoModel;
@interface ECommerceReportDetailTypeAddressCell : YJECommerceCell
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview;
@property (strong,nonatomic) JDaddressInfoModel      *model;
@end
