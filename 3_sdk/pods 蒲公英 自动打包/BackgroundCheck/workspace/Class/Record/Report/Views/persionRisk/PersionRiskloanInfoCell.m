//
//  PersionRiskloanInfoCell.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "PersionRiskloanInfoCell.h"

@interface PersionRiskloanInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *jiekuanleixing;
@property (weak, nonatomic) IBOutlet UILabel *gerenxindai;
@property (weak, nonatomic) IBOutlet UILabel *jiekuanjine;
@property (weak, nonatomic) IBOutlet UILabel *jiekuanriqi;
@property (weak, nonatomic) IBOutlet UILabel *jiekuanqishu;
@property (weak, nonatomic) IBOutlet UILabel *dangqianzhuangtia;
@property (weak, nonatomic) IBOutlet UILabel *qiankuanjine;

@end

@implementation PersionRiskloanInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setPersionRiskInfoDaiKuanModel:(PersionRiskInfoDaiKuanModel *)persionRiskInfoDaiKuanModel{
    _persionRiskInfoDaiKuanModel = persionRiskInfoDaiKuanModel;
    _jiekuanleixing.text = _persionRiskInfoDaiKuanModel.borrowType;
    _gerenxindai.text = _persionRiskInfoDaiKuanModel.borrowState;
    _jiekuanjine.text = _persionRiskInfoDaiKuanModel.borrowAmount;
    _jiekuanqishu.text = _persionRiskInfoDaiKuanModel.contractDate;
    _dangqianzhuangtia.text = _persionRiskInfoDaiKuanModel.repayState;
    _qiankuanjine.text = _persionRiskInfoDaiKuanModel.arrearsAmount;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
