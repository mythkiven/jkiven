//
//  LMZXCityListBaseVC.h
//  LMZX_SDK_Develop
//
//  Created by yj on 2017/5/12.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMZXBaseViewController.h"

typedef void(^SelectedCityBlock)(id);

@interface LMZXCityListBaseVC : LMZXBaseViewController
@property(copy,nonatomic) SelectedCityBlock selectedOneCity;

// 选中的城市
@property (copy,nonatomic) NSString *cityString;

@end
