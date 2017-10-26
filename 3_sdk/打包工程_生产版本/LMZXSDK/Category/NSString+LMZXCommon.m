

#import "NSString+LMZXCommon.h"
#import "CommonCrypto/CommonDigest.h"
#import "LMZXDemoAPI.h"
#import "LMZXTool.h"
// 成功 URL
#define LMZX_LocationSuccess_TypeURL @"LM_ZXLocationSuccSesstion_TypeURL"
// 登录 URL
#define LMZX_LocationLogin_TypeURL @"LM_ZXLocationLogiSesstion_TypeURL"

@implementation NSString (LMZXCommon)



#pragma mark - 根据code 返回银行
+(NSString *)decodeCredit:(NSString*)str{
    if ([str isEqualToString:@"ALL"]) {
        return @"所有银行";
    } else if ([str isEqualToString:@"ICBC"]) {
        return @"工商银行";
    } else if ([str isEqualToString:@"CCB"]) {
        return @"建设银行";
    }else if ([str isEqualToString:@"BOC"]) {
        return @"中国银行";
    }else if ([str isEqualToString:@"ABC"]) {
        return @"农业银行";
    }else if ([str isEqualToString:@"BCM"]) {
        return @"交通银行";
    }else if ([str isEqualToString:@"CMB"]) {
        return @"招商银行";
    }else if ([str isEqualToString:@"CIB"]) {
        return @"兴业银行";
    }else if ([str isEqualToString:@"CGB"]) {
        return @"广发银行";
    }else if ([str isEqualToString:@"SPDB"]) {
        return @"浦发银行";
    }else if ([str isEqualToString:@"PAB"]) {
        return @"平安银行";
    }else if ([str isEqualToString:@"BOSC"]) {
        return @"上海银行";
    }else if ([str isEqualToString:@"CITIC"]) {
        return @"中信银行";
    }else if ([str isEqualToString:@"HXB"]) {
        return @"华夏银行";
    }else if ([str isEqualToString:@"CMBC"]) {
        return @"民生银行";
    }else if ([str isEqualToString:@"CEB"]) {
        return @"光大银行";
    }else if ([str isEqualToString:@"CITIBANK"]) {
        return @"花旗银行";
    }else  {
        return @"银行";
    }
    
    
}




-(BOOL)isIdentityCard{
    // 判断位数
    if ([self length] != 15 && [self length] != 18)
    {
        return NO;
    }
    
    NSString *carid = self;
    long lSumQT  =0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if ([self length] == 15)
    {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince])
    {
        return NO;
    }
    // 判断年月日是否有效
    // 年份
    int strYear = [[carid substringWithRange:NSMakeRange(6,4)] intValue];
    // 月份
    int strMonth = [[carid substringWithRange:NSMakeRange(10,2)] intValue];
    // 日
    int strDay = [[carid substringWithRange:NSMakeRange(12,2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil)
    {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if( 18 != strlen(PaperId)) return -1;
    // 校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    // 验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    return YES;
}

-(BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}
/**
 *  计算字符串宽度(指当该字符串放在view时的自适应宽度)
 *
 *  @param size 填入预留的大小
 *  @param fontOfSize 字体大小
 *  @param isBold 字体是否加粗
 *
 *  @return 返回CGRect
 */
- (CGRect)stringWidthRectWithSize:(CGSize)size fontOfSize:(CGFloat)fontOfSize isBold:(BOOL)isBold{
    NSDictionary * attributes;
    if (isBold) {
        attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:fontOfSize]};
    }else{
        attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:fontOfSize]};
    }
    
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}



+(NSString *)MD5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
    
}

