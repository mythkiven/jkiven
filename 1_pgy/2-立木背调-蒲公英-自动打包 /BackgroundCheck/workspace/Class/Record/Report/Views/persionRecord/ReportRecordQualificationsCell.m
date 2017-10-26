//
//  ReportRecordQualificationsCell.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "ReportRecordQualificationsCell.h"

@interface ReportRecordQualificationsCell ()
@property (weak, nonatomic) IBOutlet UILabel *zhenghsumingc;
@property (weak, nonatomic) IBOutlet UILabel *banzhengriqi;
@property (weak, nonatomic) IBOutlet UILabel *zhenghujibie;
@property (weak, nonatomic) IBOutlet UILabel *fazhengdanwei;
@property (weak, nonatomic) IBOutlet UILabel *zhengshubianhap;
@property (weak, nonatomic) IBOutlet UIView *langLine;
@property (weak, nonatomic) IBOutlet UIView *shortLine;

@end
static CGFloat cellHeight = 171;
@implementation ReportRecordQualificationsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _langLine.hidden=YES;
    _shortLine.hidden=NO;
    // Initialization code
}
-(void)setPersionRecordQualificationsModel:(PersionRecordQualificationsModel *)persionRecordQualificationsModel{
    _persionRecordQualificationsModel = persionRecordQualificationsModel;
    _zhenghsumingc.text = [_persionRecordQualificationsModel.occupation spaceString];
    _banzhengriqi.text = [_persionRecordQualificationsModel.banZhengRiQi spaceString];
    _zhenghujibie.text = [_persionRecordQualificationsModel.level spaceString];
    _fazhengdanwei.text = [_persionRecordQualificationsModel.submitOrgName spaceString];
    _zhengshubianhap.text = [_persionRecordQualificationsModel.certificateid spaceString];
}
-(void)setHiddenLine:(BOOL)hiddenLine{
    _langLine.hidden=NO;
    _shortLine.hidden=YES;
}
+ (CGFloat)cellHeight{
    return cellHeight;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
