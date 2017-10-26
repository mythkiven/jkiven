//
//  UIImage+Extension.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIImage+Extension.h"
#define ImageMaxSize 1024*(1024-24)
#define ImageMaxWidth  1800
#define ImageMaxHeight 1600
@implementation UIImage (Extension)


+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
//        MYLog(@"could not scale image");
    
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *)fixOrientation {
    
    
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
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


#pragma mark------压缩图片
+ (NSData *)compressImageWidth:(long)w  height:(long)h type:(NSString*)type img:(UIImage *)img {
    
    NSData *imgdata;
    //解决照片横竖
    long temp;
    switch (img.imageOrientation) {
        case UIImageOrientationLeft|UIImageOrientationRight:
            temp = w;
            w = h;
            h= temp;
            break;
        default:
            break;
    }
    img = [img fixOrientation];
    //压缩
    if([type isEqualToString:@"JPG"]){
        if (UIImageJPEGRepresentation(img, 1).length>=ImageMaxSize) {//大小 大于1M
            imgdata = UIImageJPEGRepresentation(img, 1);
            if (w>ImageMaxWidth&&h>ImageMaxHeight) {
                UIImage * newimg = [UIImage scaleToSize:img size:[self newSizeWithWidth:w height:h]];
                imgdata = UIImageJPEGRepresentation(newimg, 1);
                if (imgdata.length>ImageMaxSize) {
                    imgdata = [self saveSmallJpg:imgdata];
                }
            }else{
                if (imgdata.length>ImageMaxSize) {
                    imgdata = [self saveSmallJpg:imgdata];
                }
            }
        } else {
            imgdata = UIImageJPEGRepresentation(img, 1);
        }
    }else if ([type isEqualToString: @"PNG"]){
        if (UIImagePNGRepresentation(img).length>=ImageMaxSize) {//大小 大于1M
            imgdata = UIImagePNGRepresentation(img);
            if (w>ImageMaxWidth&&h>ImageMaxHeight) {//压缩size
                UIImage * newimg = [UIImage scaleToSize:img size:[self newSizeWithWidth:w height:h]];
                imgdata = UIImagePNGRepresentation(newimg);
                if (imgdata.length>ImageMaxSize) {
                    imgdata = [self saveSmallJpg:imgdata];
                }
            }else{
                if (imgdata.length>ImageMaxSize) {
                    imgdata = [self saveSmallJpg:imgdata];
                }
            }
        }else{
            imgdata =UIImagePNGRepresentation(img);
        }
    }else{
        imgdata =[self saveJpg:img with:0.95];
        
        if (imgdata.length>ImageMaxSize) {
            imgdata = [self saveSmallJpg:imgdata];
        }
        
    }
    return imgdata;

    
    
}
#pragma mark------私有方法
#pragma mark 压缩品质
+ (NSData*)saveSmallJpg:(NSData*)imgdata{
    NSInteger time=0;
    do {
        UIImage *IM =[UIImage imageWithData:imgdata];
        if (time>=4) {
            imgdata = [self saveJpg:IM with:0.8];
            return imgdata;
        }else if (time>=2&&time<4) {
            imgdata = [self saveJpg:IM with:0.9];
        }else{
            imgdata = [self saveJpg:IM with:0.99];
        }
        time++;
    } while (imgdata.length>=ImageMaxSize);
    return imgdata;
}
+ (NSData*)saveJpg:(UIImage*)img with:(NSInteger)size{
    return UIImageJPEGRepresentation(img, size);
}
#pragma mark 压缩size
+ (CGSize)newSizeWithWidth:(long)w height:(long)h{
    do {
        w=0.95*w;
        h=0.95*h;
    } while (w>=ImageMaxWidth&&h>ImageMaxHeight);
    return CGSizeMake(w,h);
}



@end
