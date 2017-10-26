//
//  DeviceInfo.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDeviceInfo : NSObject

/** 获取UUID
 */
+ (NSString*)getUUID;


/** 获取唯一标识符:若无则生成一个
 */
+ (NSString*)getUUIDFromKeychain;

/** 删除唯一标识符：存进keychain
 */
+ (void)deleteUUIDForKeychain;



@end
