//
//  SettingTopView.h
//  CreditPlatform
//
//  Created by gyjrong on 16/8/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChangeImgBlock)(UIButton *btn);

@interface SettingTopView : UIView

@property (nonatomic, copy) ChangeImgBlock changeImgBlock;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *status;

+ (instancetype)loginHeaderView;
@end
