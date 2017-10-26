//
//  ORDetailTypeBillCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//  信贷记录

#import <UIKit/UIKit.h>
#import "YJCentralBankBaseCell.h"
@class YJCentralBankSummary;
@interface YJCentralBankCreditRecordCell : YJCentralBankBaseCell

@property (retain,nonatomic) YJCentralBankSummary *summaryModel;

+ (instancetype)creditRecordCellWithTabelView:(UITableView *)tableview;
@end
