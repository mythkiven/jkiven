//
//  YJReportCentralBankCell.m
//  CreditPlatform
//
//  Created by yj on 16/8/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportListCell.h"
#import "YJListModel.h"
@interface YJReportListCell()
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
/**
 *  手机号
 */
@property (weak, nonatomic) IBOutlet UILabel *mobileLB;

@property (weak, nonatomic) IBOutlet UILabel *positionLB;
/**
 *  查询日期
 */
@property (weak, nonatomic) IBOutlet UILabel *searchDateLB;

@end

@implementation YJReportListCell

+ (instancetype)reportEBankBillCellWithTableView:(UITableView *)tableView  {
    
    YJReportListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YJReportListCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJReportListCell" owner:nil options:nil] firstObject];
    }
    return cell;
    
    
}

- (void)setListModel:(YJListModel *)listModel {
    _listModel = listModel;
    
    _nameLB.text = listModel.name;
    _mobileLB.text = listModel.mobile;
    _positionLB.text = listModel.position;
    _searchDateLB.text = listModel.reportTime;
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
