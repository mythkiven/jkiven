//
//  YJBaseReportViewController.h
//  CreditPlatform
//
//  Created by yj on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//  公积金、社保、运营商、电商报告控制器的父控制器

#import <UIKit/UIKit.h>

#import "ResultWebViewController.h"

@interface YJBaseReportViewController : UITableViewController


/**
 *  搜索类型
 *  公积金  --->housefund
 *  社保    --->socialsecurity
 *  运营商  --->mobile
 *  京东    --->jd
 *  学信    --->education
 *  央行    --->credit
 *  淘宝    --->taobao
 *  脉脉    --->maimai
 *  领英    --->linkedin
 *
 */

//@property (nonatomic, strong) NSString *token;


@property (nonatomic, strong) NSString *searchType;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
