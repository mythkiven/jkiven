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
@property (weak, nonatomic) IBOutlet UIView *shortLine;
@property (weak, nonatomic) IBOutlet UIView *line;

@end
static CGFloat cellHeight = 232;
@implementation PersionRiskloanInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setLine];
    
}
-(void)setPersionRiskInfoDaiKuanModel:(PersionRiskInfoDaiKuanModel *)persionRiskInfoDaiKuanModel{
    _persionRiskInfoDaiKuanModel = persionRiskInfoDaiKuanModel;
    _isLastCell=NO;
    _jiekuanleixing.text = [_persionRiskInfoDaiKuanModel.borrowType spaceString];
    _gerenxindai.text = [_persionRiskInfoDaiKuanModel.borrowState spaceString];
    _jiekuanjine.text = [_persionRiskInfoDaiKuanModel.borrowAmount spaceString];
    _jiekuanqishu.text = [_persionRiskInfoDaiKuanModel.contractDate spaceString];
    _dangqianzhuangtia.text = [_persionRiskInfoDaiKuanModel.repayState spaceString];
    _qiankuanjine.text = [_persionRiskInfoDaiKuanModel.arrearsAmount spaceString];
    [self setLine];
}
-(void)setIsLastCell:(BOOL)isLastCell{
    _isLastCell =isLastCell;
    if (isLastCell) {
        _shortLine.hidden =YES;
        _line.hidden=NO;
    }
}
+ (CGFloat)cellHeight{
    return cellHeight;
}
-(void)setLine{
    if (_isLastCell) {
        _shortLine.hidden =YES;
        _line.hidden=NO;
    }else{
        _shortLine.hidden =NO;
        _line.hidden=YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
