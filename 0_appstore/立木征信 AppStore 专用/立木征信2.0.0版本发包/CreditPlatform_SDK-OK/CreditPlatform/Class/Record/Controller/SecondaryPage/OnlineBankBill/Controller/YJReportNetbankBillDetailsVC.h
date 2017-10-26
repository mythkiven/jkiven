//
//  YJCarInsuranceDetailsVC.h
//  CreditPlatform
//
//  Created by yj on 2016/11/1.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJBaseSettingViewController.h"
@class YJEBankBillModel;
@interface YJReportNetbankBillDetailsVC : YJBaseSettingViewController

@property (nonatomic, strong) YJEBankBillModel *eBankBillModel;
@property (nonatomic, assign) int index;

@end
