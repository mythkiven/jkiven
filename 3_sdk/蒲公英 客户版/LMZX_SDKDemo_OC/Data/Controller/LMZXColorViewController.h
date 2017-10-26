//
//  LMZXColorViewController.h
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/2/16.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedColorBlock)(UIColor *color);

@interface LMZXColorViewController : UIViewController

@property (nonatomic, strong) UIColor *testColor;
@property (nonatomic, copy) SelectedColorBlock colorBlock;

@end
