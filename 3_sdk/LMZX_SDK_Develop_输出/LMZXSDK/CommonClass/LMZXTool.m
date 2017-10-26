//
//  Tool.m
//
//  Created by 蒋孝才 on 15/7/6.
//  Copyright (c) 2015年 蒋孝才. All rights reserved.
//

#import "LMZXTool.h"
#import "CommonCrypto/CommonDigest.h"

#define lmzxJUserDefaults  [NSUserDefaults standardUserDefaults]
#define lmzxSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@implementation LMZXTool




+ (instancetype)shareTool
{
    static LMZXTool *tool = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tool = [[self alloc] init];
    });
    
    return tool;
}


#pragma mark 1、NSuserDefault存值
+ (void)setObject:(id)object forKey:(NSString *)key{
    [lmzxJUserDefaults setObject:object forKey:key];
    [lmzxJUserDefaults synchronize];
}
+ (void)setBool:(BOOL)b forKey:(NSString *)key{
    [lmzxJUserDefaults setBool:b forKey:key];
    [lmzxJUserDefaults synchronize];
}
+ (void)removeObjectForKey:(NSString *)key{
    if ([lmzxJUserDefaults objectForKey:key]) {
        [lmzxJUserDefaults removeObjectForKey:key];
        [lmzxJUserDefaults synchronize];
    }
    
}
#pragma mark 2、NSuserDefault取值
+ (id)objectForKey:(NSString *)key{
    return [lmzxJUserDefaults objectForKey:key];
}
+ (BOOL)boolForKey:(NSString *)key{
    return [lmzxJUserDefaults boolForKey:key];
}

#pragma mark 3、计算缓存
//+ (NSString*)calculateCatcheSize{
//    NSString *cacheSizeStr =nil;
//    //缓存大小：B
//    NSUInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
//    if (cacheSize <1024) {
//        cacheSizeStr = [NSString stringWithFormat:@"%.2f B",(float)cacheSize];
//    }
//    else if (cacheSize >=1024&&cacheSize <1024*1024) {
//        cacheSizeStr = [NSString stringWithFormat:@"%.2f KB",(float)cacheSize/1024];
//    }else if (cacheSize >=1024*1024&&cacheSize <1024*1024*1024) {
//        cacheSizeStr = [NSString stringWithFormat:@"%.2f MB",(float)cacheSize/(1024*1024)];
//    }else if (cacheSize >=1024*1024*1024&&cacheSize <1024*1024*1024*1024.0) {
//        cacheSizeStr = [NSString stringWithFormat:@"%.2f GB",(float)cacheSize/(1024*1024*1024)];
//    }
//    
//    return cacheSizeStr;
//}

#pragma mark 4、计算文本的高度
+ (CGFloat)calculateTextHeight:(NSString*)text size:(CGSize)size font:(UIFont*)font{
    /**文本矩形框的计算方法
     1、文本框的范围
     2、绘制选项
     3、文本属性
     4、上下文
     */
  CGRect rect =  [ text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :font} context:nil];

    return rect.size.height;
}

#pragma mark 5、获取设备的id
+ (NSString *)deviceIdentifier {
    NSString *vendorId = @"";
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
    if (lmzxSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
    {
        vendorId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
#endif
    return vendorId;
}




/*
 * 判断输入的号码是否是电话号码
 */
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,183
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else {
        return NO;
    }
}

/*
 * 身份证号
 */
- (BOOL)validateIdentityCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

/*
 * 邮箱
 */
- (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//是否是纯数字
- (BOOL)isNumText:(NSString *)str
{
    NSString * regex = @"(/^[0-9]*$/)";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (isMatch)
    {
        return YES;
    }else{
        return NO;
    }
    
}



//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^1[0-9]{10}";
//    NSString *phoneRegex = @"^1+[3578]+\\d{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}




/**
 校验密码 6-16位字幕、数字、下划线必须组合使用
 */
+ (BOOL) validateUserPassword:(NSString *)pw
{
    NSString *userNameRegex = @"^(((?=.*[a-zA-Z])(?=.*[0-9]))|((?=.*[a-zA-Z])(?=.*[_]))|((?=.*[_])(?=.*[0-9])))[a-zA-Z_0-9]{6,16}$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL ret = [userNamePredicate evaluateWithObject:pw];
    
    return ret;
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9_]{3,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码 字母数字下滑线 6-16
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9_]{6,16}+$";
    //    NSString *passWordRegex = @"^(?![^a-zA-Z]+$)(?!\\D+$).{6,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    //    NSString * regex        = @"(/^[0-9]*$/)";
    //    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //
    //    //6~20位英文或数字
    BOOL one = [passWordPredicate evaluateWithObject:passWord];
    //    //纯数字
    //    BOOL two = [pred evaluateWithObject:passWord];
    
    //判断是不是纯数字
    BOOL two = NO;
    
    [NSCharacterSet decimalDigitCharacterSet];
    
    if ([[passWord stringByTrimmingCharactersInSet: [NSCharacterSet decimalDigitCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length >0) {
        two = NO;
    }else{
        two = YES;
    }
    
    return one && !two;
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//数字或字母
+ (BOOL)validateLetterOrNumber: (NSString *)string{
    //    NSString *regex = @"^[A-Za-z]+[0-9]+[A-Za-z0-9]*|[0-9]+[A-Za-z]+[A-Za-z0-9]*$";
    //
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    NSCharacterSet *disallowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefABCDEF"] invertedSet];
    NSString *filtered = [[string  componentsSeparatedByCharactersInSet:disallowedCharacters] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    
    return basicTest;
}

+ (UILabel *)setLabel:(UILabel *)label withFrom:(int)a to:(int)b andfont:(NSInteger)font withColor:(UIColor *)color{
    
     NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithAttributedString:label.attributedText];
    [att addAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:[UIFont systemFontOfSize:(int)font]} range:NSMakeRange(a, b)];
    
    label.attributedText = att;
    
    
    
    return label;
    
}
+ (NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}



@end
