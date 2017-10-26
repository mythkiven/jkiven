//
//  ReportPersonalRiskInfoCell.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//


// 个人风险
typedef NS_ENUM(NSInteger,JReportPersonalRiskType){
    JReportRecordFayuanType = 0,
    JReportRecordDishonestType,
    JReportRecordLoadinfoType
};


#import <UIKit/UIKit.h>
static NSString *const ReportPersonalRiskInfoCellIdentifier = @"ReportPersonalRiskInfoCell";
// 个人风险提示 tableview 
@interface ReportPersonalRiskInfoCell :  UITableViewCell
/** 个人风险提示model*/
@property (strong,nonatomic) PersionRiskInfoModel      *persionRiskInfoModel;

+ (CGFloat)cellHeight:(PersionRiskInfoModel*)model;

@property (assign,nonatomic) JReportPersonalRiskType jReportRecordType;

@end
