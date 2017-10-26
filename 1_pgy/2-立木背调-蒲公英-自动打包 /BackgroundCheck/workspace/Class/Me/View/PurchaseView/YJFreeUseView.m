//
//  YJFreeUseView.m
//  CreditPlatform
//
//  Created by yj on 16/9/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJFreeUseView.h"

@interface YJFreeUseView ()
@property (weak, nonatomic) IBOutlet UILabel *remainingDaysLB;

@property (weak, nonatomic) IBOutlet UILabel *limitDateLB;

@end

@implementation YJFreeUseView

+ (instancetype)freeUseView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"YJFreeUseView" owner:nil options:nil] firstObject];
}

- (void)setRemainingDays:(NSString *)remainingDays {
    _remainingDays = remainingDays;
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:remainingDays];
    
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:22],
                            NSForegroundColorAttributeName : RGB_redText} range:NSMakeRange(0, remainingDays.length-1)];
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
                            NSForegroundColorAttributeName : RGB_redText} range:NSMakeRange(remainingDays.length-1, 1)];
    self.remainingDaysLB.attributedText = attStr;
}

- (void)setLimitDate:(NSString *)limitDate {
    _limitDate = limitDate;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:limitDate];
    NSRange yearRan = [limitDate rangeOfString:@"年"];
    NSRange monthRan = [limitDate rangeOfString:@"月"];
    NSRange dayRan = [limitDate rangeOfString:@"日"];

    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]
                            } range:NSMakeRange(0, limitDate.length)];
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]
                            } range:yearRan];
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]} range:monthRan];
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]} range:dayRan];
    self.limitDateLB.attributedText = attStr;
    
}


@end
