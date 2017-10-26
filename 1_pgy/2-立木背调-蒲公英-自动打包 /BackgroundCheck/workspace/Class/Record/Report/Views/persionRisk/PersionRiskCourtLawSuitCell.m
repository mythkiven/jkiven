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
@property (weak, nonatomic) IBOutlet UIView *shortLine;
@property (weak, nonatomic) IBOutlet UIView *line;

@end
static CGFloat cellHeight = 0;
@implementation PersionRiskCourtLawSuitCell

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
    //self.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentLabel.frame);
}
 
- (void)awakeFromNib {
    [super awakeFromNib];
    [_title sizeToFit];
    _title.font = [UIFont systemFontOfSize:15];
    [_shenjiecx sizeToFit];
    [_anyou sizeToFit];
    [_anjianzy sizeToFit];
    [_panjuejg sizeToFit];
    [self setLine];
}
-(void)setIsLastCell:(BOOL)isLastCell{
    _isLastCell =isLastCell;
    if (isLastCell) {
        _shortLine.hidden =YES;
        _line.hidden=NO;
    }
}
-(void)setPersionRiskInfoFaYuanModel:(PersionRiskInfoFaYuanModel *)persionRiskInfoFaYuanModel{
    _persionRiskInfoFaYuanModel = persionRiskInfoFaYuanModel;
    _isLastCell=NO;
    _title.text = [_persionRiskInfoFaYuanModel.title spaceString];
    _leibie.text = [_persionRiskInfoFaYuanModel.jtype spaceString];
    _name.text = [_persionRiskInfoFaYuanModel.court spaceString];
    _anhao.text = [_persionRiskInfoFaYuanModel.jnum spaceString];
    _ID.text = [_persionRiskInfoFaYuanModel.detailsid spaceString];
    _shenjiesj.text = [_persionRiskInfoFaYuanModel.judgeDate spaceString];
    _shenjiecx.text = [_persionRiskInfoFaYuanModel.jprocees spaceString];
    _dangshiren.text = [_persionRiskInfoFaYuanModel.dangshiren spaceString];
    _shangshuren.text = [_persionRiskInfoFaYuanModel.shangshuren spaceString];
    _beishangshuren.text = [_persionRiskInfoFaYuanModel.beishangshuren spaceString];
    _anyou.text = [_persionRiskInfoFaYuanModel.jcase spaceString];
    _anjianzy.text = [_persionRiskInfoFaYuanModel.jsummary spaceString];
    _panjuejg.text = [_persionRiskInfoFaYuanModel.resultStr spaceString];
    //self.tableHeightConstraint.constant = self.nestTableView.contentSize.height;
    
    _name.hidden =NO; _name.alpha = 1.0;
    _line.hidden =NO;_line.frame = CGRectMake(15, CGRectGetMaxY(_panjuejg.frame)+15, SCREEN_WIDTH-30, 1);
    cellHeight =0;
    
    CGFloat height1 = [self heightForString: _title.text fontSize:15 andWidth:SCREEN_WIDTH-101-15];
    CGFloat height2 = [self heightForString: _shenjiecx.text fontSize:15 andWidth:SCREEN_WIDTH-101-15];
    CGFloat height3 = [self heightForString: _anyou.text fontSize:15 andWidth:SCREEN_WIDTH-101-15];
    CGFloat height4 = [self heightForString: _anjianzy.text fontSize:15 andWidth:SCREEN_WIDTH-101-15];
    CGFloat height5 = [self heightForString: _panjuejg.text fontSize:15 andWidth:SCREEN_WIDTH-101-15];
    cellHeight = 421.0+height1+height2+height3+height4+height5-15*5.0+3*4.0;
    [self setLine];
    [self layoutIfNeeded];
    [self layoutSubviews];
    [self setNeedsLayout];
    
}
+ (CGFloat)cellHeight:(PersionRiskInfoFaYuanModel *)model{
    cellHeight =0;
    CGFloat height1 = [self heightForString: [model.title spaceString] fontSize:15 andWidth:SCREEN_WIDTH-101-15];
    CGFloat height2 = [self heightForString: [model.jprocees spaceString] fontSize:15 andWidth:SCREEN_WIDTH-101-15];
    CGFloat height3 = [self heightForString: [model.jcase spaceString] fontSize:15 andWidth:SCREEN_WIDTH-101-15];
    CGFloat height4 = [self heightForString: [model.jsummary spaceString]  fontSize:15  andWidth:SCREEN_WIDTH-101-15];
    CGFloat height5 = [self heightForString: [model.resultStr spaceString]  fontSize:15 andWidth:SCREEN_WIDTH-101-15];
   
    cellHeight = 421.0+height1+height2+height3+height4+height5-15*5.0+3*4.0;
    if (cellHeight>800) {
        cellHeight = cellHeight-4.5;
    } else {
        cellHeight = cellHeight+6.0;
    }
    NSLog(@"=======%lf",cellHeight); // 859 528 549
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
