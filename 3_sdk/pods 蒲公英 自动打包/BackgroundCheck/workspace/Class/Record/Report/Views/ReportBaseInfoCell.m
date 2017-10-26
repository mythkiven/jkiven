//
//  ReportBaseInfoCell.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "ReportBaseInfoCell.h"

@interface ReportBaseInfoCell  () // <UITableViewDataSource,UITableViewDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *weituofang;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *houxuanren;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *zhiwei;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *name;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *ID;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *sex;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *age;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *phone;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *area;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *sanyaosu;


@end


@implementation ReportBaseInfoCell

- (void)awakeFromNib {
    [super awakeFromNib]; 
}

-(void)setReportBaseInfoModel:(ReportBaseInfoModel *)reportBaseInfoModel{
    _reportBaseInfoModel = reportBaseInfoModel;
    
    _weituofang.text    = reportBaseInfoModel.twoMsg.principal;
    _houxuanren.text    = reportBaseInfoModel.twoMsg.candidate;
    _zhiwei.text        = reportBaseInfoModel.twoMsg.position;
    
    _name.text  = reportBaseInfoModel.candidateMsg.name;
    _ID.text    = reportBaseInfoModel.candidateMsg.identityNo;
    _sex.text   = reportBaseInfoModel.candidateMsg.gender;
    _age.text   = reportBaseInfoModel.candidateMsg.age;
    _phone.text = reportBaseInfoModel.candidateMsg.mobile;
    _area.text  = reportBaseInfoModel.candidateMsg.mobileNoTrack;
    
}

@end
