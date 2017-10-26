//
//  YJCarInsuranceDetailsVC.h
//  CreditPlatform
//
//  Created by yj on 2016/11/1.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJBaseSettingViewController.h"
@class YJCarInsuranceModel;
@interface YJCarInsuranceDetailsVC : YJBaseSettingViewController
@property (nonatomic, strong) YJCarInsuranceModel *carInsuranceModel;
@property (nonatomic, assign) int index;

@end
