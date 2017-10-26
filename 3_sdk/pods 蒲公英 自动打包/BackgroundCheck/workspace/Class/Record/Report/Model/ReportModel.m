//
//  ReportModel.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "ReportModel.h"


// 主
@implementation ReportModel
-(void)setReportMsg:(ReportInfoModel *)reportMsg{
    _reportMsg = reportMsg;
    _reportMsg = [ ReportInfoModel mj_objectWithKeyValues:reportMsg];
}
-(void)setBasicMsg:(ReportBaseInfoModel *)BasicMsg{
    _BasicMsg = BasicMsg;
    _BasicMsg = [ ReportBaseInfoModel mj_objectWithKeyValues:BasicMsg];
}
-(void)setRiskMsg:(RiskTipsModel *)riskMsg{
    _riskMsg = riskMsg;
    _riskMsg = [ RiskTipsModel mj_objectWithKeyValues:riskMsg];
}
-(void)setBiographicalMsg:(PersionRecordModel *)BiographicalMsg{
    _BiographicalMsg = BiographicalMsg;
    _BiographicalMsg = [ PersionRecordModel mj_objectWithKeyValues:BiographicalMsg];
}
-(void)setPersonalRiskMsg:(PersionRiskInfoModel *)PersonalRiskMsg{
    _PersonalRiskMsg = PersonalRiskMsg;
    _PersonalRiskMsg = [PersionRiskInfoModel mj_objectWithKeyValues:PersonalRiskMsg];
}
@end


//////// 1. 报告基本信息 reportMsg
@implementation ReportInfoModel

@end



//////// 2. 基本信息 candidateMsg
@implementation ReportBaseInfoModel
-(void)setCandidateMsg:(ReportBaseInfoHouxuanModel *)candidateMsg{
    _candidateMsg = candidateMsg;
    _candidateMsg = [ReportBaseInfoHouxuanModel mj_objectWithKeyValues:candidateMsg];
}
-(void)setTwoMsg:(ReportBaseInfoTwoModel *)twoMsg{
    _twoMsg = twoMsg;
    _twoMsg =  [ReportBaseInfoTwoModel mj_objectWithKeyValues:twoMsg];
}
@end
// 2.1. 候选人信息
@implementation ReportBaseInfoHouxuanModel

@end
// 2.2. 双方信息
@implementation ReportBaseInfoTwoModel

@end



//////// 3. 风险提示
@implementation RiskTipsModel
@end




//////// 4. 个人履历信息
@implementation PersionRecordModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"acrdMsg" : [PersionRecordHegihtEducationModel class],
             @"vcqnMsg" : [PersionRecordQualificationsModel class]  };
}
@end
// 4.1. 最高学历
@implementation PersionRecordHegihtEducationModel
@end
// 4.2. 职业资格 vcqnMsg
@implementation PersionRecordQualificationsModel
@end




//////// 5 个人风险信息
@implementation PersionRiskInfoModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"linfMsg" : [PersionRiskInfoDaiKuanModel class],
             @"cligMsg" : [PersionRiskInfoFaYuanModel class],
             @"dishMsg" : [PersionRiskInfoShiXinModel class] };
}
@end
// 5.1 法院诉讼
@implementation PersionRiskInfoFaYuanModel
@end
// 5.2 失信被执行
@implementation PersionRiskInfoShiXinModel
@end
// 5.3 贷款信息
@implementation PersionRiskInfoDaiKuanModel
@end


