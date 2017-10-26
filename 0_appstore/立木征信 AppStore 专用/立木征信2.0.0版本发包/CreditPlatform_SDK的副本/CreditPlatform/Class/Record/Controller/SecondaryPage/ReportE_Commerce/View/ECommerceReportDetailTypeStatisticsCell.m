//
//  ECommerceReportDetailTypeStatisticsCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/19.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "JDReportModel.h"
#import "ECommerceReportDetailTypeStatisticsCell.h"
@interface ECommerceReportDetailTypeStatisticsCell ()
@property (weak, nonatomic) IBOutlet UILabel *addSpend3Year;
@property (weak, nonatomic) IBOutlet UILabel *singleHightSpend;
@property (weak, nonatomic) IBOutlet UILabel *totalGoodsCount;
@property (weak, nonatomic) IBOutlet UILabel *totalOrderCount;
@property (weak, nonatomic) IBOutlet UILabel *avgSpend;

@end

@implementation ECommerceReportDetailTypeStatisticsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = NO;
    // Initialization code
}
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview{
    static NSString *ID = @"ECommerceReportDetailTypeStatisticsCell";
    ECommerceReportDetailTypeStatisticsCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ECommerceReportDetailTypeStatisticsCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}
-(void)setModel:(JDorderStatisticsModel *)model{
    _model = model;
    _addSpend3Year.text = [NSString spaceString:model.addSpend3Year];
    _singleHightSpend.text = [NSString spaceString:model.singleHightSpend];
    _totalGoodsCount.text = [NSString spaceString:model.totalGoodsCount];
    _totalOrderCount.text = [NSString spaceString:model.totalOrderCount];
    _avgSpend.text = [NSString spaceString:model.avgSpend];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
