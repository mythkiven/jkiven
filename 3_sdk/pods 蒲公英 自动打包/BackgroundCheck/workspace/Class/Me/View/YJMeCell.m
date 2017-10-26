//
//  YJMoreCell.m
//  inZhua
//
//  Created by yj on 16/5/25.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "YJMeCell.h"
#import "YJBaseItem.h"
#import "YJArrowItem.h"
#import "YJTextItem.h"

//#define kAccessoryArrowBtnWidth 150*iphone56Rate
#define kAccessoryArrowBtnWidth (SCREEN_WIDTH-150)


@interface YJMeCell ()



//@property (nonatomic, strong) UILabel *accessoryBtn;


@end

@implementation YJMeCell


- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.frame = CGRectMake(0, 0, kAccessoryArrowBtnWidth, 44);
        _textField.font = [UIFont systemFontOfSize:14.0];
        
    }
    return _textField;
}

- (UIButton *)accessoryArrowBtn {
    
    if (!_accessoryArrowBtn) {
        _accessoryArrowBtn = [[YJaccessoryArrowBtn alloc] init];
        _accessoryArrowBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _accessoryArrowBtn.enabled = NO;
//        [_accessoryArrowBtn setContentHorizontalAlignment:52];

        [_accessoryArrowBtn setTitleColor:RGB_black forState:(UIControlStateDisabled)];
        _accessoryArrowBtn.frame = CGRectMake(0, 0, kAccessoryArrowBtnWidth, 45);
        
        
        
    }
    return _accessoryArrowBtn;
}



+ (instancetype)meCell:(UITableView *)tableView {
    
    static NSString *ID = @"podfilecell";
    
    YJMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//
    if (!cell) {
        cell = [[YJMeCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:ID];
    }
//    YJMeCell *cell = [[YJMeCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:ID];

    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = Font17;
        self.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
        self.detailTextLabel.textColor = [UIColor blackColor];
        self.accessoryView = self.accessoryArrowBtn;
        
        
    }
    return self;
}


- (void)setItem:(YJBaseItem *)item {
    _item = item;
    if ([item isKindOfClass:[YJArrowItem class]]) {
        self.accessoryArrowBtn.accessoryArrowType = YJaccessoryArrowBtnTypeArrow;
        
        
    } else if ([item isKindOfClass:[YJTextItem class]]) {
        self.accessoryView = self.textField;
        if ([item.title isEqualToString:@"注册号"]) {
           self.textField.placeholder = @"请输入统一社会信用代码";
        } else {
           self.textField.placeholder = [NSString stringWithFormat:@"请输入%@",item.title];
        }
        
        
        
    } else {
        self.accessoryArrowBtn.accessoryArrowType = YJaccessoryArrowBtnTypeNone;
    }
    
    // 图标
    if (item.icon) {
        
        self.imageView.image = [UIImage imageNamed:item.icon];;
    }
    // 标题
    if (item.title) {
        self.textLabel.text = item.title;
        CGFloat titleWidth = [NSString calculateTextWidth:MAXFLOAT Content:_item.title font:[UIFont systemFontOfSize:17.0]];
        
//        MYLog(@"-------%@",NSStringFromCGRect(self.accessoryView.frame));
        if (item.title.length > 6) {
            self.accessoryView.frame = CGRectMake(titleWidth+30, 0, 100, 44);
        } else {
            self.accessoryView.frame = CGRectMake(0, 0, kAccessoryArrowBtnWidth, 44);
        }
        
        
    }
    
    
    // 子标题
    if (item.subTitle) {
        [self.accessoryArrowBtn setTitle:item.subTitle forState:(UIControlStateDisabled)] ;
    } else {
        
    }
    
    // 子标题
//    if (item.subTitle) {
//        self.detailTextLabel.text = item.subTitle;
//    }
    
    
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIView *separateLine = [[UIView alloc] init];
    separateLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    separateLine.backgroundColor = RGB_grayLine;
    
    [self.contentView addSubview:separateLine];
    
    

    
}



@end
