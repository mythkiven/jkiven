//
//  YJUserManagerTool.m
//  CreditPlatform
//
//  Created by yj on 16/8/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJUserManagerTool.h"
#import "YJKeyChain.h"
#import "RSAEncryptor.h"

#import "YJCompanyDetailManager.h"

static NSString * const KEY_IN_KEYCHAIN = @"com.99baozi.app.allinfo";
static NSString * const KEY_PASSWORD = @"com.99baozi.app.password";


#define kUserInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.plist"]

@implementation YJUserManagerTool
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
+ (void)saveUser:(YJUserModel *)user {
    user.userPwd =[self encryptPassWord:user.userPwd];
    [NSKeyedArchiver archiveRootObject:user toFile:kUserInfoPath];
    
}

+ (YJUserModel *)user {
    if ([[NSFileManager defaultManager] fileExistsAtPath:kUserInfoPath]) {
        YJUserModel *user = [NSKeyedUnarchiver unarchiveObjectWithFile:kUserInfoPath];
        user.userPwd = [self decryptPassWord:user.userPwd];
        return user;
    }
    return nil;
}
+ (BOOL)clearUserInfo {
//    [self deletePassWord];
    
    BOOL ret = [[NSFileManager defaultManager] removeItemAtPath:kUserInfoPath error:nil];
    
    // 退出登录，清空信息（发送通知）
    [[NSNotificationCenter defaultCenter] postNotificationName:YJNotificationUserLogout object:nil];
    
    // 清空企业信息
    if ([YJCompanyDetailManager companyInfo]) {
        [YJCompanyDetailManager clearCompanyInfo];
    }
    
    return ret;
}

#pragma mark---本地存储加密：RSA
/**
 *  密码加密
 *
 */
+(NSString *)encryptPassWord:(NSString *)password
{
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];

    return [RSAEncryptor encryptString:password publicKeyWithContentsOfFile:public_key_path];
    
    
}
/**
 *  密码解密
 *
 */
+(NSString *)decryptPassWord:(NSString *)password
{
    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];

    return [RSAEncryptor decryptString:password privateKeyWithContentsOfFile:private_key_path password:@"sanying"];
   
}



#pragma mark---密码存在keychain
+(void)savePassWord1:(NSString *)password
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [YJKeyChain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}
+(id)readPassWord1
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[YJKeyChain load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+(void)deletePassWord1
{
    [YJKeyChain delete:KEY_IN_KEYCHAIN];
}

@end
