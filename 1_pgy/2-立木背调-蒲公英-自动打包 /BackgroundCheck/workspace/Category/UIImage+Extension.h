//
//  UIImage+Extension.h
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;
/**
 *  修改图片size
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
// 等比率缩放
- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;
//解决照片的横竖问题
- (UIImage *)fixOrientation;
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)resizedImageWithColor:(UIColor *)color;

/**
 *  压缩图片
 */
+ (NSData *)compressImageWidth:(long)w  height:(long)h type:(NSString*)type img:(UIImage *)img;
@end
