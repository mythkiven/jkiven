//
//  YJTopMenuPullCell.m
//  CreditPlatform
//
//  Created by yj on 2017/6/30.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import "YJTopMenuPullCell.h"
#import "YJMenuModel.h"
@interface YJTopMenuPullCell()
{
    UILabel *_lb;
}

@end

@implementation YJTopMenuPullCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lb = [[UILabel alloc] init];
        _lb = lb;
        lb.backgroundColor = [UIColor clearColor];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont systemFontOfSize:13];
        self.contentView.layer.borderWidth = 0.5;
        [self.contentView addSubview:lb];
    }
    return self;
}

- (void)setMenuModel:(YJMenuModel *)menuModel {
    _menuModel = menuModel;
    _lb.text = menuModel.title;
    _lb.frame = self.contentView.bounds;
    UIColor *bgColor ;
    UIColor *borderColor;
    UIColor *textColor;
    if (menuModel.isSelected) {
        bgColor = RGB_navBar;
        borderColor = bgColor;
        textColor = RGB_white;
    } else {
        bgColor = RGB_white;
        borderColor = RGB(199, 199, 199);
        textColor = RGB(51, 51, 51);
    }
    _lb.textColor = textColor ;
    self.contentView.backgroundColor = bgColor;
    self.contentView.layer.borderColor = borderColor.CGColor;

    
}
@end
