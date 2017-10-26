//
//  ReportCreditEmailBillDetailBillHeader.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/26.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ReportCreditEmailBillDetailBillHeader.h"
@interface ReportCreditEmailBillDetailBillHeader ()



@property (weak, nonatomic) IBOutlet UILabel *payTime;
@property (weak, nonatomic) IBOutlet UILabel *benqiPay;
@property (weak, nonatomic) IBOutlet UILabel *benqiCost;
@property (weak, nonatomic) IBOutlet UILabel *sqpay;
@property (weak, nonatomic) IBOutlet UILabel *sqApay;
@property (weak, nonatomic) IBOutlet UILabel *littlePay;


@end

@implementation ReportCreditEmailBillDetailBillHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)reportCreditEmailBillDetailBillCellHeader{
    return [[[NSBundle mainBundle] loadNibNamed:@"ReportCreditEmailBillDetailBillHeader" owner:nil options:nil] firstObject];
}


// 设置header
-(void)setModel:(reportCreditBillChangeInfo *)model{
    _model= model;
    _payTime.text = FillSpace( model.paymentDueDate) ;//到期还款日
    _benqiPay.text = [model.curPaymentBal decodeCoinSign:model.currency];//本期应还 curPaymentBal  "19563.00";OK
    _benqiCost.text = [zeroSpace(model.curDebitsBal) decodeCoinSign:model.currency];//本期消费 curDebitsBal = "19580.00";NO
    _sqpay.text = [zeroSpace(model.preStatementBal) decodeCoinSign:model.currency];//上期应还preStatementBal = "32355.25";OK
    _sqApay.text = [zeroSpace(model.prePaymentBal) decodeCoinSign:model.currency];// 上期还款prePaymentBal = "32355.25";NO
    _littlePay.text = [zeroSpace(model.minPaymentBal) decodeCoinSign:model.currency];//本期最低应还 minPaymentBal = "1956.30";
}




@end
