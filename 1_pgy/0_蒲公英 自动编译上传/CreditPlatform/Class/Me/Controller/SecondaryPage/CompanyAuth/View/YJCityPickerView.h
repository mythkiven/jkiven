//
//  YJCityPickerView.h
//  CreditPlatform
//
//  Created by yj on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kToolBarH 45
#define kDatePickerH 216
#define kDatePickerViewHeight (kDatePickerH+kToolBarH)

typedef void (^YJCityPickerViewResult)(NSString* province,NSString* city,int index);

@interface YJCityPickerView : UIView
@property (nonatomic, copy) YJCityPickerViewResult  resultCallBack;

- (void)show;
- (void)hidden;

@end
