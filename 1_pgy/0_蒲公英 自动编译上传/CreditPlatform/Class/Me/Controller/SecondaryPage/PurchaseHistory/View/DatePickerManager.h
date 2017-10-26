//
//  YJDatePickerView.h
//  CreditPlatform
//
//  Created by yj on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kToolBarH 45
 
#define kDatePickerH (185+10+10)
#define kDatePickerViewHeight (kToolBarH)
@protocol DatePickerManagerDelegate <NSObject>

- (void)didSelectedDate:(NSString* )currentDate WithIndex:(NSString *) index;
@end


typedef void (^DatePickerManagerResult)(NSString* currentDate,NSString * index);

@interface DatePickerManager : UIView
@property (weak,nonatomic) id  <DatePickerManagerDelegate> delegate;
@property (nonatomic, copy) DatePickerManagerResult  resultCallBack;
// 日期复原到今天
-(void)setOriginal;
// 日期最早为三月前
-(void)setOriginalOld;
- (void)show;
- (void)hidden;

@end
