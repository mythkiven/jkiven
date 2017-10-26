//
//  YJAddressStatisticsCell.m
//  CreditPlatform
//
//  Created by yj on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJAddressStatisticsCell.h"

@interface YJAddressStatisticsCell ()
/**
 *  姓名
 */
@property (nonatomic, weak) IBOutlet UILabel *nameLB;
/**
 *  地址
 */
@property (nonatomic, weak) IBOutlet UILabel *addressLB;

/**
 *  手机号
 */
@property (nonatomic, weak) IBOutlet UILabel *phoneNumLB;

/**
 *  消费金额
 */
@property (nonatomic, weak) IBOutlet UILabel *amtLB;

/**
 *  最近送货时间
 */
@property (nonatomic, weak) IBOutlet UILabel *deliveryTimeLB;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressContstraintH;

@end

@implementation YJAddressStatisticsCell

+ (instancetype)addressStatisticsCellWithTableView:(UITableView *)tableView {
    
    YJAddressStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressStatisticsCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJAddressStatisticsCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
    
}

- (void)setAddrStatistic:(YJTaobaoAddrStatistic *)addrStatistic {
    _addrStatistic = addrStatistic;
    
    if (![addrStatistic.receivePersonName isEqualToString:@""]) {
        self.nameLB.text = addrStatistic.receivePersonName;
    } else {
        self.nameLB.text = @"--";

    }
    
    if (![addrStatistic.receiveAddress isEqualToString:@""] && addrStatistic.receiveAddress) {
        
        CGFloat height = [self heightOfLabel:self.addressLB content:addrStatistic.receiveAddress maxWidth:SCREEN_WIDTH-140];
        
        self.addressContstraintH.constant = height;
        
    } else {
        self.addressLB.text = @"--";
        self.addressContstraintH.constant = 20;

    }
    
    if (![addrStatistic.receivePersonMobile isEqualToString:@""]) {
        self.phoneNumLB.text = addrStatistic.receivePersonMobile;
    } else {
        self.phoneNumLB.text = @"--";
        
    }
    
    if (![addrStatistic.totalAmount isEqualToString:@""]) {
        self.amtLB.text =  [NSString stringWithFormat:@"%.2f",[addrStatistic.totalAmount floatValue]];
    } else {
        self.amtLB.text = @"--";
        
    }
    
    if (![addrStatistic.receiveTime isEqualToString:@""]) {
        self.deliveryTimeLB.text = addrStatistic.receiveTime;
    } else {
        self.deliveryTimeLB.text = @"--";
        
    }
}




@end
