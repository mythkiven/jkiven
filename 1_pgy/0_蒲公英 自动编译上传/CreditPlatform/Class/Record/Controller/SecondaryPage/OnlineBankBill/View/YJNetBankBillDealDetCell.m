//
//  YJNetBankBillDealDetCell.m
//  CreditPlatform
//
//  Created by yj on 2016/11/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJNetBankBillDealDetCell.h"
#import "YJEBankBillModel.h"
//curBal = 893.160,
//remark = 转账支出,
//summary = ,
//amt = 5.000,
//trdType = 支出,
//counterparty =  ,
//trdDate = 2015-11-24,
//currency = CNY
@interface YJNetBankBillDealDetCell ()
@property (weak, nonatomic) IBOutlet UILabel *trdDateLB;
@property (weak, nonatomic) IBOutlet UILabel *counterpartyLB;

@property (weak, nonatomic) IBOutlet UILabel *amtLB;

@property (weak, nonatomic) IBOutlet UILabel *currencyLB;
@property (weak, nonatomic) IBOutlet UILabel *trdTypeLB;
@property (weak, nonatomic) IBOutlet UILabel *remarkLB;

@end

@implementation YJNetBankBillDealDetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setEBankBill:(YJEBankBill *)eBankBill {
    _eBankBill = eBankBill;
    
    
    [self loadData];
    
    
    
}

#pragma mark--加载数据

/**
 保单信息
 */
- (void)loadData {

    
    // 交易时间
    if (![self.eBankBill.trdDate isEqualToString:@""]) {
        
        self.trdDateLB.text = self.eBankBill.trdDate;
    } else {
        self.trdDateLB.text = @"--";
    }
    // 交易对方
    if (![self.eBankBill.counterparty  isEqualToString:@" "]) {
        self.counterpartyLB.text = self.eBankBill.counterparty;
    } else {
        self.counterpartyLB.text = @"--";
    }
    
    // 交易金额
    if (![self.eBankBill.amt isEqualToString:@""]) {
        
        self.amtLB.text = [[NSString stringWithFormat:@"%.2f",[self.eBankBill.amt floatValue]]  decodeCoinSign:self.eBankBill.currency];
    } else {
        self.amtLB.text = @"--";
    }
    
    // 交易币种
    if (![self.eBankBill.currency isEqualToString:@""]) {
        self.currencyLB.text = [self.eBankBill.currency decodeCoin];
    } else {
        self.currencyLB.text = @"--";
    }
    
    // 交易类型
    if (![self.eBankBill.trdType isEqualToString:@""]) {
        self.trdTypeLB.text = self.eBankBill.trdType;
    } else {
        self.trdTypeLB.text = @"--";
    }
    // 交易摘要
    if (![self.eBankBill.remark isEqualToString:@""]) {
        self.remarkLB.text = self.eBankBill.remark;
    } else {
        self.remarkLB.text = @"--";
    }
    
    
    
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    [super setFrame:frame];
    
    
}

@end
