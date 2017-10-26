//
//  YJIPhotoView.h
//  CreditPlatform
//
//  Created by yj on 16/8/12.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJIPhotoView;
@protocol YJIPhotoViewDelegate <NSObject>

- (void)photoViewhandleSingleTap:(YJIPhotoView *)view;

@end

@interface YJIPhotoView : UIView


@property (nonatomic, weak) id<YJIPhotoViewDelegate> delegate;

@property (nonatomic, strong) UIImage *pic;

- (void)showImage:(UIImage *)image from:(UIView *)fromeView;
@end
