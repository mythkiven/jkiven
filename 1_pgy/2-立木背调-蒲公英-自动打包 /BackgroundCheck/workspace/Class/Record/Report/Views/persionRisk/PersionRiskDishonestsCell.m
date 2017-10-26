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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height2;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *shortLine;

@end
static CGFloat cellHeight = 0;
@implementation PersionRiskDishonestsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_zhixingfayuan sizeToFit];
    [_zuochuzhixingyjdw sizeToFit];
    [_shengxiaofalws sizeToFit];
    [_beizhxiingren sizeToFit];
    [_jutiqingxing sizeToFit];
    
    [self setLine];
}
-(void)setIsLastCell:(BOOL)isLastCell{
    _isLastCell =isLastCell;
    if (isLastCell) {
        _shortLine.hidden =YES;
        _line.hidden=NO;
    }
}
-(void)setPersionRiskInfoShiXinModel:(PersionRiskInfoShiXinModel *)persionRiskInfoShiXinModel{
    _persionRiskInfoShiXinModel = persionRiskInfoShiXinModel;
    _isLastCell=NO;
    _lianshijian.text = [_persionRiskInfoShiXinModel.filingTime spaceString];
    _shenfen.text = [_persionRiskInfoShiXinModel.province spaceString];
    _zhixingfayuan.text = [_persionRiskInfoShiXinModel.executiveCourt spaceString];
    _xuhao.text = [_persionRiskInfoShiXinModel.no spaceString];
    _zhixingwenanhao.text = [_persionRiskInfoShiXinModel.executiveBaiscNo spaceString];
    _anhao.text = [_persionRiskInfoShiXinModel.caseNo spaceString];
    _zuochuzhixingyjdw.text = [_persionRiskInfoShiXinModel.executiveArm spaceString];
    _shengxiaofalws.text = [_persionRiskInfoShiXinModel.legalObligation spaceString];
    _beizhxiingren.text = [_persionRiskInfoShiXinModel.executiveCase spaceString];
    _jutiqingxing.text = [_persionRiskInfoShiXinModel.specificSituation spaceString];
    
    cellHeight=0;
    CGFloat height1 = [self heightForString: [_zhixingwenanhao.text spaceString] fontSize:15 andWidth:SCREEN_WIDTH-127-15];//执行依据文号
    CGFloat height2 = [self heightForString: [_anhao.text spaceString] fontSize:15 andWidth:SCREEN_WIDTH-127-15];//案号
    CGFloat height3 = [self heightForString: [_shengxiaofalws.text spaceString] fontSize:15 andWidth:SCREEN_WIDTH-127-15];//生效法律文书确定的义务
    CGFloat height4 = [self heightForString: [_beizhxiingren.text spaceString] fontSize:15 andWidth:SCREEN_WIDTH-127-15];//履行情况
    CGFloat height5 = [self heightForString: [_jutiqingxing.text spaceString] fontSize:15 andWidth:SCREEN_WIDTH-127-15];//具体情形
    
    if (height3<=15)  _height1.constant = 36;
    else _height1.constant = 15;
    
    if (height4<=15)  _height2.constant = 36;
    else _height2.constant = 15;
    
    //cellHeight = 397+height1+height2+height3+height4+height5-15*5-3*4+0.5;
    
    [self setLine];
}
+ (CGFloat)cellHeight:(PersionRiskInfoShiXinModel *)model{
    cellHeight=0;
    CGFloat height1 = [self heightForString: [model.executiveBaiscNo spaceString] fontSize:15 andWidth:SCREEN_WIDTH-127-15];//执行依据文号
    CGFloat height2 = [self heightForString: [model.caseNo spaceString] fontSize:15 andWidth:SCREEN_WIDTH-127-15];//案号
    CGFloat height3 = [self heightForString: [model.legalObligation spaceString] fontSize:15 andWidth:SCREEN_WIDTH-127-15];//生效法律文书确定的义务
    CGFloat height4 = [self heightForString: [model.executiveCase spaceString] fontSize:15 andWidth:SCREEN_WIDTH-127-15];//履行情况
    CGFloat height5 = [self heightForString: [model.specificSituation  spaceString] fontSize:15 andWidth:SCREEN_WIDTH-127-15];//具体情形
    
    cellHeight = 397+height1+height2+height3+height4+height5-15*5-3*4+0.5;
    
    return cellHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
@end
