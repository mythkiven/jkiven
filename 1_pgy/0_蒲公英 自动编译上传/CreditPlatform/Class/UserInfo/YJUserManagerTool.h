//
//  YJUserManagerTool.h
//  CreditPlatform
//
//  Created by yj on 16/8/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJUserModel;
@interface YJUserManagerTool : NSObject
+ (void)saveUser:(YJUserModel *)user;

+ (YJUserModel *)user;

+ (BOOL)clearUserInfo;

@end
