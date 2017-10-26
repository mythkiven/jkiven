//
//  YJAuthTipContentView.h
//  CreditPlatform
//
//  Created by yj on 2017/6/16.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJAuthTipContentView;
@protocol YJAuthTipContentViewDelegate <NSObject>

- (void)authTipContentViewDidClose:(YJAuthTipContentView *)authTipContentView;
- (void)authTipContentViewDidAuth:(YJAuthTipContentView *)authTipContentView;

@end

@interface YJAuthTipContentView : UIView
@property (nonatomic, copy) NSString *authStatus;

@property (nonatomic, weak)id delegate;

@end
