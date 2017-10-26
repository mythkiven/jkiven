//
//  YJIPhotoView.m
//  CreditPlatform
//
//  Created by yj on 16/8/12.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJIPhotoView.h"

#define kFrame CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

@interface YJIPhotoView ()<UIScrollViewDelegate>
{
    UIImageView *_imageView;
    UIScrollView *_scrollView;
    CGFloat _totalScale;
    UIImageView *_beginAnimationView;
    
}

@end


@implementation YJIPhotoView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupView];
    }
    return self;
}



- (void)setPic:(UIImage *)pic {
    _pic = pic;
    _imageView.image = pic;
    
}

- (void)showImage:(UIImage *)image from:(UIView *)fromeView {
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    self.pic = image;
    CGRect fromRect = [fromeView.superview convertRect:fromeView.frame toView:window];
//    MYLog(@"=============%@",NSStringFromCGRect(fromRect));
    
    _beginAnimationView = [[UIImageView alloc] initWithFrame:fromRect];
    _beginAnimationView.image = image;
    _beginAnimationView.clipsToBounds = YES;
    _beginAnimationView.userInteractionEnabled = YES;
    _beginAnimationView.contentMode = UIViewContentModeScaleAspectFit;
    _beginAnimationView.backgroundColor = [UIColor clearColor];
    [self addSubview:_beginAnimationView];
    
    [UIView animateWithDuration:0.25 animations:^{
        _beginAnimationView.layer.frame = kFrame;
    } completion:^(BOOL finished) {
        if (finished) {
//            [self setupView];
        }
    }];
    
    
}

- (void)setupView {
//     UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
//    UIView *bgView = [[UIView alloc] initWithFrame:kFrame];
//    bgView.backgroundColor = [UIColor blackColor];
//    [window addSubview:bgView];
    
    self.backgroundColor = [UIColor blackColor];
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.alpha = 1;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = false;
    _scrollView.showsVerticalScrollIndicator = false;
    _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    _scrollView.frame = kFrame;
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.maximumZoomScale = 3.0;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self addSubview:_scrollView];

    
    _imageView = [[UIImageView alloc] init];
    _imageView.userInteractionEnabled = YES;
    _imageView.image = self.pic;
    _imageView.frame = kFrame;
//    _imageView.backgroundColor = [UIColor yellowColor];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_imageView];
    
    // 单击
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.delaysTouchesBegan = YES;
    [_imageView addGestureRecognizer:singleTap];
    
    // 双击击
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.delaysTouchesBegan = YES;
    [_imageView addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
//    // 拖动
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
//    panGesture.maximumNumberOfTouches = 1;
//    panGesture.minimumNumberOfTouches = 1;
//    [_imageView addGestureRecognizer:panGesture];
    
    
    
//    [UIView animateWithDuration:0.25 animations:^{
//        _scrollView.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        _beginAnimationView.hidden = YES;
//    }];


}




/**
 *  处理单击
 *
 */
- (void)handleSingleTap:(UITapGestureRecognizer *)singleTap {
    
    
    if ([self.delegate respondsToSelector:@selector(photoViewhandleSingleTap:)]) {
        [self.delegate photoViewhandleSingleTap:self];
    }
//    [self removeFromSuperview];
    
}

/**
 *  处理双击
 *
 */
- (void)handleDoubleTap:(UITapGestureRecognizer *)doubleTap {
    CGPoint touchPoint = [doubleTap locationInView:_scrollView];
    if (_scrollView.zoomScale == _scrollView.maximumZoomScale){
        [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:YES];
        
    }else{
        [_scrollView zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    }
}

#pragma mark----UIScrollViewDelegate
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    CGFloat ws = scrollView.frame.size.width - scrollView.contentInset.left - scrollView.contentInset.right;
    CGFloat hs = scrollView.frame.size.height - scrollView.contentInset.top - scrollView.contentInset.bottom;
    CGFloat w = _imageView.frame.size.width;
    CGFloat h = _imageView.frame.size.height;
    CGRect rct = _imageView.frame;
    rct.origin.x = (ws > w) ? (ws-w)/2 : 0;
    rct.origin.y = (hs > h) ? (hs-h)/2 : 0;
    _imageView.frame = rct;
    
}

- ( UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)layoutSubviews {
//    _imageView.frame = kFrame;


}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:kFrame];
}

@end
