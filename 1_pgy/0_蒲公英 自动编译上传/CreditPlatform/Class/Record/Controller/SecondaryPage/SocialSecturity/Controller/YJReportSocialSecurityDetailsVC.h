//
//  YJReportScialSecurityDetailsVC.h
//  CreditPlatform
//
//  Created by yj on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//  社保报告

#import "YJBaseSettingViewController.h"

@interface YJReportSocialSecurityDetailsVC : UITableViewController

@property (nonatomic, strong) YJSearchConditionModel *searchConditionModel;

@property (nonatomic, strong) NSMutableArray *dataSource;
/**用于区别轮训时间*/
@property (nonatomic, assign) SearchItemType  searchType;

@property (assign,nonatomic) BOOL      sdkEnter;

@property (strong,nonatomic) NSString  *sdktoken;


@end
