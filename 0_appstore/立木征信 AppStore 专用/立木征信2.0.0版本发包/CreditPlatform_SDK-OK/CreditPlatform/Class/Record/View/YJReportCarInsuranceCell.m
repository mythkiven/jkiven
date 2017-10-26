//
//  YJReportCentralBankCell.m
//  CreditPlatform
//
//  Created by yj on 16/8/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportCarInsuranceCell.h"
#import "ReportFirstCommonModel.h"
@interface YJReportCarInsuranceCell()
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
/**
 *  车牌
 */
@property (weak, nonatomic) IBOutlet UILabel *plateNoLB;
/**
 *  保单号
 */
@property (weak, nonatomic) IBOutlet UILabel *policyNoLB;

/**
 *  证件号
 */
@property (weak, nonatomic) IBOutlet UILabel *idLB;
/**
 *  查询日期
 */
@property (weak, nonatomic) IBOutlet UILabel *searchDateLB;

@end

@implementation YJReportCarInsuranceCell

+ (instancetype)reportCarInsuranceCellWithTableView:(UITableView *)tableView  {
    
    YJReportCarInsuranceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reportCarInsuranceCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJReportCarInsuranceCell" owner:nil options:nil] firstObject];
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
    
    if (model.plateNo && ![model.plateNo isEqualToString:@""]) {
        self.plateNoLB.text = model.plateNo;
    } else {
        self.plateNoLB.text = @"--";
    }
    
    if (model.policyNo && ![model.policyNo isEqualToString:@""]) {
        self.policyNoLB.text = model.policyNo;
    } else {
        self.policyNoLB.text = @"--";
    }
    
    if (model.idCard && ![model.idCard isEqualToString:@""]) {
        self.idLB.text = model.idCard;
    } else {
        self.idLB.text = @"--";
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
