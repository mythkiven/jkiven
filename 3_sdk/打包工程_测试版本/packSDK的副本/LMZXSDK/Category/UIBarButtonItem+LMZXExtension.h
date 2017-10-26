//
//  UIBarButtonItem+Extension.h
//  inZhua
//
//  Created by yj on 16/5/26.
//  Copyright © 2016年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LMZXExtension)

+ (instancetype)barButtonItemWithIcon:(NSString *)icon title:(NSString *)title target:(id)target action:(SEL)action ;
+ (instancetype)backBarButtonItemtarget:(id)target action:(SEL)action;
@end
