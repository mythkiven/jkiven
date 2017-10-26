//
//  ReportPersonalRiskInfoCell.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const ReportPersonalRiskInfoCellIdentifier = @"ReportPersonalRiskInfoCell";
// 个人风险提示 tableview 
@interface ReportPersonalRiskInfoCell :  UITableViewCell
/** 个人风险提示model*/
@property (strong,nonatomic) PersionRiskInfoModel      *persionRiskInfoModel;

@end
