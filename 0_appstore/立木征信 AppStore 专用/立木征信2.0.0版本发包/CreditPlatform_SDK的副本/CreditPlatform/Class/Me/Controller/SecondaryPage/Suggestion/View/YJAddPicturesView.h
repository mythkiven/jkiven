//
//  YJTweetingPictures.h
//  1.SinaWeibo
//
//  Created by qianfeng on 15/11/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kIdeaImageWH ((SCREEN_WIDTH - kMargin_15 * 2 - kMargin_10 *3) / 4)

@class YJAddPicturesView;

@protocol YJAddPicturesViewDelegate <NSObject>

@optional
- (void)addPicturesViewDidClickAddImageView:(YJAddPicturesView *)addPicturesView;


- (void)addPicturesView:(YJAddPicturesView *)addPicturesView didClickImageView:(int)tag;

@end


typedef void(^YJAddPicturesViewBlock)(UIImageView *imageView);

typedef void(^YJDeletePicBlock)(int index);


@interface YJAddPicturesView : UIView

@property (nonatomic, weak) id<YJAddPicturesViewDelegate> delegate;

@property (nonatomic, copy) YJAddPicturesViewBlock block;

@property (nonatomic, copy) YJDeletePicBlock deletePicBlock;

- (void)addImage:(UIImage *)image;

- (NSArray *)totalImages;

@end
