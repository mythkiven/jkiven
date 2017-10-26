//
//  YJSocialSecurityView.h
//  CreditPlatform
//
//  Created by yj on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//  《社保》报告的头部内容

#import <UIKit/UIKit.h>
@class YJSocialSecurityModel;
@interface YJSocialSecurityView : UIView

@property (nonatomic, strong) YJSocialSecurityModel *socialSecurityModel;

+ (instancetype)socialSecurityView;
@end
