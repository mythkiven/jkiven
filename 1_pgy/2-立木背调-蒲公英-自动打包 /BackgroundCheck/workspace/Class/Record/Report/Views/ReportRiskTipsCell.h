//
//  ReportRiskTipsCell.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

// 风险提示
#import <UIKit/UIKit.h>
static NSString *const ReportRiskTipsCellIdentifier = @"ReportRiskTipsCell";
@interface ReportRiskTipsCell : UITableViewCell

@property (strong,nonatomic) RiskTipsModel *riskTipsModel;

+ (CGFloat)cellHeight ;
@end
