//
//  UIColor+Extension.h
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/3/7.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color;

@end
