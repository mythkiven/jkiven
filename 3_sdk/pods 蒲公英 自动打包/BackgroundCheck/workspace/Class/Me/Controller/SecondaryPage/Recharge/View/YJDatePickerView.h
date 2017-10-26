//
//  YJDatePickerView.h
//  CreditPlatform
//
//  Created by yj on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kToolBarH 45
#define kDatePickerH 216
#define kDatePickerViewHeight (kDatePickerH+kToolBarH)

typedef void (^YJDatePickerViewResult)(NSDate* currentDate,int index);

@interface YJDatePickerView : UIView


@property ( nonatomic, strong) NSDate *minimumDate;

@property ( nonatomic, strong) NSDate *maximumDate;



@property (nonatomic, copy) YJDatePickerViewResult  resultCallBack;

- (void)show;
- (void)hidden;

@end
