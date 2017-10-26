//
//  JInputTextView.h
//  JInputTextView  
//  Created by gyjrong on 2017/9/19.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
UIKIT_EXTERN NSNotificationName const JInputTextViewDidBecomeFirstResponderNotification;
UIKIT_EXTERN NSNotificationName const JInputTextViewDidResignFirstResponderNotification;
#else
UIKIT_EXTERN NSString *const JInputTextViewDidBecomeFirstResponderNotification;
UIKIT_EXTERN NSString *const JInputTextViewDidResignFirstResponderNotification;
#endif

typedef NS_ENUM(NSUInteger, JQKeyboardType) {
    JQKeyboardTypeNumberPad,   // 纯数字键盘
    JQKeyboardTypeASCIICapable // ASCII 字符键盘
};

@protocol JInputTextViewDelegate;

IB_DESIGNABLE

@interface JInputTextView : UIControl

@property (nullable, nonatomic, weak) id<JInputTextViewDelegate> delegate;

// 字符串
@property (nullable, nonatomic, copy, readonly) NSString *text;
// 密文
@property (nonatomic, assign, getter=isSecureTextEntry) IBInspectable BOOL secureTextEntry;

#if TARGET_INTERFACE_BUILDER
// 文本框个数
@property (nonatomic, assign) IBInspectable NSUInteger inputUnitCount;
#else
@property (nonatomic, assign) NSUInteger inputUnitCount;
#endif

#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSInteger defaultKeyboardType;
@property (nonatomic, assign) IBInspectable NSInteger defaultReturnKeyType;
#else
@property (nonatomic, assign) JQKeyboardType defaultKeyboardType;
@property (nonatomic, assign) UIReturnKeyType defaultReturnKeyType;
#endif


//  每个 Unit间距
@property (nonatomic, assign) IBInspectable CGFloat unitSpace;
// 设置边框圆角
@property (nonatomic, assign) IBInspectable CGFloat borderRadius;
// 设置边框宽度
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
// 设置文本字体
@property (nonatomic, strong) IBInspectable UIFont *textFont;
// 设置文本颜色
@property (null_resettable, nonatomic, strong) IBInspectable UIColor *textColor;
// 文本框颜色
@property (null_resettable, nonatomic, strong) IBInspectable UIColor *tintColor;
// 跟踪的文本框颜色
@property (nullable, nonatomic, strong) IBInspectable UIColor *trackTintColor;
// 光标
@property (nullable, nonatomic, strong) IBInspectable UIColor *cursorColor;
// 是否需要取消第一响应者
@property (nonatomic, assign) IBInspectable BOOL autoResignFirstResponderWhenInputFinished;

- (instancetype)initWithInputUnitCount:(NSUInteger)count;

-(void)setFirstEvent:(NSInteger)index;
@end

@protocol JInputTextViewDelegate <NSObject>

@optional

- (BOOL)unitField:(JInputTextView *)uniField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
