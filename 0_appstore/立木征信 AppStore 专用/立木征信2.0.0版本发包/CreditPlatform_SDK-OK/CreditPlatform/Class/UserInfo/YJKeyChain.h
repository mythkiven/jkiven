//
//  YJKeyChain.h
//  keychain
//
//  Created by yj on 16/3/2.
//  Copyright © 2016年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data ;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service ;


@end
