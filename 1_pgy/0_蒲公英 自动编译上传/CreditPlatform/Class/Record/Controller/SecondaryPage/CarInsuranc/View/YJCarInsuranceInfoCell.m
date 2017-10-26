//
//  YJTaoBaoOrderDetailsCell.m
//  CreditPlatform
//
//  Created by yj on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCarInsuranceInfoCell.h"
#import "YJCarInsuranceModel.h"
@interface YJCarInsuranceInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *insuranceNameLB;

/**
 赔偿金额
 */
@property (weak, nonatomic) IBOutlet UILabel *IndemnityLB;
/**
 保险费
 */
@property (weak, nonatomic) IBOutlet UILabel *insuranceExpensesLB;

@end

@implementation YJCarInsuranceInfoCell
// 125

+ (instancetype)carInsuranceInfoCellWithTableView:(UITableView *)tableView {
    
    YJCarInsuranceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carInsuranceInfoCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJCarInsuranceInfoCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
    
}

- (void)setInsurance:(YJCarInsuranceInsurance *)insurance {
    _insurance = insurance;
    
    if (![insurance.insuranceName isEqualToString:@""]) {
        self.insuranceNameLB.text = insurance.insuranceName;
    }
    
    if (![insurance.coverBal isEqualToString:@""]) {
        self.IndemnityLB.text = insurance.coverBal;
    }
    
    if (![insurance.payAmt isEqualToString:@""]) {
        self.insuranceExpensesLB.text = insurance.payAmt;
    }
    
    
    
}

//- (void)setOrderDetails:(YJTaoBaoOrderDetails *)orderDetails {
//    _orderDetails = orderDetails;
//    
//    if (![orderDetails.orderId isEqualToString:@""]) {
//        self.orderIdLB.text = [NSString stringWithFormat:@"订单号 %@",orderDetails.orderId];
//    } else {
//        self.orderIdLB.text = @"--";
//        
//    }
//    
//    if (![orderDetails.orderAmt isEqualToString:@""]) {
//        self.orderAmtLB.text = orderDetails.orderAmt;
//    } else {
//        self.orderAmtLB.text = @"--";
//        
//    }
//    
//    if (![orderDetails.orderTime isEqualToString:@""]) {
//        self.orderTimeLB.text = orderDetails.orderTime;
//    } else {
//        self.orderTimeLB.text = @"--";
//        
//    }
//    
//    if (![orderDetails.orderStatus isEqualToString:@""]) {
//        self.orderStatusLB.text = orderDetails.orderStatus;
//    } else {
//        self.orderStatusLB.text = @"--";
//        
//    }
//    
//
//    
//    if (![orderDetails.taoBaoLogisticsInfo.receivePersonName isEqualToString:@""] && orderDetails.taoBaoLogisticsInfo.receivePersonName) {
//        self.receivePersonNameLB.text = orderDetails.taoBaoLogisticsInfo.receivePersonName;
//        } else {
//    self.receivePersonNameLB.text = @"--";
//    
//}
//    if (![orderDetails.taoBaoLogisticsInfo.receivePersonMobile isEqualToString:@""] && orderDetails.taoBaoLogisticsInfo.receivePersonMobile) {
//        self.receivePersonMobileLB.text = orderDetails.taoBaoLogisticsInfo.receivePersonMobile;
//    } else {
//        self.receivePersonMobileLB.text = @"--";
//        
//    }
//    
//    if (![orderDetails.taoBaoLogisticsInfo.receiveAddress isEqualToString:@""] && orderDetails.taoBaoLogisticsInfo.receiveAddress) {
//
//        CGFloat height = [self heightOfLabel:self.receiveAddressLB content:orderDetails.taoBaoLogisticsInfo.receiveAddress maxWidth:SCREEN_WIDTH-120];
//        
//        self.addressContstraintH.constant = height;
//        
//    } else {
//        self.receiveAddressLB.text = @"--";
//        self.addressContstraintH.constant = 20;
//
//    }
//    
//}
- (void)setFrame:(CGRect)frame {
    //    frame.origin.x = kMargin;
    //    frame.size.width -= kMargin * 2;
    //
    //    frame.origin.y += 10;
    frame.size.height -= 10;
    
    [super setFrame:frame];
    
    
}

@end
