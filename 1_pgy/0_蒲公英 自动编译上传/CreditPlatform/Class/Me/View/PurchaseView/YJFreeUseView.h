//
//  YJFreeUseView.h
//  CreditPlatform
//
//  Created by yj on 16/9/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJFreeUseView : UIView
/**
 *  剩余天数
 */
@property (nonatomic, copy) NSString *remainingDays;
/**
 *  截止日期
 */
@property (nonatomic, copy) NSString *limitDate;

+ (instancetype)freeUseView ;
@end
