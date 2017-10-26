//
//  YJURLSessionManager.h
//  CreditPlatform
//
//  Created by yj on 16/8/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface YJURLSessionManager : AFURLSessionManager

+ (instancetype)shareURLSessionManager;
@end
