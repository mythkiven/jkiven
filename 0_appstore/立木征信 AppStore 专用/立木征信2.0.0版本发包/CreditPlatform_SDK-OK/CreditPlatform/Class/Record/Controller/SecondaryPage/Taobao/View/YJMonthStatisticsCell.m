//
//  YJMonthStatisticsCell.m
//  CreditPlatform
//
//  Created by yj on 16/10/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJMonthStatisticsCell.h"

@interface YJMonthStatisticsCell ()

@property (weak, nonatomic) IBOutlet UILabel *monthLB;

@property (weak, nonatomic) IBOutlet UILabel *numPensLB;
@property (weak, nonatomic) IBOutlet UILabel *amountLB;

@end
@implementation YJMonthStatisticsCell


+ (instancetype)monthStatisticsCellWithTableView:(UITableView *)tableView {
    
    YJMonthStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"monthStatisticsCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJMonthStatisticsCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
    
}

- (void)setMonthStatistic:(YJTaobaoConsuStatistic *)monthStatistic {
    _monthStatistic = monthStatistic;
    
    if (![monthStatistic.month isEqualToString:@""]) {
        self.monthLB.text = monthStatistic.month;
    } else {
        self.monthLB.text = @"--";
        
    }
    
    if (![monthStatistic.totalNumberOfPens isEqualToString:@""]) {
        self.numPensLB.text = monthStatistic.totalNumberOfPens;
    } else {
        self.numPensLB.text = @"--";
        
    }
    
    if (![monthStatistic.totalAmount isEqualToString:@""]) {
        self.amountLB.text = [NSString stringWithFormat:@"%.2f",[monthStatistic.totalAmount floatValue]];
    } else {
        self.amountLB.text = @"--";
        
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
