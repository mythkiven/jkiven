//
//  UILabel+Extension.m
//  CreditPlatform
//
//  Created by yj on 2016/11/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)


/**
 左侧标题
 */
+ (UILabel *)grayTitleLBWithTitle:(NSString *)title {
    UILabel *lb = [UILabel new];
    lb.numberOfLines = 0;
    lb.textAlignment = NSTextAlignmentRight;
    lb.font = Font15;
    lb.text = title;
    lb.textColor = RGB_grayNormalText;
    return lb;
}

/**
 右侧内容
 */
+ (UILabel *)contentLB {
    UILabel *lb = [UILabel new];
    lb.font = Font15;
    lb.textAlignment = NSTextAlignmentLeft;
    lb.textColor = RGB_black;
    lb.numberOfLines = 0;
    lb.text = @"--";
    //    lb.backgroundColor = RGB_red;
    return lb;
}

/**
 UILabel 换行加间隙
 
 @param maxWidth 最大宽度
 
 @return 自适应高度
 */
- (CGFloat)heightOfLabelMaxWidth:(CGFloat)maxWidth{
    
    NSString *content  = self.text;
    
    if (!content) {
        return 0;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    
    self.attributedText = attributedString;
    CGSize size = CGSizeMake(maxWidth, 500000);
    CGSize labelSize = [self sizeThatFits:size];
    CGRect frame = self.frame;
    frame.size = labelSize;
    
    //    MYLog(@"-------高度%f",frame.size.height);
    
    return frame.size.height;
    
}

- (CGFloat)heightOfLabelMaxWidth:(CGFloat)maxWidth content:(NSString *)content{
    
    //    NSString *content  = self.text;
    
    if (!content) {
        return 0;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    
    self.attributedText = attributedString;
    CGSize size = CGSizeMake(maxWidth, 500000);
    CGSize labelSize = [self sizeThatFits:size];
    CGRect frame = self.frame;
    frame.size = labelSize;
    
    //    MYLog(@"-------高度%f",frame.size.height);
    
    return frame.size.height;
    
}







- (void)jSetAttributedStringRange:(NSRange)range Color:(UIColor*)color Font:(UIFont*)font {
    
    
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:self.text];
    [att addAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font} range:range];
    
    self.attributedText = att;
    
}







@end
