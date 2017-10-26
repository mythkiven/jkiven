//
//  YJStatisticsLabel.m
//  CreditPlatform
//
//  Created by yj on 2016/10/26.
//  Copyright © 2016年 . All rights reserved.
//

#import "YJStatisticsLabel.h"

@interface YJStatisticsLabel ()
{
    UIView *_line;
}

@end

@implementation YJStatisticsLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [[UIView alloc]init];
        _line = line;
        line.backgroundColor = RGB_grayLine;
        [self addSubview:line];
        
        self.font = Font18;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}



/**
 充值成功 笔，共 元
 消费 笔，共 元
 @param type  充值成功/(标准、套餐)消费
 @param count 总笔数
 @param amt   总金额
 */
- (void)setStatisticsType:(NSString *)type Count:(NSString *)count amt:(NSString *)amt {
    
    NSString *amtStr = [NSString stringWithFormat:@"%.2f",[amt floatValue]];
    NSString *title = [NSString stringWithFormat:@"%@%@笔，共%@元",type,count,amtStr];
    
//    NSInteger length = title.length;

    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:title];
    NSRange countRange = [title rangeOfString:count];
    NSRange amtRange = [title rangeOfString:amtStr];
    
    NSDictionary *attributtedDict = @{NSForegroundColorAttributeName:RGB_redText,NSFontAttributeName:[UIFont systemFontOfSize:18]};
    
    [att addAttributes:attributtedDict range:countRange];
    
    [att addAttributes:attributtedDict range:amtRange];

    self.attributedText = att;
}

#pragma mark 显示
- (void)show
{
    [self.contentView addSubview:self];
    self.transform = CGAffineTransformMakeTranslation(0, 50);
    self.alpha = 0;
    
    [UIView animateWithDuration:.2 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

- (void)hide
{
   
    [UIView animateWithDuration:.2 animations:^{
        // 1.scrollView从下面 -> 上面
        self.transform = CGAffineTransformMakeTranslation(0, 50);
        
        self.alpha = 0;

    } completion:^(BOOL finished) {
        // 从父控件中移除
        [self removeFromSuperview];

    }];
}

- (void)show:(ShowBlock)showBlcok {
    [self show];
    
    if (showBlcok) {
        showBlcok();
    }
}
- (void)hide:(HideBlock)hideBlock {
    [self hide];
    if (hideBlock) {
        hideBlock();
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    
}

@end
