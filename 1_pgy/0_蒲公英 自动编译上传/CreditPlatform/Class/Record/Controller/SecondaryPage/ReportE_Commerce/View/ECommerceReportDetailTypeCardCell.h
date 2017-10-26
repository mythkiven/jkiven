//
//  ORDetailTypeBillCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJECommerceCell.h"

@class JDbankInfoModel;
// 银行卡
@interface ECommerceReportDetailTypeCardCell : YJECommerceCell
@property (strong,nonatomic)  JDbankInfoModel     *model;
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview;
@end
