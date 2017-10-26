//
//  YJRadarScanView.h
//  testCycle
//
//  Created by yj on 16/8/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyStarView : UIImageView

@property (nonatomic, assign) BOOL isAnimating;

@end


@interface YJRadarScanView : UIView

/**
 *  启动雷达动画
 */
- (void)startRadarScan;
/**
 *  停止雷达动画
 */
- (void)stopRadarScan;

@end
