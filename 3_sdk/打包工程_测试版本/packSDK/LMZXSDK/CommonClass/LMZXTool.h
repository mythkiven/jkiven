//
//  Tool.h
//
//  Created by 蒋孝才 on 15/7/6.
//  Copyright (c) 2015年 蒋孝才. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define lmzxisNetWorking @"isNetWorking"

@interface LMZXTool : NSObject

+ (instancetype)shareTool;
+(NSString *) md5: (NSString *) inPutText ;
+ (void)setObject:(id)object forKey:(NSString *)key;
+ (void)setBool:(BOOL)b forKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;
+ (void)removeObjectForKey:(NSString *)key;
+ (CGFloat)calculateTextHeight:(NSString*)text size:(CGSize)size font:(UIFont*)font;
+ (NSString *)deviceIdentifier;
- (BOOL)isMobileNumber:(NSString *)mobileNum;
- (BOOL)validateIdentityCard:(NSString *)identityCard;
- (BOOL)validateEmail:(NSString *)email;
- (BOOL)isNumText:(NSString *)str;
+ (BOOL) validateEmail:(NSString *)email;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;

//车型
+ (BOOL) validateCarType:(NSString *)CarType;


//用户名
+ (BOOL) validateUserName:(NSString *)name;

/**
 校验密码 6-16位字幕、数字、下划线必须组合使用
 */
+ (BOOL) validateUserPassword:(NSString *)pw;

//密码
+ (BOOL) validatePassword:(NSString *)passWord;

//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

//数字或字母
+ (BOOL)validateLetterOrNumber: (NSString *)string;

+(UILabel *)setLabel:(UILabel *)label withFrom:(int)a to:(int)b andfont:(NSInteger)font withColor:(UIColor *)color;

// 保存到钥匙串


@end
