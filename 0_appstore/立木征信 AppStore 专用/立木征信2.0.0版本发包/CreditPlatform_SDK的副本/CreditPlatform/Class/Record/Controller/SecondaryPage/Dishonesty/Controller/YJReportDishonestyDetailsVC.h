//
//  YJReportDishonestyDetailsVC.h
//  CreditPlatform
//
//  Created by yj on 2016/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJBaseSettingViewController.h"

@interface YJReportDishonestyDetailsVC : UITableViewController
@property (nonatomic, strong) YJSearchConditionModel *searchConditionModel;

/**用于区别轮训时间*/
@property (nonatomic, assign) SearchItemType  searchType;

@property (strong,nonatomic) NSString      *recodeType;
@end
