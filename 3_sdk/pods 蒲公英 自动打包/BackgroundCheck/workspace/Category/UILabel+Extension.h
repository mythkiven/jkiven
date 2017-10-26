//
//  UILabel+Extension.h
//  CreditPlatform
//
//  Created by yj on 2016/11/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/**
 左侧标题
 
 */
+ (UILabel *)grayTitleLBWithTitle:(NSString *)title;

/**
 右侧内容
 
 */
+ (UILabel *)contentLB ;

/**
 UILabel 换行加间隙
 
 @param maxWidth 最大宽度
 
 @return 自适应高度
 */
- (CGFloat)heightOfLabelMaxWidth:(CGFloat)maxWidth;

/**
 UILabel 换行加间隙
 
 @param maxWidth 最大宽度
 @param content  UILabel的text
 @return 自适应高度
 */
- (CGFloat)heightOfLabelMaxWidth:(CGFloat)maxWidth content:(NSString *)content;



/**
 UILabel 自定义type
 */
- (void)jSetAttributedStringRange:(NSRange)range Color:(UIColor*)color Font:(UIFont*)font;



/** * 改变行间距 */ + (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space; /** * 改变字间距 */ + (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space; /** * 改变行间距和字间距 */ + (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;










@end
