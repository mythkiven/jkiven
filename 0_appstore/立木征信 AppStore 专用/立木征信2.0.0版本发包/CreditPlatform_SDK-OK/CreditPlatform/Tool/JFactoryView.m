//
//  FactoryView.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "JFactoryView.h"

@implementation JFactoryView

+(UIButton*)creatButtonWithX:(CGRect)X WithY:(CGRect)Y WithSEL:(SEL)action   And:(id)SELF{
    UIButton *btnSearch =[UIButton buttonWithType:UIButtonTypeCustom];
    btnSearch.frame = CGRectMake(CGRectGetMinX(X), CGRectGetMaxY(Y)+20, kScreenW-30,45);
    [btnSearch setTitle:@"查询" forState:UIControlStateNormal];
    btnSearch.titleLabel.font = Font18;
    btnSearch.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [btnSearch setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
    [btnSearch setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    
    
    [btnSearch setTitleColor:RGB_white forState:UIControlStateNormal];
    [btnSearch setTitleColor:RGB_white forState:UIControlStateHighlighted];
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
    leng = 110;
    btnDetailf.frame = CGRectMake(SCREEN_WIDTH -leng, CGRectGetMinY(Y), leng, CGRectGetHeight(H));
    [btnDetailf setTitle:@"如何获取?" forState:UIControlStateNormal];
    
    btnDetailf.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter ;
    btnDetailf.titleLabel.font = JFont(13);
    
    [btnDetailf setTitleColor:RGB_blueText forState:UIControlStateSelected];
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

+(UIButton *)btnWithTitle:(NSString*)title frame:(CGRect)rect WithSEL:(SEL)action And:(id)SELF{
    UIButton *btnDetail =[UIButton buttonWithType:UIButtonTypeSystem];
    btnDetail.frame = CGRectMake(CGRectGetMaxX(rect)+1, CGRectGetMinY(rect), kScreenW-CGRectGetMaxX(rect), CGRectGetHeight(rect));
    [btnDetail setTitle:title forState:UIControlStateNormal];
    btnDetail.titleLabel.font = JFont(14);
    btnDetail.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    [btnDetail setTitleColor:RGB_blueText forState:UIControlStateSelected];
    [btnDetail addTarget:SELF action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btnDetail;
}

+(UILabel *)labelWithMaxX:(CGRect)X withY:(CGRect)Y{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(X)+7, CGRectGetMinY(Y), 30, 22)];
    label1.text = @"同意";
    label1.font = JFont(14);
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = 1;
    label1.adjustsFontSizeToFitWidth =YES;
    return label1;
}

+(UITableView *)tableviewWithDelegate:(id)SELF WithFooterView:(UIView*)view{
    
    UITableView * tableView_ = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStylePlain];
    tableView_.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView_.backgroundColor = RGB_pageBackground;
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

+(UILabel*)JLineWith:(CGRect)frame Super:(id)Super{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = RGB_grayLine;
    if (Super) [Super addSubview:label];
    return label;
}
+(UILabel*)JLineWith:(CGRect)frame Super:(id)Super tag:(NSInteger)tag{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = RGB_grayLine;
    label.tag =tag;
    if (Super) [Super addSubview:label];
    return label;
}

+(UIView*)JLineWithSuper:(id)Super{
    UIView *label = [[UIView alloc]init];
    label.backgroundColor = RGB_grayLine;
    if (Super) {
        [Super addSubview:label];
    }
    
    return label;
}
+(JFactoryView*)JGrayViewWithFrame:(CGRect)frame{
    JFactoryView *cover = [[JFactoryView alloc]init];
    cover.frame = frame;
    cover.backgroundColor =RGB_pageBackground;
    return cover;
}
+(UITextField*)JTextFieldWithSuper:(id)Super Color:(UIColor*)color Font:(CGFloat)Font Alignment:(NSInteger)ali PlaceHold:(NSString*)text{
    UITextField *tf = [[UITextField alloc]init];
    tf.textColor = color;
    tf.placeholder = text;
    tf.font = JFont(Font);
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
    btn.titleLabel.font = JFont(Font);
    [btn setBackgroundColor:colorb];
    [btn setTitleColor:colort forState:UIControlStateNormal];
    
    return btn;
}
+(UIButton *)JBtnWithBgColor:(UIColor*)colorb Font:(CGFloat)Font Alignment:(NSInteger)ali textColor:(UIColor*)colort title:(NSString*)title image:(NSString*)img backImg:(NSString*)backImg{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = ali;
    btn.titleLabel.font = JFont(Font);
    [btn setBackgroundColor:colorb];
    [btn setTitleColor:colort forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:backImg] forState:UIControlStateNormal];
    return btn;
}

+(UIView *)JCoverViewWithBgColor:(UIColor*)color alpha:(CGFloat)alpha{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = color;
    view.alpha = alpha;
    return view;

}


@end
