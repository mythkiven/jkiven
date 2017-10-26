//
//  YJReportCentralBankCell.m
//  CreditPlatform
//
//  Created by yj on 16/8/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportCentralBankCell.h"
#import "ReportFirstCommonModel.h"
@interface YJReportCentralBankCell()
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
/**
 *  登录名
 */
@property (weak, nonatomic) IBOutlet UILabel *loginNameLB;
/**
 *  证件号
 */
@property (weak, nonatomic) IBOutlet UILabel *idLB;
/**
 *  查询日期
 */
@property (weak, nonatomic) IBOutlet UILabel *searchDateLB;

@end

@implementation YJReportCentralBankCell

+ (instancetype)reportCentralBankCellWithTableView:(UITableView *)tableView  {
    
    YJReportCentralBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reportCentralBankCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJReportCentralBankCell" owner:nil options:nil] firstObject];
    }
    return cell;
    
    
}

- (void)setModel:(ReportFirstCommonModel *)model{
    _model = model;
    
    if (model.realName  && ![model.realName isEqualToString:@""]) {
        
        NSString *nameStr = [model.realName stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (nameStr.length) {
            _nameLB.text= nameStr;
        } else {
             _nameLB.text = @"--";
        }
    }else {
        _nameLB.text = @"--";
    }
    
    
    if (model.accountName && ![model.accountName isEqualToString:@""]) {
        _loginNameLB.text = model.accountName;
    }else {
        _loginNameLB.text = @"--";
    }
    
    if (model.idCard && ![model.idCard isEqualToString:@""]) {
         _idLB.text = model.idCard;
    }else {
        _idLB.text = @"--";
    }
    
    if (model.createDateApp && ![model.createDateApp isEqualToString:@""]) {
        _searchDateLB.text = model.createDateApp;
    }else {
        _searchDateLB.text = @"--";
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
