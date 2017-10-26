//
//  YJSocialSecurityDetailsVC.h
//  CreditPlatform
//
//  Created by yj on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//  社保 存缴明细

#import <UIKit/UIKit.h>
@interface YJSocialSecurityDetailsVC : UITableViewController
@property (nonatomic, strong) NSArray *insuranceDataArr;
@property (nonatomic, assign) BOOL isMaternity; //是否是医疗保险


@end
