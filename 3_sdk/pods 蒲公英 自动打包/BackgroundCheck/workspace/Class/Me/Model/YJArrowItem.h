//
//  YJArrowItem.h
//  inZhua
//
//  Created by yj on 16/5/25.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "YJBaseItem.h"

@interface YJArrowItem : YJBaseItem
@property (nonatomic, copy) Class destVC;

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle destVc:(Class)destVc;

+ (instancetype)itemWithTitle:(NSString *)title destVc:(Class)destVc;

+ (instancetype)itemWithIcon:(NSString *)icon Title:(NSString *)title subTitle:(NSString *)subTitle destVc:(Class)destVc;

+ (instancetype)itemWithIcon:(NSString *)icon Title:(NSString *)title destVc:(Class)destVc;
@end
