//
//  YJNetBankBillHeaderView.m
//  CreditPlatform
//
//  Created by yj on 2016/11/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJNetBankBillHeaderView.h"
#import "YJEBankBillModel.h"
@interface YJNetBankBillHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *realNameLB;

@property (weak, nonatomic) IBOutlet UILabel *mobilLB;
@property (weak, nonatomic) IBOutlet UILabel *idLB;

@property (weak, nonatomic) IBOutlet UILabel *cardNoLB;
@property (weak, nonatomic) IBOutlet UILabel *openDateLB;

@property (weak, nonatomic) IBOutlet UILabel *accTypeLB;
@property (weak, nonatomic) IBOutlet UILabel *currencyLB;
@property (weak, nonatomic) IBOutlet UILabel *balanceLB;
@property (weak, nonatomic) IBOutlet UILabel *availableBalanceLB;


@property (weak, nonatomic) IBOutlet UILabel *avgExpenditureAmtLB;
@property (weak, nonatomic) IBOutlet UILabel *sumExpenditureAmtLB;
@property (weak, nonatomic) IBOutlet UILabel *avgDepositAmtLB;
@property (weak, nonatomic) IBOutlet UILabel *sumDepositAmtLB;



@end

@implementation YJNetBankBillHeaderView
+ (id)netBankBillHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YJNetBankBillHeaderView" owner:nil options:nil] firstObject];
}

- (void)setEBankBillModel:(YJEBankBillModel *)eBankBillModel {
    _eBankBillModel = eBankBillModel;
    
    self.realNameLB.text = eBankBillModel.realName;
    
    self.idLB.text = eBankBillModel.identityNo;
    
    self.mobilLB.text = eBankBillModel.mobile;
    
    YJEBankCards *eBankCards = eBankBillModel.cards[_index];
    
    self.cardNoLB.text = eBankCards.cardNo;
    
    self.openDateLB.text = eBankCards.openDate;
    
    self.currencyLB.text = [eBankCards.currency decodeCoin];
    
    self.accTypeLB.text = eBankCards.accType;
    
    self.balanceLB.text = [eBankCards.balance decodeCoinSign:eBankCards.currency];
    
    
    self.availableBalanceLB.text = [eBankCards.availableBalance  decodeCoinSign:eBankCards.currency];
    
    
    self.sumExpenditureAmtLB.text = [eBankCards.sumExpenditureAmt decodeCoinSign:eBankCards.currency];
    
    self.avgExpenditureAmtLB.text = [eBankCards.avgExpenditureAmt decodeCoinSign:eBankCards.currency];
    
    self.sumDepositAmtLB.text = [eBankCards.sumDepositAmt decodeCoinSign:eBankCards.currency];
    
    self.avgDepositAmtLB.text = [eBankCards.avgDepositAmt decodeCoinSign:eBankCards.currency];
    
    
}



@end
