//
//  FactoryView.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXFactoryView.h"
#import "UIImage+LMZXTint.h"

#import "LMZXDemoAPI.h"

//#define LM_RGB(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]


@implementation LMZXFactoryView

+(UIButton*)creatButtonWithX:(CGRect)X WithY:(CGRect)Y WithSEL:(SEL)action   And:(id)SELF{
    UIButton *btnSearch =[UIButton buttonWithType:UIButtonTypeCustom];
    btnSearch.frame = CGRectMake(CGRectGetMinX(X), CGRectGetMaxY(Y)+20, LM_SCREEN_WIDTH-30,45);
    [btnSearch setTitle:@"提交" forState:UIControlStateNormal];
    btnSearch.titleLabel.font = LM_Font(18);
    btnSearch.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [btnSearch setBackgroundImage:[UIImage resizedImageWithColor:LM_RGB(57, 179, 27)] forState:(UIControlStateNormal)];
    [btnSearch setBackgroundImage:[UIImage resizedImageWithColor:LM_RGB(30, 150, 0)] forState:(UIControlStateHighlighted)];
    
    
    [btnSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btnSearch addTarget:SELF action:action forControlEvents:UIControlEventTouchUpInside];
    btnSearch.layer.cornerRadius = 2;
    btnSearch.layer.masksToBounds = YES;
    
    return btnSearch;
}

+(UIButton *)btnWithHeight:(CGRect)H WithMinY:(CGRect)Y WithSEL:(SEL)action  And:(id)SELF{
    UIButton *btnDetailf =[UIButton buttonWithType:UIButtonTypeSystem];
    btnDetailf.tag =99;
    [btnDetailf.titleLabel setTextAlignment:2];
    float leng;
    leng = LM_SCREEN_WIDTH;
    btnDetailf.frame = CGRectMake(0, CGRectGetHeight(Y)-36-CGRectGetHeight(H)-15, leng, CGRectGetHeight(H));
    [btnDetailf setTitle:@"如何获取身份验证码?" forState:UIControlStateNormal];
    
    btnDetailf.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter ;
    btnDetailf.titleLabel.font = LM_Font(15);
    if ([LMZXSDK shared].lmzxProtocolTextColor) {
        [btnDetailf setTitleColor:[LMZXSDK shared].lmzxProtocolTextColor forState:UIControlStateSelected];
        [btnDetailf setTitleColor:[LMZXSDK shared].lmzxProtocolTextColor forState:UIControlStateNormal];
    }else{
        [btnDetailf setTitleColor:LM_RGB(48, 113, 242) forState:UIControlStateSelected];
    }
    
    [btnDetailf addTarget:SELF action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btnDetailf;
}

+(UIButton *)btnWithSEL:(SEL)action  And:(id)SELF{
    
    UIButton * _selectedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _selectedBtn.frame = CGRectMake(15, 10, 22, 22);
    _selectedBtn.showsTouchWhenHighlighted =NO;
    _selectedBtn.adjustsImageWhenHighlighted =NO;
    [_selectedBtn setImage:[UIImage imageNamed:@"checkbox_selected.png"] forState:UIControlStateSelected];
    [_selectedBtn setImage:[UIImage imageNamed:@"checkbox_normal.png"] forState:UIControlStateNormal];
    [_selectedBtn addTarget:SELF action:action forControlEvents:UIControlEventTouchUpInside];
    _selectedBtn.selected = YES;
    return _selectedBtn;
    
    
}

+(UIButton *)btnWithTitleColor:(UIColor *)color title:(NSString*)title frame:(CGRect)rect WithSEL:(SEL)action And:(id)SELF{
    UIButton *btnDetail =[UIButton buttonWithType:UIButtonTypeSystem];
    btnDetail.frame = CGRectMake(CGRectGetMaxX(rect)+1, CGRectGetMinY(rect), LM_SCREEN_WIDTH-CGRectGetMaxX(rect), CGRectGetHeight(rect));
    [btnDetail setTitle:title forState:UIControlStateNormal];
    btnDetail.titleLabel.font = LM_Font(14);
    btnDetail.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    [btnDetail setTitleColor:color forState:UIControlStateSelected];
    btnDetail.tintColor = color;
    [btnDetail addTarget:SELF action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btnDetail;
}

+(UILabel *)labelWithMaxX:(CGRect)X withY:(CGRect)Y{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(X)+7, CGRectGetMinY(Y), 30, 22)];
    label1.text = @"同意";
    label1.font = LM_Font(14);
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = 1;
    label1.adjustsFontSizeToFitWidth =YES;
    return label1;
}
+(UILabel *)labelTY{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 22)];
    label1.text = @"我已阅读并同意";
    label1.font = LM_Font(14);
    label1.textColor = LM_RGB(153, 153, 153);
    label1.textAlignment = 1;
    label1.adjustsFontSizeToFitWidth =YES;
    return label1;
}


