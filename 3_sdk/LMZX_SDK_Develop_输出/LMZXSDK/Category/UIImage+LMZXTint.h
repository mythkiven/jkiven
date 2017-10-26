//
//  UIImage+LMZXTint.h
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/2/21.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LMZXTint)
/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)resizedImageWithColor:(UIColor *)color;


- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;


/**
 SDK的bundle中加载图片
 */
+ (UIImage *)imageFromBundle:(NSString *)imgName type:(NSString *)type;
+ (UIImage *)imageFromBundle:(NSString *)bundleName name:(NSString *)imgName;


@end
