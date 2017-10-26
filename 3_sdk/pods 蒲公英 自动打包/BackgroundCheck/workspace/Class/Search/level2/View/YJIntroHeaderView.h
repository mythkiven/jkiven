//
//  YJIntroHeaderView.h
//  BackgroundCheck
//
//  Created by yj on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJHomeItemModel;

@interface YJIntroHeaderView : UIView

@property (nonatomic, strong) YJHomeItemModel *introModel;
+ (instancetype)introHeaderView;
@end
