//
//  reportCreditBillModel.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "reportCreditBillModel.h"


@implementation reportCreditBillMainModel
// 1
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"cardChangeInfo":[reportCreditBillChangeInfo class],
             @"cardInstallments":[reportCreditBillinstallments class],
             };
}
-(void)setCardInfo:(reportCreditBillModel *)cardInfo{
    _cardInfo = cardInfo;
    _cardInfo = [reportCreditBillModel mj_objectWithKeyValues:cardInfo];
}

@end
// 1.2 


// 1.3
@implementation reportCreditBillChangeInfo
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"details" : [reportCreditBilldetails class],
             };
}
 

//- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
//    NSString *old = oldValue;
//    NSString *pre = @"￥";
//    // 本期消费金额
//    if ([property.name isEqualToString:@"curDebitsBal"]) {
//       old = [pre stringByAppendingString:old];
//        return old;
//    }// 本期应还 金额
//    else if ([property.name isEqualToString:@"curPaymentBal"]) {
//        old = [pre stringByAppendingString:old];
//        return old;
//    }// 最低应还
//    else if ([property.name isEqualToString:@"minPaymentBal"]) {
//        old = [pre stringByAppendingString:old];
//        return old;
//    }//上期已还金额
//    else if ([property.name isEqualToString:@"prePaymentBal"]) {
//        old = [pre stringByAppendingString:old];
//        return old;
//    }//上期账单金额
//    else if ([property.name isEqualToString:@"preStatementBal"]) {
//        old = [pre stringByAppendingString:old];
//        return old;
//    }
//    return oldValue;
//}
@end





// 1.1、原始数据
@implementation reportCreditBillModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"bills" : [reportCreditBillBills class],
             };
}
@end

// 1.1.1 账单信息 bills
@implementation reportCreditBillBills
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"accountChangeInfos" : [reportCreditBillAccountChangeInfos class],
             @"details" : [reportCreditBilldetails class],
             @"installments" : [reportCreditBillinstallments class]};
}
-(void)setGeneralLedgerInfo:(reportCreditBillGeneralLedgerInfo *)generalLedgerInfo{
    _generalLedgerInfo = generalLedgerInfo;
    _generalLedgerInfo = [reportCreditBillGeneralLedgerInfo mj_objectWithKeyValues:generalLedgerInfo];
}
@end

// 1.1.1.1 字典 总账信息
@implementation reportCreditBillGeneralLedgerInfo
@end

//   1.1.1.2 数组 账户变动
@implementation reportCreditBillAccountChangeInfos
@end

// 1.1.1.3 数组 账单明细
@implementation reportCreditBilldetails
-(id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    NSString *old = oldValue;
    old = FillSpace(old);
    if ([property.name isEqualToString:@"summary"]) {
       old= [NSString  newString:old];
        return old;
    }
    
    
    
    return oldValue;
}

@end

// 1.1.1.4 数组 账单分期
@implementation reportCreditBillinstallments
@end





