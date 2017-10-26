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

static CGFloat cellHeight = 230.5;

@implementation ReportRecordEducationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setPersionRecordHegihtEducationModel:(PersionRecordHegihtEducationModel *)persionRecordHegihtEducationModel{
    _persionRecordHegihtEducationModel = persionRecordHegihtEducationModel;
    _biyeyuanxiao.text = [_persionRecordHegihtEducationModel.graduate spaceString];
    _xueixoaleibie.text = [_persionRecordHegihtEducationModel.schoolCategory spaceString];
    _ruxuenianfen.text  = [_persionRecordHegihtEducationModel.enrolDate spaceString];
    _biyeshijian.text = [_persionRecordHegihtEducationModel.graduateTime spaceString];
    _zhuanehymingc.text = [_persionRecordHegihtEducationModel.specialityName spaceString];
    _xueli.text = [_persionRecordHegihtEducationModel.educationDegree spaceString];
    _xuelileixing.text = [_persionRecordHegihtEducationModel.studyStyle spaceString];
    
    
}

+ (CGFloat)cellHeight{
    return cellHeight;
}

 

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
