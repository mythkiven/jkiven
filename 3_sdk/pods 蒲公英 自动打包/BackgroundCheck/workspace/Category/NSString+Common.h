
#import <Foundation/Foundation.h>

@interface NSString (Common)


/**身份证*/
-(BOOL)isIdentityCard;

/**
 *  计算字符串宽度(指当该字符串放在view时的自适应宽度)
 *
 *  @param size 填入预留的大小
 *  @param font 字体大小
 *  @param isBold 字体是否加粗
 *
 *  @return 返回CGRect
 */
- (CGRect)stringWidthRectWithSize:(CGSize)size fontOfSize:(CGFloat)font isBold:(BOOL)isBold;



+(NSString *)MD5:(NSString *)str;
+(NSString *)Base64encode:(NSString *)encodeStr;
+(NSString *)Base64decode:(NSString *)decodeStr;
+(BOOL) isEmpty:(NSString *) str;
+(BOOL)isValidateEmail:(NSString *)msg;
+(BOOL)isMobileNumber:(NSString *)mobileNum;
+(CGFloat)calculateTextHeight:(CGFloat)widthInput Content:(NSString *)strContent  font:(UIFont *)font;
+(CGFloat)calculateTextWidth:(CGFloat)widthInput Content:(NSString *)strContent  font:(UIFont *)font;
+(CGSize)calculateTextSize:(CGSize)size Content:(NSString *)strContent  font:(UIFont *)font;
//+(BOOL)isStandardPassword:(NSString *)str andView:(UIView *)view;
//+(BOOL)isStandardFargatherName:(NSString *)str andView:(UIView *)view;
+(NSString *)stringRemoveEmoji:(NSString *)stringRemoveEmoji;
// 根据错误码返回错误原因
+ ( NSString *)returnNetworkErrorString:(NSInteger )num;
// 返回是否为北京上海深圳。
+ (BOOL)isBSGS:(NSString*)str;
// 返回是否以秒结尾
+(BOOL)stringEndWith:(NSString*)str;
// 返回是头两个字符。
+(NSString*)TwoCharString:(NSString*)str;
// 返回是头两个字符。
-(NSString*)TwoCharString;




//是否有str这个子串
-(BOOL)hasStr:(NSString*)str;
// 字符串 数组，，，返回和
+(CGFloat)floatNSString:(NSArray*)str;

// 比较大小：str1>str2.返回YES。否则返回NO
// 可以比较float、int等。以及1.1.1>1.1.0两种格式
+(BOOL)compareStr:(NSString*)str1 BigThanStr2:(NSString*)str2;

//返回日期 2016年1月1日 转2016-1-1
+(NSDate *)DateWithString:(NSString*)dateString;
//+(NSString *)string:(NSString*)str ReplaceString:(NSString*)str WithString:(NSString*)str;
// 比较日期大小
+(BOOL )compareDay:(NSDate *)oneDay BigThanDay:(NSDate *)anotherDay;
//2016-2-12 11：00：00返回2016-2-12
+(NSString*)newDateWith:(NSDate*)date;



//日期处理：

/** 2016-12 2016/12
    2016年12月
 */
-(NSString*)DateString_Year_Month_Day;
/**
 2016-12-12 2016/12/12 20161212
 转成指定格式：
 */
-(NSString*)DateString;



// 银行卡号格式处理

/**
 取后四位数字，返回格式： **** **** **** 1234
 */
-(NSString*)CardWithFormatLastFourNum;



// 根据code 返回文字

//银行code 返回银行名称
+(NSString *)decodeCredit:(NSString*)str;
//币种code 返回币名
-(NSString *)decodeCoin;
//币种 str code 123 返回$123 or ￥123
-(NSString *)decodeCoinSign:(NSString*)str;

- (CGSize)stringSizeWithFont:(UIFont *)font Size:(CGSize)size;


// 通用处理

/** 去除多余的空格 多个空格则留一个空格，一个空格就不去掉 或者 \u00a0 */
-(NSString *)cutSpace;
/** 去除所有的的空格*/
-(NSString *)cutAllSpace;

/** 将string 用另外一个str进行替换 */
-(NSString*)StringReplaceRangeFrom:(NSInteger)i To:(NSInteger)j WithString:(NSString*)str;
/** 空 返回-- */
+(NSString*)spaceString:(id)str;
/** 空 返回0 */
-(NSString*)zeroString;

/** 去除空格，换行处理：<br>替换为\n */
+(NSString *)newString:(NSString*)str;

/** 0.89变成89% */
-(NSString *)percentDdeciString;


+ (CGFloat)heightOfLabel:(UILabel *)contentLabel content:(NSString *)content maxWidth:(CGFloat)maxWidth;



@end
