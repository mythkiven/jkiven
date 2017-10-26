//
//  PersionRiskCourtLawSuitCell.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "PersionRiskCourtLawSuitCell.h"

@interface PersionRiskCourtLawSuitCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *leibie;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *anhao;
@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *shenjiesj;
@property (weak, nonatomic) IBOutlet UILabel *shenjiecx;
@property (weak, nonatomic) IBOutlet UILabel *dangshiren;
@property (weak, nonatomic) IBOutlet UILabel *shangshuren;
@property (weak, nonatomic) IBOutlet UILabel *beishangshuren;
@property (weak, nonatomic) IBOutlet UILabel *anyou;
@property (weak, nonatomic) IBOutlet UILabel *anjianzy;
@property (weak, nonatomic) IBOutlet UILabel *panjuejg;

@end

@implementation PersionRiskCourtLawSuitCell

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
    //self.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentLabel.frame);
}
 
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setPersionRiskInfoFaYuanModel:(PersionRiskInfoFaYuanModel *)persionRiskInfoFaYuanModel{
    _persionRiskInfoFaYuanModel = persionRiskInfoFaYuanModel;
    _title.text = _persionRiskInfoFaYuanModel.title;
    _leibie.text = _persionRiskInfoFaYuanModel.jtype;
    _name.text = _persionRiskInfoFaYuanModel.court;
    _anhao.text = _persionRiskInfoFaYuanModel.jnum;
    _ID.text = _persionRiskInfoFaYuanModel.certificateid;
    _shenjiesj.text = _persionRiskInfoFaYuanModel.judgeDate;
    _shenjiecx.text = _persionRiskInfoFaYuanModel.jprocees;
    _dangshiren.text = _persionRiskInfoFaYuanModel.dangshiren;
    _shangshuren.text = _persionRiskInfoFaYuanModel.shangshuren;
    _beishangshuren.text = _persionRiskInfoFaYuanModel.beishangshuren;
    _anyou.text = _persionRiskInfoFaYuanModel.jcase;
    _anjianzy.text = _persionRiskInfoFaYuanModel.jsummary;
    _panjuejg.text = _persionRiskInfoFaYuanModel.resultStr;
    //self.tableHeightConstraint.constant = self.nestTableView.contentSize.height; 
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
