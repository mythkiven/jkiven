//
//  FactoryView.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMZXSMSTextFiled.h"
@interface LMZXFactoryView : UIView


+(UILabel *)labelTY;
//搜索BTN
+(UIButton*)creatButtonWithX:(CGRect)X WithY:(CGRect)Y WithSEL:(SEL)action   And:(id)SELF;
//如何获取？Btn
+(UIButton *)btnWithHeight:(CGRect)H WithMinY:(CGRect)Y WithSEL:(SEL)action   And:(id)SELF;
//
+(UIButton *)btnWithSEL:(SEL)action   And:(id)SELF;
//
+(UIButton *)btnWithTitleColor:(UIColor *)color title:(NSString*)title frame:(CGRect)rect WithSEL:(SEL)action And:(id)SELF;

+(UILabel *)labelWithMaxX:(CGRect)X withY:(CGRect)Y;

+(UITableView *)tableviewWithDelegate:(id)SELF WithFooterView:(UIView*)view;


+(UITextField*)JTextFieldWithSuper:(id)Super Color:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali PlaceHold:(NSString*)text;
+(UIButton *)JBtnWithBgColor:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali textColor:(UIColor*)color title:(NSString*)title;
//+(UIButton *)JBtnWithBgColor:(UIColor*)colorb Font:(CGFloat)Font Alignment:(NSInteger)ali textColor:(UIColor*)colort title:(NSString*)title image:(NSString*)img backImg:(NSString*)backImg;

+(UIView *)JCoverViewWithBgColor:(UIColor*)color alpha:(CGFloat)alpha ;

+(UILabel*)labelWithFrame:(CGRect)frame  super:(id)Super Color:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali Text:(NSString*)text;

+(UILabel*)JlabelWith:(CGRect)frame Super:(id)Super Color:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali Text:(NSString*)text;
+(UILabel*)JlabelWith:(CGRect)frame Super:(id)Super Color:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali Text:(NSString*)text tag:(NSInteger)tag;

+(UILabel*)JlabelWithSuper:(id)Super Color:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali Text:(NSString*)text;
+(UIView*)JLineWith:(CGRect)frame Super:(id)Super;
+(UILabel*)JLineWith:(CGRect)frame Super:(id)Super tag:(NSInteger)tag;
+(UIView*)JLineWithSuper:(id)Super;
+(LMZXFactoryView*)JGrayViewWithFrame:(CGRect)frame;

+(LMZXSMSTextFiled*)JSMSTextFieldWithSuper:(id)Super Color:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali PlaceHold:(NSString*)text;
+(UIButton *)YJ_BtnWithBgColor:(UIColor*)colorb Font:(CGFloat)Font Alignment:(NSInteger)ali textColor:(UIColor*)colort title:(NSString*)title image:(UIImage*)img backImg:(UIImage*)backImg;

@end
