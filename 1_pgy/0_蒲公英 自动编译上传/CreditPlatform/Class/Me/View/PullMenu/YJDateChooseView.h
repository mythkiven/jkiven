//
//  YJDateChooseView.h
//  下拉菜单
//
//  Created by yj on 16/9/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YJDatePickerView;
typedef void(^HideDateChooseView)();
@interface YJDateChooseView : UIView
@property (nonatomic, copy) HideDateChooseView hideDateChooseView;
@property (nonatomic, strong) YJDatePickerView* picker;

+(instancetype)dateChooseViewHasToday:(BOOL)isHasToday;
- (void)clearSelectedDateBtnStyle;

@end