+(UITableView *)tableviewWithDelegate:(id)SELF WithFooterView:(UIView*)view{
    
    UITableView * tableView_ = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH, LM_SCREEN_HEIGHT-20) style:UITableViewStylePlain];
    tableView_.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView_.backgroundColor = LM_RGB(245, 245, 245);
    tableView_.dataSource =SELF;
    tableView_.delegate = SELF;
    tableView_.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    tableView_.tableFooterView = view;
    
    return tableView_;
    
}


+(UILabel*)JlabelWith:(CGRect)frame Super:(id)Super Color:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali Text:(NSString*)text{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:Font];
    label.textAlignment = ali;
    label.textColor = color;
    label.text = text;
    if (Super) [Super addSubview:label];
    return label;
}
+(UILabel*)JlabelWith:(CGRect)frame Super:(id)Super Color:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali Text:(NSString*)text tag:(NSInteger)tag{
    UILabel *labe = [self JlabelWith:frame Super:Super Color:color Font:Font Alignment:ali Text:text];
    labe.tag = tag;
    return labe;
}

+(UILabel*)JlabelWithSuper:(id)Super Color:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali Text:(NSString*)text{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:Font];
    label.textAlignment = ali;
    label.textColor = color;
    label.text = text;
    if (Super) [Super addSubview:label];
    return label;
}

+(UILabel*)labelWithFrame:(CGRect)frame  super:(id)Super Color:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali Text:(NSString*)text{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:Font];
    label.textAlignment = ali;
    label.textColor = color;
    label.text = text;
    if (Super) [Super addSubview:label];
    return label;
}

+(UILabel*)JLineWith:(CGRect)frame Super:(id)Super{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = LM_RGBGrayLine;
    if (Super) [Super addSubview:label];
    return label;
}
+(UILabel*)JLineWith:(CGRect)frame Super:(id)Super tag:(NSInteger)tag{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = LM_RGBGrayLine;
    label.tag =tag;
    if (Super) [Super addSubview:label];
    return label;
}

+(UIView*)JLineWithSuper:(id)Super{
    UIView *label = [[UIView alloc]init];
    label.backgroundColor = LM_RGBGrayLine;
    if (Super) {
        [Super addSubview:label];
    }
    
    return label;
}
+(LMZXFactoryView*)JGrayViewWithFrame:(CGRect)frame{
    LMZXFactoryView *cover = [[LMZXFactoryView alloc]init];
    cover.frame = frame;
    cover.backgroundColor =LM_RGB(245, 245, 245);
    return cover;
}
+(UITextField*)JTextFieldWithSuper:(id)Super Color:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali PlaceHold:(NSString*)text{
    UITextField *tf = [[UITextField alloc]init];
    tf.textColor = color;
    tf.placeholder = text;
    tf.font = LM_Font(Font);
    tf.textAlignment = ali;
    if (Super) {
        [Super addSubview:tf];
    }
    
    return tf;
}
+(LMZXSMSTextFiled*)JSMSTextFieldWithSuper:(id)Super Color:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali PlaceHold:(NSString*)text{
    LMZXSMSTextFiled *tf = [[LMZXSMSTextFiled alloc]init];
    tf.textColor = color;
    tf.placeholder = text;
    tf.font = LM_Font(Font);
    tf.textAlignment = ali;
    if (Super) {
        [Super addSubview:tf];
    }
    
    return tf;
}

+(UIButton *)JBtnWithBgColor:(UIColor*)colorb Font:(CGFloat)Font Alignment:(NSInteger)ali textColor:(UIColor*)colort title:(NSString*)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = ali;
    btn.titleLabel.font = LM_Font(Font);
    [btn setBackgroundColor:colorb];
    [btn setTitleColor:colort forState:UIControlStateNormal];
    
    return btn;
}
+(UIButton *)YJ_BtnWithBgColor:(UIColor*)colorb Font:(CGFloat)Font Alignment:(NSInteger)ali textColor:(UIColor*)colort title:(NSString*)title image:(UIImage*)img backImg:(UIImage*)backImg{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = ali;
    btn.titleLabel.font = LM_Font(Font);
    [btn setBackgroundColor:colorb];
    [btn setTitleColor:colort forState:UIControlStateNormal];
    [btn setImage:img forState:UIControlStateNormal];
    [btn setBackgroundImage:backImg forState:UIControlStateNormal];
    return btn;
}

//+(UIButton *)JBtnWithBgColor:(UIColor*)colorb Font:(CGFloat)Font Alignment:(NSInteger)ali textColor:(UIColor*)colort title:(NSString*)title image:(UIImage*)img backImg:(NSString*)backImg{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:title forState:UIControlStateNormal];
//    btn.titleLabel.textAlignment = ali;
//    btn.titleLabel.font = LMFont(Font);
//    [btn setBackgroundColor:colorb];
//    [btn setTitleColor:colort forState:UIControlStateNormal];
//    [btn setImage:img forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:backImg] forState:UIControlStateNormal];
//    return btn;
//}


+(UIView *)JCoverViewWithBgColor:(UIColor*)color alpha:(CGFloat)alpha{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = color;
    view.alpha = alpha;
    return view;

}


@end
