//
//  YJReportCentralBankCell.m
//  CreditPlatform
//
//  Created by yj on 16/8/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportEBankBillCell.h"
@interface YJReportEBankBillCell()
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
/**
 *  手机号
 */
@property (weak, nonatomic) IBOutlet UILabel *mobileLB;
/**
 *  证件号
 */
@property (weak, nonatomic) IBOutlet UILabel *idCardLB;
/**
 *  查询日期
 */
@property (weak, nonatomic) IBOutlet UILabel *searchDateLB;

@end

@implementation YJReportEBankBillCell

+ (instancetype)reportEBankBillCellWithTableView:(UITableView *)tableView  {
    
    YJReportEBankBillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YJReportEBankBillCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJReportEBankBillCell" owner:nil options:nil] firstObject];
    }
    return cell;
    
    
}



- (void)setFrame:(CGRect)frame {
    
    //    frame.origin.y += 10;
    //    frame.size.height -= 10;
    //    frame.origin.y += 10;
    frame.size.height -= 10;
    [super setFrame:frame];
    
    
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
