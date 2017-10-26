//
//  DeviceInfo.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "JDeviceInfo.h"
#import "JKeychainHelper.h"
#define kIsStringValid(text) (text && text!=NULL && text.length>0)
// 固定不变，不能修改的：
#define UUID_STRING @"com.limuzhengxin.getUUID.url.ylno.IDFA"

@implementation JDeviceInfo




#pragma mark  - 获取UUID
+ (NSString*)getUUID {
    CFUUIDRef uuid_ref = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuid_string_ref= CFUUIDCreateString(kCFAllocatorDefault, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    if (!kIsStringValid(uuid)) {
        uuid = @"";
    }
    CFRelease(uuid_string_ref); 
    return [[uuid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];;
}

#pragma mark  删除唯一标识符
+ (void)deleteUUIDForKeychain{
    [JKeychainHelper delete:UUID_STRING];
}

#pragma mark  获取唯一标识符
+ (NSString*)getUUIDFromKeychain{
    //0.读取keychain的缓存
    NSString *deviceID = [JDeviceInfo getIdfaString];
    if (kIsStringValid(deviceID)){
        return deviceID;
    }else{
        //2.如果取不到,就生成UUID,当成IDFA
        deviceID = [JDeviceInfo getUUID];
        [JDeviceInfo setIdfaString:deviceID];
        if (kIsStringValid(deviceID)){
            return deviceID;
        }
      
    }
    return nil;
}

#pragma mark  Keychain管理
+ (NSString*)getIdfaString {
    NSString *idfaStr = [JKeychainHelper load:UUID_STRING];
    if (kIsStringValid(idfaStr)){
        return idfaStr;
    } else {
        return nil;
    }
}
+ (BOOL)setIdfaString:(NSString *)secValue {
    if (kIsStringValid(secValue)){
        [JKeychainHelper save:UUID_STRING data:secValue];
        return YES;
    }else {
        return NO;
    }
}
#pragma mark -

@end
