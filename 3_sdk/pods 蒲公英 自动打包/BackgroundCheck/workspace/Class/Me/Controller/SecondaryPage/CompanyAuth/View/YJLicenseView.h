//
//  YJLicenseView.h
//  CreditPlatform
//
//  Created by yj on 16/7/19.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJLicenseView;
@protocol YJLicenseViewDelegate <NSObject>

@optional

// 选取营业执照
- (void)licenseViewChooseLicensePic:(YJLicenseView *)licenseView;

// 提交
- (void)commitLicenseInfoBtnClick:(YJLicenseView *)licenseView;

@end


@interface YJLicenseView : UIView

@property (nonatomic, strong) UIImage *licenseImage;

@property (nonatomic, weak) id<YJLicenseViewDelegate> delegate;


+ (instancetype)licenseView;
@end