+(BOOL) isEmpty:(NSString *) str {
    
    if ([str isKindOfClass:[NSNull class]])
    {
        return true;
    }
    if (!str)
    {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    NSString * MOBILE =@"^1+[3578]+\\d{9}";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
        
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(BOOL)isValidateEmail:(NSString *)msg {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:msg];
}
//计算Size
+(CGSize)calculateTextSize:(CGSize)size Content:(NSString *)strContent  font:(UIFont *)font
{
    NSDictionary *tdic =[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    
    return [strContent boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
}
//计算高度
+(CGFloat)calculateTextHeight:(CGFloat)widthInput Content:(NSString *)strContent  font:(UIFont *)font
{
    CGSize constraint = CGSizeMake(widthInput, 20000.0f);
//    CGSize size = [strContent sizeWithFont:font constrainedToSize:constraint];
   CGSize size = [strContent boundingRectWithSize:constraint options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : font} context:nil].size;
    CGFloat height = ceilf(size.height);
    return height;
}

//计算 宽度
+(CGFloat)calculateTextWidth:(CGFloat)widthInput Content:(NSString *)strContent  font:(UIFont *)font
{
    
    CGFloat constrainedSize = 150.0f; //其他大小也行
    CGSize size = [strContent boundingRectWithSize:CGSizeMake(constrainedSize, 80) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil].size;
    CGFloat width = size.width;
    return width;
}



//+(BOOL)isStandardPassword:(NSString *)str andView:(UIView *)view
//{
//    if (str.length >5&&str.length<33)
//    {
//        
//        return YES;
//    }
//    else
//    {
//        [view makeToast:@"请输入6~32位字符" duration:1.0 position:@"center"];
//        return NO;
//    }
//}
//+(BOOL)isStandardFargatherName:(NSString *)str andView:(UIView *)view
//{
//    if ([NSString isEmpty:str])
//    {
//        [view makeToast:@"聚会名不能为空" duration:1.5 position:@"center"];
//        return NO;
//    }
//    else
//    {
//    if (str.length >0&&str.length<11)
//    {
//        return YES;
//    }
//    else
//    {
//        [view makeToast:@"请输入1~10位字符" duration:1.5 position:@"center"];
//        return NO;
//    }
//    }
//}
+(NSString *)stringRemoveEmoji:(NSString *)stringRemoveEmoji
{
    return @"";
}
+ (BOOL)verifyIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
          return NO;
     }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
            return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
                     + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
                     + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
                     + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
                     + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
                     + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
                     + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
                     + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
                     + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}



+ (BOOL)isBSGS:(NSString*)str{
    if (str.length) {
        str = [str substringToIndex:2];
        if ([str isEqualToString:@"北京"]|[str isEqualToString:@"上海"]|[str isEqualToString:@"深圳"]|[str isEqualToString:@"广州"]) {
            return YES;
        }
    }else{
        return NO;
    }
    return NO;
}
+(BOOL)stringEndWith:(NSString*)str{
    if (!str) {
        return NO;
    }
    str = [str substringFromIndex:(str.length-1)];
    if ([str isEqualToString:@"秒"]) {
        return YES;
    }
    return NO;
}

// 返回是头两个字符。
+(NSString*)TwoCharString:(NSString*)str{
    if (str) {
        if (str.length>=2) {
            str = [str substringToIndex:2];
        }
    }
    
    return str;
}

-(NSString*)TwoCharString{
    NSString *str = self;
    if (str) {
        if (str.length>=2) {
            str = [str substringToIndex:2];
        }
    }
    
    return str;
}
+(NSString*)spaceString:(id)str{
    if(![str isKindOfClass:[NSNull class]]){
        if ([str isKindOfClass:[NSString class]]) {
            NSString *strr =(NSString *)str;
            if (strr.length) {
                return strr;
            }else{
                return @"--";
            }
        }else{
           return @"--";
        }
    }else{
        return @"--";
    }
}

// 空 返回0
-(NSString*)zeroString{
    NSString *str = self;
    if(![str isKindOfClass:[NSNull class]]){
        if ([str isKindOfClass:[NSString class]]) {
            NSString *strr =(NSString *)str;
            if (strr.length) {
                return strr;
            }else{
                return @"0";
            }
        }else{
            return @"0";
        }
    }else{
        return @"0";
    }
}

+(CGFloat)floatNSString:(NSArray*)str{
    CGFloat ss=0;
    if (str.count) {
        for (NSString *ll in str) {
            CGFloat tt = [ll floatValue];
            ss+=tt;
        }
    }else{
        
    }
        
    
    
    return ss;
    
}
-(BOOL)hasStr:(NSString*)str{
    if (self.length>=1&&str.length>=1) {
        NSRange rang = [self rangeOfString:str];
        if (rang.length>0) {
            return YES;
        }
        return NO;
    }
    
    
    return NO;
}
+(BOOL)compareStr:(NSString*)str1 BigThanStr2:(NSString*)str2{
    NSString *News1;
    NSString *News2;
    
    NSArray *arr1 = [str1 componentsSeparatedByString:@"."];
    if (arr1.count>=3) {
        NSMutableArray *marr = [NSMutableArray arrayWithArray:arr1];
        for (NSString *s in marr) {
            if ([s isEqualToString:@"."]) {
                [marr removeObject:s];
            }
        }
        [marr insertObject:@"." atIndex:1];
        News1 = [marr componentsJoinedByString:@""];
        
    }else{
        News1 = str1;
    }
    
    
    NSArray *arr2 = [str2 componentsSeparatedByString:@"."];
    if (arr2.count>=3) {
        NSMutableArray *marr2 = [NSMutableArray arrayWithArray:arr2];
        for (NSString *s in marr2) {
            if ([s isEqualToString:@"."]) {
                [marr2 removeObject:s];
            }
        }
        [marr2 insertObject:@"." atIndex:1];
        News2 = [marr2 componentsJoinedByString:@""];
        
    }else{
        News2 = str2;
    }
//    LMLog(@"NS1-%@ N@S2-%@",News1,News2);
    if ([News1 floatValue] >[News2 floatValue]) {
//        LMLog(@"YES");
        return YES;
        
    }else{
//        LMLog(@"NO");
        return NO;
    }
    return NO;
}

