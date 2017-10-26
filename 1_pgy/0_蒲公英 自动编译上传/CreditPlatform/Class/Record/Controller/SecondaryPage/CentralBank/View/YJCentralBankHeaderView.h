//
//  YJCentralBankHeaderView.h
//  CreditPlatform
//
//  Created by yj on 16/7/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//  《公积金》报告的头部内容

#import <UIKit/UIKit.h>
#import "YJCentralBankModel.h"
@class YJCentralBankModel;
@interface YJCentralBankHeaderView : UIView

@property (nonatomic, strong) YJCentralBankBasicInfoModel *basicInfoModel;

+ (id)centralBankView;


@end
