//
//  YJReportHoseFundViewController.h
//  CreditPlatform
//
//  Created by yj on 16/7/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//  公积金报告

#import <UIKit/UIKit.h>
#import "YJReportHoseFundDetailsVC.h"
#import "YJBaseSettingViewController.h"
@interface YJReportHoseFundDetailsVC : YJBaseSettingViewController

@property (assign,nonatomic) BOOL      sdkEnter;

@property (strong,nonatomic) NSString  *sdktoken;


@end
