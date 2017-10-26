//
//  LMZXAlphaView.h
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/3/7.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LMZXAlphaView;
@protocol LMZXAlphaViewDelegate <NSObject>

- (void)alphaView:(LMZXAlphaView *)alphaView changeAlpha:(CGFloat)alpha;

@end

@interface LMZXAlphaView : UIView

@property (nonatomic, weak) id delegate;


- (void)setAlphaTo1;


@end
