//
//  UIImageView+LMZXExtend.m
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/3/17.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "UIImageView+LMZXExtend.h"

@implementation UIImageView (LMZXExtend)

-(void)setImageWithURL:(NSString *)imageDownloadUrl{
    
    __block UIImage *image = [[UIImage alloc] init];
    NSURL *imageDownloadURL = [NSURL URLWithString:imageDownloadUrl];
    
    //创建异步线程执行队列 图片下载
    dispatch_queue_t asynchronousQueue = dispatch_queue_create("imageDownloadQueue", NULL);
    
    dispatch_async(asynchronousQueue, ^{
        
        NSError *error;
        NSData *imageData = [NSData dataWithContentsOfURL:imageDownloadURL options:NSDataReadingMappedIfSafe error:&error];
        if (imageData) {
            image = [UIImage imageWithData:imageData];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setContentMode:UIViewContentModeScaleAspectFit];
            [self setImage:image];
        });
    });
}
@end
