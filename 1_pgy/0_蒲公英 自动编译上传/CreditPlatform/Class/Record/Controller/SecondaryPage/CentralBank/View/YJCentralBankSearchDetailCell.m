//
//  YJCentralBankSearchDetailCell.m
//  CreditPlatform
//
//  Created by yj on 16/8/20.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCentralBankSearchDetailCell.h"

@interface YJCentralBankSearchDetailCell ()
/**
 *  编号
 */
@property (nonatomic, weak) IBOutlet UILabel *noLB;
/**
 *  时间
 */
@property (nonatomic, weak) IBOutlet UILabel *timeLB;

/**
 *  查询操作员
 */
@property (nonatomic, weak) IBOutlet UILabel *userLB;

/**
 *  查询操作员编号
 */
@property (nonatomic, weak) IBOutlet UILabel *userNoLB;
/**
 *  查询操原因
 */
@property (nonatomic, weak) IBOutlet UILabel *reasonLB;
/**
 *  查询操原因(备注)
 */
@property (weak, nonatomic) IBOutlet UILabel *reasonDetLB;

@end

@implementation YJCentralBankSearchDetailCell


+ (instancetype)centralBankSearchDetailCellWithTableView:(UITableView *)tableView cellType:(YJCentralBankCellType)cellType {
    YJCentralBankSearchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"centralBankSearchDetailCell"];
    if (cell == nil) {
        if (cellType == YJCentralBankCellTypePerson) {
            
            cell= [[[NSBundle mainBundle] loadNibNamed:@"YJCentralBankSearchDetailCell" owner:nil options:nil] firstObject];
            
        } else if (cellType == YJCentralBankCellTypeOrganizer) {
            
            cell= [[[NSBundle mainBundle] loadNibNamed:@"YJCentralBankSearchDetailCell" owner:nil options:nil] lastObject];
            
        }
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}




- (void)setCentralBankSearchRecordDetItem:(YJCentralBankSearchRecordDetItem *)centralBankSearchRecordDetItem {
    
    _centralBankSearchRecordDetItem = centralBankSearchRecordDetItem;
    if (centralBankSearchRecordDetItem.no) {
        self.noLB.text = [NSString stringWithFormat:@"NO.%@",centralBankSearchRecordDetItem.no];
    }
    if (centralBankSearchRecordDetItem.time) {
        self.timeLB.text = centralBankSearchRecordDetItem.time;
    }
    
    if (centralBankSearchRecordDetItem.user) {
        NSArray *tempArr = [centralBankSearchRecordDetItem.user componentsSeparatedByString:@"/"];
        if (tempArr.count>1) {
            self.userLB.text = tempArr[0];
            self.userNoLB.text = [NSString stringWithFormat:@"/%@",tempArr[1]];
        } else {
            self.userLB.text = centralBankSearchRecordDetItem.user;
        }
       
    }
    
    if (centralBankSearchRecordDetItem.reason) {
        NSArray *tempArr = [centralBankSearchRecordDetItem.reason componentsSeparatedByString:@"（"];
        if (tempArr.count>1) {
            self.reasonLB.text = tempArr[0];
            self.reasonDetLB.text = [NSString stringWithFormat:@"(%@",tempArr[1]];
        } else {
            self.reasonLB.text = centralBankSearchRecordDetItem.reason;
        }
        
    }
    
}






@end
