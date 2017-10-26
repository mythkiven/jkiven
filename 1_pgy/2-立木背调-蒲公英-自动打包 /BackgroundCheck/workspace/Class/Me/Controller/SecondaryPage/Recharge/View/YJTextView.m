//
//  YJTextView.m
//  CreditPlatform
//
//  Created by yj on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTextView.h"

@interface YJTextView () <UITextViewDelegate>
@property (nonatomic, weak) UILabel *placehoderLabel;

@end

@implementation YJTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
 
        
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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 添加一个显示提醒文字的label（显示占位文字的label）
        UILabel *placehoderLabel = [[UILabel alloc] init];
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.font = Font15;
        placehoderLabel.textColor = RGB_grayNormalText;
        placehoderLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:placehoderLabel];
        self.placehoderLabel = placehoderLabel;
        
        self.placehoderColor = RGB(199, 199, 205);
        
        self.font = Font15;
//        self.alwaysBounceVertical = YES;
        
        // 监听内部文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听文字改变
- (void)textDidChange
{
    self.placehoderLabel.hidden = self.hasText;
}

#pragma mark - 公共方法
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

- (void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = [placehoder copy];
    
    // 设置文字
    self.placehoderLabel.text = placehoder;
    
    // 重新计算子控件的fame
    [self setNeedsLayout];
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor = placehoderColor;
    
    // 设置颜色
    self.placehoderLabel.textColor = placehoderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placehoderLabel.font = font;
    
    // 重新计算子控件的fame
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placehoderLabel.y = 8;
    self.placehoderLabel.x = 4;
    self.placehoderLabel.width = self.width - 2 * self.placehoderLabel.x;
    // 根据文字计算label的高度
    CGSize maxSize = CGSizeMake(self.placehoderLabel.width, MAXFLOAT);
    CGSize placehoderSize = [self.placehoder sizeWithFont:self.placehoderLabel.font constrainedToSize:maxSize];
    
//    CGSize placehoderSize1 = [self.placehoder boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : self.placehoderLabel.font} context:nil].size;
    self.placehoderLabel.height = placehoderSize.height;
}


@end
