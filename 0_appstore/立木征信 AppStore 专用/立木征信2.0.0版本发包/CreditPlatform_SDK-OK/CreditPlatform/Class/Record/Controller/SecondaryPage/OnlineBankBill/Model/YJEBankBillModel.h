//
//  YJEBankBillModel.h
//  CreditPlatform
//
//  Created by yj on 2016/11/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
/**************** 1.账单 **************/
@interface YJEBankBill : NSObject
/**
 交易日期(yyyy-MM-dd)
 */
@property (nonatomic, copy) NSString *trdDate;
/**
 交易对方
 */
@property (nonatomic, copy) NSString *counterparty;
/**
 交易金额
 */
@property (nonatomic, copy) NSString *amt;
/**
 当前余额
 */
@property (nonatomic, copy) NSString *curBal;
/**
 交易币种(CNY:人民币 USD:美元)
 */
@property (nonatomic, copy) NSString *currency;
/**
 交易类型(收入、支持)
 */
@property (nonatomic, copy) NSString *trdType;
/**
 交易摘要
 */
@property (nonatomic, copy) NSString *remark;
/**
 交易附言
 */
@property (nonatomic, copy) NSString *summary;


@end

/**************** 1.卡 **************/
@interface YJEBankCards : NSObject

@property (nonatomic, assign) BOOL isSelected;

/**
 卡号
 */
@property (nonatomic, copy) NSString *cardNo;
/**
 账号类型
 */
@property (nonatomic, copy) NSString *accType;
/**
 币种
 */
@property (nonatomic, copy) NSString *currency;
/**
 余额
 */
@property (nonatomic, copy) NSString *balance;
/**
 可用余额
 */
@property (nonatomic, copy) NSString *availableBalance;
/**
 开户日期
 */
@property (nonatomic, copy) NSString *openDate;

/**
 平均月支出
 */
@property (nonatomic, copy) NSString *avgExpenditureAmt;
/**
 合计月支出
 */
@property (nonatomic, copy) NSString *sumExpenditureAmt;
/**
 平均月存
 */
@property (nonatomic, copy) NSString *avgDepositAmt;
/**
 合计月存
 */
@property (nonatomic, copy) NSString *sumDepositAmt;


/**
 账单信息
 */
@property (nonatomic, strong) NSArray *bills;


@end

/**************** 网银流水 **************/
@interface YJEBankBillModel : NSObject
/**
 身份证号
 */
@property (nonatomic, copy) NSString *identityNo;
/**
 姓名
 */
@property (nonatomic, copy) NSString *realName;
/**
 手机号
 */
@property (nonatomic, copy) NSString *mobile;
/**
 银行
 */
@property (nonatomic, copy) NSString *bankCode;

/**
 网银流水信息
 */
@property (nonatomic, strong) NSArray *cards;



@end
