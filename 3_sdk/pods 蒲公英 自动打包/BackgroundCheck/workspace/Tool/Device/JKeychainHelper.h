//
//  YJKeyChain.h
//  keychain
//
//  Created by yj on 16/3/2.
//  Copyright © 2016年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKeychainHelper : NSObject

/** 保存keychain
 */
+ (void)save:(NSString *)service data:(id)data ;
/** 获取keychain
 */
+ (id)load:(NSString *)service;
/** 从keychain中删除
 */
+ (void)delete:(NSString *)service ;


@end
