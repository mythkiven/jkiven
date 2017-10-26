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

@end

@implementation ReportRecordQualificationsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setPersionRecordQualificationsModel:(PersionRecordQualificationsModel *)persionRecordQualificationsModel{
    _persionRecordQualificationsModel = persionRecordQualificationsModel;
    _zhenghujibie.text = _persionRecordQualificationsModel.occupation;
    _banzhengriqi.text = _persionRecordQualificationsModel.banZhengRiQi;
    _zhenghujibie.text = _persionRecordQualificationsModel.level;
    _fazhengdanwei.text = _persionRecordQualificationsModel.submitOrgName;
    _zhengshubianhap.text = _persionRecordQualificationsModel.certificateid;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
