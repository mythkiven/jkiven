//
//  LMCollectionReusableView.h
//  LMZX_SDKDemo_OC
//
//  Created by yj on 2017/3/29.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMCollectionReusableView : UICollectionReusableView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *lineColor;

+ (instancetype)collectionReusableView;


@end
