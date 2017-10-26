//
//  PersionRiskDishonestsCell.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "PersionRiskDishonestsCell.h"

@interface PersionRiskDishonestsCell ()
@property (weak, nonatomic) IBOutlet UILabel *lianshijian;
@property (weak, nonatomic) IBOutlet UILabel *shenfen;
@property (weak, nonatomic) IBOutlet UILabel *zhixingfayuan;
@property (weak, nonatomic) IBOutlet UILabel *xuhao;
@property (weak, nonatomic) IBOutlet UILabel *zhixingwenanhao;
@property (weak, nonatomic) IBOutlet UILabel *anhao;
@property (weak, nonatomic) IBOutlet UILabel *zuochuzhixingyjdw;
@property (weak, nonatomic) IBOutlet UILabel *shengxiaofalws;
@property (weak, nonatomic) IBOutlet UILabel *beizhxiingren;
@property (weak, nonatomic) IBOutlet UILabel *jutiqingxing;

@end

@implementation PersionRiskDishonestsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setPersionRiskInfoShiXinModel:(PersionRiskInfoShiXinModel *)persionRiskInfoShiXinModel{
    _persionRiskInfoShiXinModel = persionRiskInfoShiXinModel;
    _lianshijian.text = _persionRiskInfoShiXinModel.filingTime;
    _shenfen.text = _persionRiskInfoShiXinModel.province;
    _zhixingfayuan.text = _persionRiskInfoShiXinModel.executiveCourt;
    _xuhao.text = _persionRiskInfoShiXinModel.no;
    _zhixingwenanhao.text = _persionRiskInfoShiXinModel.executiveBaiscNo;
    _anhao.text = _persionRiskInfoShiXinModel.caseNo;
    _zuochuzhixingyjdw.text = _persionRiskInfoShiXinModel.executiveArm;
    _shengxiaofalws.text = _persionRiskInfoShiXinModel.legalObligation;
    _beizhxiingren.text = _persionRiskInfoShiXinModel.executiveCase;
    _jutiqingxing.text = _persionRiskInfoShiXinModel.specificSituation;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
