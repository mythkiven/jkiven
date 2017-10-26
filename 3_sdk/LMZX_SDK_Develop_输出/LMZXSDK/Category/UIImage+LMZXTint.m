//
//  UIImage+LMZXTint.m
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/2/21.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "UIImage+LMZXTint.h"

@implementation UIImage (LMZXTint)

+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)resizedImageWithColor:(UIColor *)color {
    
    UIImage *theImage =  [UIImage imageWithColor:color];
    return [theImage stretchableImageWithLeftCapWidth:theImage.size.width * 0.5 topCapHeight:theImage.size.height * 0.5];
}






- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}


/**
 SDK中加载图片

 */
+ (UIImage *)imageFromBundle:(NSString *)imgName type:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"lmzxResource" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    NSString *file = [bundle pathForResource:imgName ofType:type];
    return [UIImage imageWithContentsOfFile:file];
}

/**
 bundle中加载图片

 @param bundleName bundle名字，不带后缀
 @param imgName 图片名字，不带后缀
 */
+ (UIImage *)imageFromBundle:(NSString *)bundleName name:(NSString *)imgName {
    NSString *name = [NSString stringWithFormat:@"%@.bundle/%@",bundleName, imgName];
    if (bundleName == nil || [bundleName isEqualToString:@""]) {
        name = imgName;
    }
    return [UIImage imageNamed:name];
}


@end
