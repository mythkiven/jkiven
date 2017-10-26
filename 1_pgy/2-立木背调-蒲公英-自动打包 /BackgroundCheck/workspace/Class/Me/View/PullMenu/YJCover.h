//
//  YJCover.h
//  下拉菜单
//
//  Created by yj on 16/9/26.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJCover : UIButton
+ (id)cover;
+ (id)coverWithTarget:(id)target action:(SEL)action;

- (void)reset;
@end
