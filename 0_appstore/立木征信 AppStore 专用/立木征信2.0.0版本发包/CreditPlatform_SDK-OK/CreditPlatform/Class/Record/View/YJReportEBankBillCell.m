//
//  YJReportCentralBankCell.m
//  CreditPlatform
//
//  Created by yj on 16/8/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportEBankBillCell.h"
#import "ReportFirstCommonModel.h"
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

- (void)setModel:(ReportFirstCommonModel *)model{
    _model = model;
    
    if (model.realName && ![model.realName isEqualToString:@""]) {
        self.nameLB.text = model.realName;
    } else {
        self.nameLB.text = @"--";
    }
    
    if (model.mobile && ![model.mobile isEqualToString:@""]) {
        self.mobileLB.text = model.mobile;
    } else {
        self.mobileLB.text = @"--";
    }
    
    if (model.accountNameStr && ![model.accountNameStr isEqualToString:@""]) {
        self.idCardLB.text = model.accountNameStr;
    } else {
        self.idCardLB.text = @"--";
    }
    
    if (model.createDateApp && ![model.createDateApp isEqualToString:@""]) {
        self.searchDateLB.text = model.createDateApp;
    } else {
        self.searchDateLB.text = @"--";
    }
    
    
   
    
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
