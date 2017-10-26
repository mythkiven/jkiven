//
//  YJHouseFundView.h
//  CreditPlatform
//
//  Created by yj on 16/7/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//  《公积金》报告的头部内容

#import <UIKit/UIKit.h>

@class YJHouseFundModel;
@interface YJHouseFundView : UIView

@property (nonatomic, strong) YJHouseFundModel *houseFundModel;

+ (id)houseFundView;


@end
