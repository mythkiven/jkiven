//
//  reportCreditBillModel.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//



// 信用卡邮箱账单
#import <Foundation/Foundation.h>
@class reportCreditBilldetails,reportCreditBillinstallments,reportCreditBillGeneralLedgerInfo,reportCreditBillAccountChangeInfos,reportCreditBillBills,reportCreditBillModel;

// 1、统计以后的信息  主入口
@interface reportCreditBillMainModel : NSObject
@property (strong,nonatomic) NSArray      *cardChangeInfo;//1.3 统计的月份数据
@property (strong,nonatomic) reportCreditBillModel      *cardInfo;//1.1 原始数据
@property (strong,nonatomic) NSArray      *cardInstallments;//1.2 统计的分期数据
@end

// 1.2 账单分期 数组 ==== 1.1.1.4 数组 账单分期

// 1.3 按月数据 字典(数组)
@interface reportCreditBillChangeInfo : NSObject
@property (strong,nonatomic) NSString      *curDebitsBal;// 本期消费金额
@property (strong,nonatomic) NSString      *curPaymentBal;// 本期应还 金额
@property (strong,nonatomic) NSString      *minPaymentBal;// 最低应还
@property (strong,nonatomic) NSString      *paymentDueDate; //到期还款日
@property (strong,nonatomic) NSString      *prePaymentBal; //上期已还金额
@property (strong,nonatomic) NSString      *preStatementBal; //上期账单金额
@property (strong,nonatomic) NSString      *statementMonth;// 账单月份
//账单信息
@property (strong,nonatomic) NSArray      *details;
//新增 币种符号
@property (strong,nonatomic) NSString      *currency;
@end




// 1.1、原始数据
@interface reportCreditBillModel : NSObject
@property (strong,nonatomic) NSString      *cardNo;
@property (strong,nonatomic) NSString      *realName;
@property (strong,nonatomic) NSString      *currency;
@property (strong,nonatomic) NSString      *creditLimit;
@property (strong,nonatomic) NSString      *withdrawalLimit;
@property (strong,nonatomic) NSString      *bankCode;
@property (strong,nonatomic) NSArray      *bills;
@end


// 1.1.1 账单信息 bills
@interface reportCreditBillBills : NSObject
@property (strong,nonatomic) NSString      *statementMonth;
@property (strong,nonatomic) NSString      *statementStartDate;
@property (strong,nonatomic) NSString      *statementEndDate;
@property (strong,nonatomic) NSString      *paymentDueDate;
//总账信息
@property (strong,nonatomic) reportCreditBillGeneralLedgerInfo      *generalLedgerInfo;
// 账户变动
@property (strong,nonatomic) NSArray      *accountChangeInfos;
// 账单明细
@property (strong,nonatomic) NSArray      *details;
// 账单分期
@property (strong,nonatomic) NSArray      *installments;

@end

// 1.1.1.1 字典 总账信息
@interface reportCreditBillGeneralLedgerInfo : NSObject
@property (strong,nonatomic) NSString      *curPaymentBal;
@property (strong,nonatomic) NSString      *minPaymentBal;
@property (strong,nonatomic) NSString      *creditLimit;
@property (strong,nonatomic) NSString      *withdrawalLimit;



@end
//   1.1.1.2 数组 账户变动
@interface  reportCreditBillAccountChangeInfos: NSObject
@property (strong,nonatomic) NSString      *cardNo;
@property (strong,nonatomic) NSString      *curStatementBal;
@property (strong,nonatomic) NSString      *curDebitsBal;
@property (strong,nonatomic) NSString      *preStatementBal;
@property (strong,nonatomic) NSString      *prePaymentBal;
@property (strong,nonatomic) NSString      *curAdjustmentBal;
@property (strong,nonatomic) NSString      *cycleInterest;
@end

// 1.1.1.3 数组 账单明细
@interface reportCreditBilldetails : NSObject
@property (strong,nonatomic) NSString      *trdDate;
@property (strong,nonatomic) NSString      *accDate;
@property (strong,nonatomic) NSString      *cardNo;
@property (strong,nonatomic) NSString      *amt;
@property (strong,nonatomic) NSString      *currency;
@property (strong,nonatomic) NSString      *accAmt;
@property (strong,nonatomic) NSString      *summary;//描述
@end


// 1.1.1.4 数组 账单分期
@interface reportCreditBillinstallments: NSObject
@property (strong,nonatomic) NSString      *cardNo;
@property (strong,nonatomic) NSString      *instalmentType;
@property (strong,nonatomic) NSString      *instalmentDate;
@property (strong,nonatomic) NSString      *instalmentBal;
@property (strong,nonatomic) NSString      *instalmentCount;
@property (strong,nonatomic) NSString      *residualnstalmentCount;
@property (strong,nonatomic) NSString      *curInstalmentAmt;
@property (strong,nonatomic) NSString      *curInstalmentFeeAmt;
@property (strong,nonatomic) NSString      *curRepaymentAmt;
@property (strong,nonatomic) NSString      *residualPrincipal;
@end







