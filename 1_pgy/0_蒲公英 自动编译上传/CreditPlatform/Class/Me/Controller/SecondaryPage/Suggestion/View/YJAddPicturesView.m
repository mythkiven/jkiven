//
//  YJTweetingPictures.m
//  1.SinaWeibo
//
//  Created by qianfeng on 15/11/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "YJAddPicturesView.h"
#import "YJImageView.h"
#import "SDPhotoBrowser.h"

@interface YJAddPicturesView ()<SDPhotoBrowserDelegate>
{
    UIView *_addView;
    
    YJImageView *_imageView;
    
    NSMutableArray *_imageViewArr;
    
}

@end

@implementation YJAddPicturesView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _imageViewArr = [NSMutableArray arrayWithCapacity:0];
        
        
        [self setupAddPicture];
        
        self.backgroundColor = RGB_white;
        
    }
    return self;
}
/*
 * 一行4张图片，最多显示8张
 * 间隙：左右15 中间10
 */



- (void)setupAddPicture {
    
    // 占位图
    _addView = [[UIView alloc] init];
    _addView.userInteractionEnabled = YES;
    _addView.frame = CGRectMake(kMargin_15, 0, kIdeaImageWH, kIdeaImageWH);
    [self addSubview:_addView];
    _addView.backgroundColor = RGB_pageBackground;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAddPicture)];
    [_addView addGestureRecognizer:tap];
    
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.userInteractionEnabled = NO;
    imgView.image = [UIImage imageNamed:@"me_icon_ideas_add"];
    imgView.highlightedImage = [UIImage imageNamed:@"me_icon_ideas_add"];
    imgView.contentMode = UIViewContentModeCenter;
    [_addView addSubview:imgView];
    CGFloat imgViewY = 14;
    CGFloat lbMargine = 12;
    UIFont *lbFont = Font15;
    if (iPhone5 || iPhone4s) {
        imgViewY = 7;
        lbMargine = 6;
        lbFont = Font13;
    }
    imgView.frame = CGRectMake((_addView.width-30)*.5, imgViewY, 30, 30);

    
    
    UILabel *lb = [[UILabel alloc] init];
    lb.text = @"添加图片";
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = lbFont;
    lb.textColor = RGB_grayNormalText;
    [_addView addSubview:lb];
    lb.frame = CGRectMake(0, _addView.height - lbMargine - 21, _addView.width, 21);

    
    
}


/**
 *  点击占位图
 *
 */
- (void)clickAddPicture {
    
    if ([self.delegate respondsToSelector:@selector(addPicturesViewDidClickAddImageView:)]) {
        [self.delegate addPicturesViewDidClickAddImageView:self];
    }
    

    
}


/**
 *  添加图片
 *
 *  @param image 
 */
- (void)addImage:(UIImage *)image {
    
    _imageView = [[YJImageView alloc] init];
    _imageView.image = image;
    _imageView.userInteractionEnabled = YES;
    [self addSubview:_imageView];
    
    
    [self addDeleteButton];
    
    _imageView.tag = _imageViewArr.count;
    
    [_imageViewArr addObject:_imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPicture:)];
    [_imageView addGestureRecognizer:tap];
    
}


- (void)addDeleteButton {
    UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [deleteBtn setImage:[UIImage imageNamed:@"me_icon_delete"] forState:(UIControlStateNormal)];
    [deleteBtn setImage:[UIImage imageNamed:@"me_icon_delete"] forState:(UIControlStateHighlighted)];
    
    [_imageView addSubview:deleteBtn];
    
    [deleteBtn addTarget:self action:@selector(clickDeleBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}

- (void)clickDeleBtn:(UIButton *)button {
    
    [_imageViewArr removeObjectAtIndex:button.tag];
    
    
    
    UIImageView *imageView = (UIImageView *)button.superview;
    
    [imageView removeFromSuperview];
    
    if (self.deletePicBlock) {
        self.deletePicBlock((int)button.tag);
    }
    
    
    
}



- (void)clickPicture:(UITapGestureRecognizer *)tap {
    YJImageView *imageView = (YJImageView *)tap.view;
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    int i = 0;
    for (; i < _imageViewArr.count; i ++) {
        YJImageView *imgView = _imageViewArr[i];
        if (imageView == imgView) {
            break;
        }
    }
    
    browser.currentImageIndex = i;
    
    
    browser.sourceImagesContainerView = self;
    browser.imageCount = _imageViewArr.count;
    browser.sourceImageViews = _imageViewArr;
    browser.delegate = self;
    [browser show];
    
    
    
//    imageView.isClicked = YES;
//    
//    
//    if ([self.delegate respondsToSelector:@selector(addPicturesView:didClickImageView:)]) {
//        [self.delegate addPicturesView:self didClickImageView:(int)tap.view.tag];
//    }
    
}

#pragma mark - SDPhotoBrowserDelegate



- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = _imageViewArr[index];
    return imageView.image;
}

/**
 *  获取添加的图片
 *
 *  @return
 */
- (NSArray *)totalImages {

    NSMutableArray *images = [NSMutableArray arrayWithCapacity:0];
    
    for (UIImageView *imageView in _imageViewArr) {
        [images addObject:imageView.image];
    }
    
    return images;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    int count = (int)_imageViewArr.count;
    
    int maxColumns = 4;
    
    
    
    CGFloat imgW = kIdeaImageWH;
    CGFloat imgH = imgW;
    CGFloat margin = kMargin_10;
    
    for (int i = 0; i < count; i ++) {
        // 图片的位置
        UIImageView *imageView = _imageViewArr[i];
        
        CGFloat imgX = kMargin_15 + i % maxColumns * (margin + imgW);
        CGFloat imgY = i / maxColumns * (margin + imgH);
        imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        
        // 删除按钮的位置
        UIButton *btn = imageView.subviews[0];
        btn.tag = i;
        CGFloat btnWH = 23;
        if (iPhone5 || iPhone4s) {
            btnWH = 20;
        }
        CGFloat btnX = imgW - btnWH -2;
        CGFloat btnY = 2;
        btn.frame = CGRectMake(btnX, btnY, btnWH, btnWH);
        
    }
    
    // 占位图
    _addView.frame = CGRectMake(kMargin_15 + count % maxColumns * (margin + imgW), count / maxColumns * (margin + imgH), imgW, imgH);
    if (count == 8) {
        _addView.hidden = YES;
    } else {
        _addView.hidden = NO;
    }
    
    if (count >= 4) {
        self.height = kIdeaImageWH * 2 + 10 + 15;
    } else {
        self.height = kIdeaImageWH + 15;
    }
    
    
}



@end
