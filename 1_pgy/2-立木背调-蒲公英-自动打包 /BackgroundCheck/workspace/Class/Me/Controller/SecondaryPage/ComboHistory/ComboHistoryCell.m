//
//  ComboHistoryCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ComboHistoryCell.h"
#import "YJComboPurchaseHisModel.h"
@interface ComboHistoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *monthLB;
@property (weak, nonatomic) IBOutlet UILabel *comboLB;
@property (weak, nonatomic) IBOutlet UILabel *idLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comboLbConstraintX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneyLbContraintTrailing;

@end

@implementation ComboHistoryCell

+ (instancetype)comboHistoryCellWithTableView:(UITableView *)tableView {
    
    ComboHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comboHistoryCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"ComboHistoryCell" owner:nil options:nil] lastObject];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return cell;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (iPhone5 || iPhone4s) {
        self.comboLbConstraintX.constant = 20;
        self.comboLbConstraintX.constant = 20;
    } else {
        self.comboLbConstraintX.constant = 37;
        self.comboLbConstraintX.constant = 37;
    }
    
    
    
}




- (void)setComboPurchaseList:(YJComboPurchaseList *)comboPurchaseList {
    _comboPurchaseList = comboPurchaseList;
//    [comboPurchaseList.consuDateStr componentsSeparatedByString:@" "][0]
    self.monthLB.text = [self ConvertStrToTime:comboPurchaseList.consuDate];
    
    
    self.comboLB.text = comboPurchaseList.servicePackageName;
    
    self.idLB.text = [NSString stringWithFormat:@"ID:%@",comboPurchaseList.packageSerialNo];
    
    self.moneyLB.text = [NSString stringWithFormat:@"%.2f", [comboPurchaseList.amt floatValue]];
    
    
    
}

- (NSString *)ConvertStrToTime:(NSString *)timeStr {
    
    long long time=[timeStr longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"MM-dd"];
    
    NSString*timeString=[formatter stringFromDate:d];
    
    return timeString;
    
}

@end
