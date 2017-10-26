//
//  YJRedPacketHeaderView.m
//  CreditPlatform
//
//  Created by yj on 16/9/18.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJRedPacketHeaderView.h"
#import "NSDate+MJ.h"
@interface YJRedPacketHeaderView ()

/**
 *  红包余额
 */
@property (weak, nonatomic) IBOutlet UILabel *redPacketAmountLB;
/**
 *  截止日期 有效期至2016年10年8月
 */
@property (weak, nonatomic) IBOutlet UILabel *redEndDateLB;
/**
 *  提示信息  到期后红包余额自动清零
 */
@property (weak, nonatomic) IBOutlet UILabel *tipLB;

@end
@implementation YJRedPacketHeaderView

+ (id)redPacketHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YJRedPacketHeaderView" owner:nil options:nil] firstObject];
}


-(void)setRechargeAllAmt:(NSString *)rechargeAllAmt rechargeRedEndDate:(NSString *)rechargeRedEndDate {
    self.rechargeAllAmt = rechargeAllAmt ;
    self.rechargeRedEndDate = rechargeRedEndDate;
//self.rechargeRedEndDate = @"------";
    if (rechargeRedEndDate.length < 4) {
        return;
    }
    
     NSDate *now = [[NSDate alloc] initWithTimeInterval:8*60*60 sinceDate:[NSDate date]];
    
    NSDate *endDate = [self getBeiJingTime:rechargeRedEndDate];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitSecond;
    NSDateComponents *comp =  [calendar components:unit fromDate:now toDate:endDate options:0];
    
    BOOL isEnd = NO;
    if (comp.second<0) {
        isEnd = YES;
    }
    
    MYLog(@"-------:%ld",comp.second);
    
    if ([_rechargeAllAmt floatValue] == 0 && !isEnd) {
        self.tipLB.text = @"您的红包已用完";
    } else if ([_rechargeAllAmt floatValue] == 0 && isEnd) {
        self.tipLB.text = @"已过有效期，红包余额自动清零";
    } else {
        self.tipLB.text = @"到期后红包余额自动清零";
        
    }
    
    
}


- (NSDate *)getBeiJingTime:(NSString *)dateStr {
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:GTMzone];
    return  [dateFormatter dateFromString:dateStr];
    
}


// 红包金额
-(void)setRechargeAllAmt:(NSString *)rechargeAllAmt {
    _rechargeAllAmt = [rechargeAllAmt copy];
    
    NSString *amount = [NSString stringWithFormat:@"%.2f元",_rechargeAllAmt.floatValue];

    self.redPacketAmountLB.attributedText = [self redPacketAmount:amount];
    

    
    
    
}

// 1.过有效期 清零    2.未过有效期  使用完0

// 有效期日期
- (void)setRechargeRedEndDate:(NSString *)rechargeRedEndDate {
    _rechargeRedEndDate = [rechargeRedEndDate copy];
    
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [formatter dateFromString:rechargeRedEndDate];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    
    _rechargeRedEndDate = [formatter stringFromDate:date];
    
    
    self.redEndDateLB.attributedText = [self getRedPacketEndDate:_rechargeRedEndDate];

    
}

- (NSMutableAttributedString *)getRedPacketEndDate:(NSString *)dateStr{
    NSString *redPacketNumStr = [NSString stringWithFormat:@"有效期至  %@",dateStr];
    NSRange range = [redPacketNumStr rangeOfString:@"有效期至"];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:redPacketNumStr];
    
    [attStr addAttributes:@{
                            NSForegroundColorAttributeName : RGB_grayNormalText} range:range];
    return attStr;
}

- (NSMutableAttributedString *)redPacketAmount:(NSString *)amount {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:amount];
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} range:NSMakeRange(amount.length-1, 1)];
    return attStr;
}

@end
