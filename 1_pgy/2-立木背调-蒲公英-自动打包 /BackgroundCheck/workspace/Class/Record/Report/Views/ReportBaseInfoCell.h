//
//  ReportBaseInfoCell.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

// 基本信息
#import <UIKit/UIKit.h>

static NSString *const ReportBaseInfoCellIdentifier = @"ReportBaseInfoCell";

@interface ReportBaseInfoCell : UITableViewCell

@property (strong,nonatomic) ReportBaseInfoModel      * reportBaseInfoModel;

+ (CGFloat)cellHeight ;

@end
