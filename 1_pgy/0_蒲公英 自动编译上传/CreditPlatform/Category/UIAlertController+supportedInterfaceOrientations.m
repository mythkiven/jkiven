//
//  UIAlertController+supportedInterfaceOrientations.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/1.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "UIAlertController+supportedInterfaceOrientations.h"

@implementation UIAlertController (supportedInterfaceOrientations)
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
#endif

@end
