//
//  YJCitySelectCell.m
//  CreditPlatform
//
//  Created by yj on 2016/11/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXCityListCell.h"
#import "LMZXCityModel.h"
#import "LMZXSDK.h"
@interface LMZXCityListCell ()

@property (strong, nonatomic)  UIButton *selectedBtn;

@end
@implementation LMZXCityListCell

- (UILabel *)textLB {
    if (!_textLB) {
        _textLB = [[UILabel alloc] init] ;
        _textLB.font = [UIFont systemFontOfSize:15];
        _textLB.textColor = [UIColor blackColor];
    }
    
    return _textLB;
}

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    }
    return _topLine;
}

- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn = [[UIButton alloc] init];
    }
    return _selectedBtn;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.textLB];
        [self.contentView addSubview:self.topLine];
    }
    return self;
}


- (void)setCityModel:(LMZXCityModel *)cityModel {
    _cityModel = cityModel;
    self.textLB.text = cityModel.areaName;
    if (cityModel.isSelected) {
        self.selectedBtn.selected = YES;
        self.textLB.textColor = [self matchingStringColor];
    } else {
        self.selectedBtn.selected = NO;
        self.textLB.textColor = [UIColor blackColor];
        
    }
    
}

- (UIColor *)matchingStringColor {
    if ([LMZXSDK shared].lmzxProtocolTextColor) {
        return [LMZXSDK shared].lmzxProtocolTextColor;
    }
    return [UIColor colorWithRed:48/255.0 green:113/255.0 blue:242/255.0 alpha:1];
}


- (void)setTitle:(NSString *)title {
    _title = [title copy];
    
    self.textLB.text = title;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.topLine.frame = CGRectMake(0, 0, self.bounds.size.width, 0.5);
    self.textLB.frame = CGRectMake(15, 0, self.bounds.size.width - 30, self.bounds.size.height);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (void)setCityModel:(YJCityModel *)cityModel {
//    _cityModel = cityModel;
//    
//    self.dateLB.text = cityModel.;
//    
//    if (reportDishonestyModel.isSelected) {
//        self.selectedBtn.selected = YES;
//        self.dateLB.textColor = RGB_navBar;
//    } else {
//        self.selectedBtn.selected = NO;
//        self.dateLB.textColor = RGB_black;
//        
//    }
//    
//}


@end
