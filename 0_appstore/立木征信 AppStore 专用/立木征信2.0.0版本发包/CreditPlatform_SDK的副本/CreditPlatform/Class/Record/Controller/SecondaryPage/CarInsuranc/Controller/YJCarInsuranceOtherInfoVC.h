//
//  YJCarInsuranceOtherInfoVC.h
//  CreditPlatform
//
//  Created by yj on 2016/11/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CarInsuranceShowTypePolicy = 1111,  // 保单信息
    CarInsuranceShowTypeCarInfo,  // 车辆信息
    CarInsuranceShowTypeTax  // 代收车船税
} CarInsuranceShowType;


@class YJCarInsurancePolicyDetails;
@interface YJCarInsuranceOtherInfoVC :  UITableViewController

@property (nonatomic, assign) CarInsuranceShowType showType;


@property (nonatomic, strong) YJCarInsurancePolicyDetails *policyDetails;

@end