#pragma mark 字符串转日期
+(NSDate *)DateWithString:(NSString*)dateString{
    NSString *new = dateString;
    if ([new hasStr:@"年"]) {
        NSArray *arr1 = [dateString componentsSeparatedByString:@"年"];
        new = [arr1 componentsJoinedByString:@"-"];
    }
    if ([new hasStr:@"月"]) {
        NSArray *arr1 = [new componentsSeparatedByString:@"月"];
        new = [arr1 componentsJoinedByString:@"-"];
    }
    if ([new hasStr:@"日"]) {
        NSArray *arr1 = [new componentsSeparatedByString:@"日"];
        new = arr1[0];
    }
    
    NSString *timeStr = new;
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [formatter2 dateFromString:timeStr];
    
    return date1;
}
#pragma mark 比较日期大小 第一个 >= 第二个YES。否则 NO
+(BOOL )compareDay:(NSDate *)oneDay BigThanDay:(NSDate *)anotherDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {//第一个大
        return YES ;
    }
    else if (result == NSOrderedAscending){//第二个大
        return NO ;
    }
    else //相等
        return YES;
    
}
//2016-2-12 11：00：00返回2016年2月12日
+(NSString*)newDateWith:(NSDate*)date{
    if (date) {
        NSString *str= [NSString stringWithFormat:@"%@",date];
        NSArray *arr = [str componentsSeparatedByString:@" "];
        str = arr[0];
        
        return str;
    }
    return @"";
    
    
}


#pragma mark - 日期处理
//返回 ***年**月
-(NSString*)DateString_Year_Month_Day{
    NSString *new;
    if ([self hasStr:@"-"]) {
        NSArray *arr = [self componentsSeparatedByString:@"-"];
        if (arr.count==2) {
            new = [arr componentsJoinedByString:@"年"];
            [new stringByAppendingString:@"月"];
        }
        return new;
    }
    if ([self hasStr:@"/"]) {
        NSArray *arr = [self componentsSeparatedByString:@"/"];
        if (arr.count==2) {
            new = [arr componentsJoinedByString:@"年"];
            [new stringByAppendingString:@"月"];
        }
        return new;
    }
    
    return self;
}

#pragma mark - 银行卡号 处理
// 返回**** **** **** 1234
-(NSString*)CardWithFormatLastFourNum{
    NSString*str;
    if(self.length>=4){
        str = [self substringFromIndex:self.length-4];
        str = [@"**** **** **** " stringByAppendingString:str];
        return str;
    }
        
    return self;
}


#pragma mark -
-(NSString*)StringReplaceRangeFrom:(NSInteger)i To:(NSInteger)j WithString:(NSString*)str{
    NSString *ss = nil;
    if (self.length>=j) {
        NSString *s1 = [self substringToIndex:i];
        NSString *s2 = [self substringWithRange:NSMakeRange(j, self.length - j)];
        ss = [NSString stringWithFormat:@"%@%@%@",s1,str,s2];
    }
    
    
    return ss;
}
//处理string
+(NSString *)newString:(NSString*)str{
    // 1、换行符处理
    if ([str hasStr:@"<br></br>"]) {
        
        str = [str stringByReplacingOccurrencesOfString:@"<br></br>" withString:@"\n"];
        NSMutableArray * arr = [NSMutableArray arrayWithArray: [str componentsSeparatedByString:@"\n"]];
        if ([arr.lastObject isEqualToString:@""]) {
            [arr removeLastObject];
        }
        str = [arr componentsJoinedByString:@"\n"];
        
    }
    
    //2、然后进行去除空格处理！！
    str = [str cutSpace];
    
    return str;
}

