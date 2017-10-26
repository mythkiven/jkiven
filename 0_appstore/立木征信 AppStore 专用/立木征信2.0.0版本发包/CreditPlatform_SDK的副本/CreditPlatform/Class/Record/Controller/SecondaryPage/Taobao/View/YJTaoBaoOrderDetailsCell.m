//
//  YJTaoBaoOrderDetailsCell.m
//  CreditPlatform
//
//  Created by yj on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTaoBaoOrderDetailsCell.h"

@interface YJTaoBaoOrderDetailsCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderIdLB;

@property (weak, nonatomic) IBOutlet UILabel *orderAmtLB;

@property (weak, nonatomic) IBOutlet UILabel *orderTimeLB;

@property (weak, nonatomic) IBOutlet UILabel *orderStatusLB;
@property (weak, nonatomic) IBOutlet UILabel *receivePersonNameLB;
@property (weak, nonatomic) IBOutlet UILabel *receivePersonMobileLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressContstraintH;

@end

@implementation YJTaoBaoOrderDetailsCell


+ (instancetype)taoBaoOrderDetailsCellWithTableView:(UITableView *)tableView {
    
    YJTaoBaoOrderDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taoBaoOrderDetailsCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJTaoBaoOrderDetailsCell" owner:nil options:nil] lastObject];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
    
}

- (void)setOrderDetails:(YJTaoBaoOrderDetails *)orderDetails {
    _orderDetails = orderDetails;
    
    if (![orderDetails.orderId isEqualToString:@""]) {
        self.orderIdLB.text = [NSString stringWithFormat:@"订单号 %@",orderDetails.orderId];
    } else {
        self.orderIdLB.text = @"--";
        
    }
    
    if (![orderDetails.orderAmt isEqualToString:@""]) {
        self.orderAmtLB.text = orderDetails.orderAmt;
    } else {
        self.orderAmtLB.text = @"--";
        
    }
    
    if (![orderDetails.orderTime isEqualToString:@""]) {
        self.orderTimeLB.text = orderDetails.orderTime;
    } else {
        self.orderTimeLB.text = @"--";
        
    }
    
    if (![orderDetails.orderStatus isEqualToString:@""]) {
        self.orderStatusLB.text = orderDetails.orderStatus;
    } else {
        self.orderStatusLB.text = @"--";
        
    }
    

    
    if (![orderDetails.taoBaoLogisticsInfo.receivePersonName isEqualToString:@""] && orderDetails.taoBaoLogisticsInfo.receivePersonName) {
        self.receivePersonNameLB.text = orderDetails.taoBaoLogisticsInfo.receivePersonName;
        } else {
    self.receivePersonNameLB.text = @"--";
    
}
    if (![orderDetails.taoBaoLogisticsInfo.receivePersonMobile isEqualToString:@""] && orderDetails.taoBaoLogisticsInfo.receivePersonMobile) {
        self.receivePersonMobileLB.text = orderDetails.taoBaoLogisticsInfo.receivePersonMobile;
    } else {
        self.receivePersonMobileLB.text = @"--";
        
    }
    
    if (![orderDetails.taoBaoLogisticsInfo.receiveAddress isEqualToString:@""] && orderDetails.taoBaoLogisticsInfo.receiveAddress) {

        CGFloat height = [self heightOfLabel:self.receiveAddressLB content:orderDetails.taoBaoLogisticsInfo.receiveAddress maxWidth:SCREEN_WIDTH-120];
        
        self.addressContstraintH.constant = height;
        
    } else {
        self.receiveAddressLB.text = @"--";
        self.addressContstraintH.constant = 20;

    }
    
}


@end
