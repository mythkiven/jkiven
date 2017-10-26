//
//  YJStatisticsLabel.h
//  CreditPlatform
//
//  Created by yj on 2016/10/26.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HideBlock)();
typedef void(^ShowBlock)();
@interface YJStatisticsLabel : UILabel


@property (nonatomic, strong) UIView *contentView;
- (void)setStatisticsType:(NSString *)type Count:(NSString *)count amt:(NSString *)amt ;
- (void)show;

- (void)hide;

- (void)show:(ShowBlock)showBlcok;
- (void)hide:(HideBlock)hideBlock;



@end
