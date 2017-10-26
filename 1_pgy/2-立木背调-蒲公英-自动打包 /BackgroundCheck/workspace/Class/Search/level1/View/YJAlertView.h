//
//  YJAlertView.h
//  YJAlertView
//
//  Created by yj on 16/9/12.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Handler)(int index);

@interface YJAlertView : UIView

@property (nonatomic, weak) UILabel *titleLB;

@property (nonatomic, weak) UILabel *messageLB;

/**
 *  点击按钮回调
 */
@property (nonatomic, copy) Handler handler;

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *message;

/**
 *  初始化
 *
 *  @param title   标题
 *  @param message 提示内容
 *
 */
- (instancetype)initWithTitle:( NSString *)title message:( NSString *)message;
/**
 *  操作按钮
 *
 *  @param title 按钮标题
 */
- (void)addButtonWithTitle:( NSString *)title ;

/**
 *  显示
 */
- (void)show;
@end


