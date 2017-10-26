//
//  YJALbumItemModel.m
//  CreditPlatform
//
//  Created by yj on 16/10/11.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJPhotoItemModel.h"

@implementation YJPhotoItemModel


- (void)setAsset:(ALAsset *)asset {
    _asset = asset;
    

    
    
}

- (NSString *)base64ImageStr {
    
    UIImage *image = [UIImage imageWithCGImage:_asset.defaultRepresentation.fullScreenImage];
    CGFloat W = image.size.width;
    CGFloat H = image.size.height;

    NSURL *assetURL = _asset.defaultRepresentation.url;
    
    //图片类型：
    NSString *extension = [assetURL pathExtension];
    CFStringRef imageUTI = (UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,(__bridge CFStringRef)extension , NULL));
    NSString *imageType = nil;
    
    if (UTTypeConformsTo(imageUTI, kUTTypeJPEG))
        imageType = @"JPG";
    else if (UTTypeConformsTo(imageUTI, kUTTypePNG))
        imageType = @"PNG";
    else
        imageType = (__bridge NSString*)imageUTI;
    
    if (imageUTI) {
        CFRelease(imageUTI);
    }
    
    NSData *imageData = [UIImage compressImageWidth:W height:H type:imageType img:image];
    
    NSString *imgStr = [imageData base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
    
    return imgStr;
}

- (UIImage *)photo {
    
    return [UIImage imageWithCGImage:_asset.defaultRepresentation.fullScreenImage];
}

@end
