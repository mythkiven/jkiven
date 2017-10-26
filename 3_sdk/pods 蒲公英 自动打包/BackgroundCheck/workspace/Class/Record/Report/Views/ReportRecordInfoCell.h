//
//  ReportRecordInfoCell.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

// 个人履历信息 tableview
#import <UIKit/UIKit.h>
static NSString *const ReportRecordInfoCellIdentifier = @"ReportRecordInfoCell";
@interface ReportRecordInfoCell : UITableViewCell
/** 个人履历信息model*/
@property (strong,nonatomic) PersionRecordModel      *persionRecordModel;

@end
