//
//  ReportRecordEducationCell.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "ReportRecordEducationCell.h"

@interface ReportRecordEducationCell ()
@property (weak, nonatomic) IBOutlet UILabel *biyeyuanxiao;
@property (weak, nonatomic) IBOutlet UILabel *xueixoaleibie;
@property (weak, nonatomic) IBOutlet UILabel *ruxuenianfen;
@property (weak, nonatomic) IBOutlet UILabel *biyeshijian;
@property (weak, nonatomic) IBOutlet UILabel *zhuanehymingc;
@property (weak, nonatomic) IBOutlet UILabel *xueli;
@property (weak, nonatomic) IBOutlet UILabel *xuelileixing;

@end

@implementation ReportRecordEducationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setPersionRecordHegihtEducationModel:(PersionRecordHegihtEducationModel *)persionRecordHegihtEducationModel{
    _persionRecordHegihtEducationModel = persionRecordHegihtEducationModel;
    _biyeyuanxiao.text = _persionRecordHegihtEducationModel.graduate;
    _xueixoaleibie.text = _persionRecordHegihtEducationModel.schoolCategory;
    _ruxuenianfen.text  = _persionRecordHegihtEducationModel.enrolDate;
    _biyeshijian.text = _persionRecordHegihtEducationModel.graduateTime;
    _zhuanehymingc.text = _persionRecordHegihtEducationModel.specialityName;
    _xueli.text = _persionRecordHegihtEducationModel.educationDegree;
    _xuelileixing.text = _persionRecordHegihtEducationModel.studyStyle;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
