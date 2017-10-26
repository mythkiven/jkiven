//
//  YJReportCarInsurancTypeVC.h
//  CreditPlatform
//
//  Created by yj on 2016/11/1.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJReportNetbankBillTypeVC : UITableViewController
@property (nonatomic, strong) YJSearchConditionModel *searchConditionModel;

/**用于区别轮训时间*/
@property (nonatomic, assign) SearchItemType  searchType;

@property (strong,nonatomic) NSString      *recodeType;
@end
