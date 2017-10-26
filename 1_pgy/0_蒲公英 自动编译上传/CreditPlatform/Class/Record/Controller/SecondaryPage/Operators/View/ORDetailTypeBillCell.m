//
//  ORDetailTypeBillCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "OperationModel.h"
#import "ORDetailTypeBillCell.h"
//#import "OperationBillSix.h"

@interface ORDetailTypeBillCell()
@property (weak, nonatomic) IBOutlet UILabel *month;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyDown;

@property (weak, nonatomic) IBOutlet UILabel *realMoney;
@property (weak, nonatomic) IBOutlet UILabel *realMoneyDown;

@property (weak, nonatomic) IBOutlet UILabel *ListCost;
@property (weak, nonatomic) IBOutlet UILabel *ListCostDown;

@end

@implementation ORDetailTypeBillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview {
    static NSString *ID = @"ORDetailTypeBillCell";
    ORDetailTypeBillCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ORDetailTypeBillCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(OperationBillSix *)model {
    _model = model;
    NSString *str;
    if (model.startTime.length >11) {
        str = [model.startTime substringToIndex:10];
    }else{
        str = model.startTime;
    }
    
    if (str.length == 6) {
        _month.text = [NSString stringWithFormat:@"%@-%@",[str substringToIndex:4],[str substringFromIndex:4] ];
    } else {
        _month.text = str;
    }
    
    if (model.sumCost.length) {
        _totalMoneyDown .text =model.sumCost;
    } else {
        _totalMoneyDown .text =@"00.00";
    }
    
    
    if (model.realCost.length) {
        _realMoneyDown.text = model.realCost;
    }else{
        _realMoneyDown.text = @"00.00";
    }
    if (model.comboCost.length) {
        _ListCostDown.text =model.comboCost;
    } else {
        _ListCostDown.text =@"00.00";
    }
    
}


@end
