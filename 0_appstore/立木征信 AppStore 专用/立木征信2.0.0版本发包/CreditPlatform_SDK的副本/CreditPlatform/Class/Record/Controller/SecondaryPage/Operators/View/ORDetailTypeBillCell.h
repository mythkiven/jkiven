//
//  ORDetailTypeBillCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJOperatorBaseCell.h"
@class OperationBillSix ;
// 账单信息
@interface ORDetailTypeBillCell : YJOperatorBaseCell
@property (strong,nonatomic) OperationBillSix     *model;
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview;
@end