+ (CGFloat)heightOfLabel:(UILabel *)contentLabel content:(NSString *)content maxWidth:(CGFloat)maxWidth{
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    
    contentLabel.attributedText = attributedString;
    CGSize size = CGSizeMake(maxWidth, 500000);
    CGSize labelSize = [contentLabel sizeThatFits:size];
    CGRect frame = contentLabel.frame;
    frame.size = labelSize;
//    LMLog(@"-------高度%f",frame.size.height);
    
    if (frame.size.height <= 22.0) {
        return 20;
    }
    return frame.size.height;
    
}


#pragma mark - 通用方法
#pragma mark 去除多余的空格 多个空格则留一个空格，一个空格就不去掉
-(NSString *)cutSpace{
    NSString * str = self;
    if (str.length<1) {
        return str;
    }
    if ([str hasStr:@" "]&& str.length<1000) {
        NSArray *arr = [str componentsSeparatedByString:@" "];
        NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
        if (marr.count>2) {
            for (NSString *s in marr) {
                if ([s isEqualToString:@" "]) {
                    [marr removeObject:s];
                }
            }
            str = [marr componentsJoinedByString:@" "];
        }
    }
    if ([str hasStr:@"\u00a0"] && str.length<1000) {
        NSArray *arr = [str componentsSeparatedByString:@"\u00a0"];
        NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
        NSMutableArray *newA = [NSMutableArray arrayWithCapacity:1];
        if (marr.count>2) {
            for (int i=0; i<marr.count; i++) {
                NSString *s = marr[i];
                if ([s isEqualToString:@"\u00a0"]|[s isEqualToString:@" "] | !s.length) {
                    
                }else{
                    [newA addObject:s];
                }
            }
            
            str = [newA componentsJoinedByString:@" "];
        }
    }
    
    
    return str;
}
#pragma mark 去除所有的空格
-(NSString *)cutAllSpace{
    NSString * str = self;
    if (str.length<1) {
        return str;
    }
    if ([str hasStr:@" "]&& str.length<1000) {
        NSArray *arr = [str componentsSeparatedByString:@" "];
        NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
        if (marr.count>2) {
            for (NSString *s in marr) {
                if ([s isEqualToString:@" "]) {
                    [marr removeObject:s];
                }
            }
            str = [marr componentsJoinedByString:@""];
        }
    }
    if ([str hasStr:@"\u00a0"] && str.length<1000) {
        NSArray *arr = [str componentsSeparatedByString:@"\u00a0"];
        NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
        NSMutableArray *newA = [NSMutableArray arrayWithCapacity:1];
        if (marr.count>2) {
            for (int i=0; i<marr.count; i++) {
                NSString *s = marr[i];
                if ([s isEqualToString:@"\u00a0"]|[s isEqualToString:@" "] | !s.length) {
                    
                }else{
                    [newA addObject:s];
                }
            }
            
            str = [newA componentsJoinedByString:@" "];
        }
    }
    
    return str;
}
//0.89变成89%
-(NSString *)percentDdeciString{
    NSString *str = self;
    if (str.length) {
        CGFloat ori = [str floatValue];
        CGFloat per = (CGFloat)ori*100;
        str = [[NSString stringWithFormat:@"%.2lf",per] stringByAppendingString:@"%"];
        return str;
    }
    
    return str;
}






#pragma mark BASE64
+  (NSString*) base64Encode:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    static char base64EncodingTable[64] = {
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
        'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
        'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
    };
    NSUInteger length = [data length];
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0)
            break;
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        
        for (i = ctcopy; i < 4; i++)
            [result appendString: @"="];
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    }
    return result;
}


+(BOOL)checkURL:(NSString*)url{
    NSArray *arr = [LMZXTool objectForKey:LMZX_LocationLogin_TypeURL];
    if (arr.count) {
        for (NSString *str in arr) {
            if ([str isEqualToString:url]) {
                return YES;
            }
        }
    }
    
    return NO;
}

/** 返回 186****9999 */
+(NSString *)securtMobileNumber:(NSString *)iphone{
    if (iphone.length==11) {
        NSString *pre = [iphone substringToIndex:3];
        NSString *end = [iphone substringFromIndex:11-4];
        return [NSString stringWithFormat:@"%@****%@",pre,end];
    }
    return iphone;
}

@end
