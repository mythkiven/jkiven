//
//  YJCentralBankSearchDetailCell.h
//  CreditPlatform
//
//  Created by yj on 16/8/20.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCentralBankBaseCell.h"
#import "YJCentralBankModel.h"

typedef  enum {
    /**
     *  个人
     */
    YJCentralBankCellTypePerson = 10,
    /**
     *  机构
     */
    YJCentralBankCellTypeOrganizer,
    
}YJCentralBankCellType;

@interface YJCentralBankSearchDetailCell : YJCentralBankBaseCell
@property (nonatomic, strong) YJCentralBankSearchRecordDetItem *centralBankSearchRecordDetItem;


+ (instancetype)centralBankSearchDetailCellWithTableView:(UITableView *)tableView cellType:(YJCentralBankCellType)cellType;

@end
