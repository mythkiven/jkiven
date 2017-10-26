//
//  CitySelectModel.h
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/7/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
/*
 *
 *          ┌─┐       ┌─┐
 *       ┌──┘ ┴───────┘ ┴──┐
 *       │                 │
 *       │       ───       │
 *       │  ─┬┘       └┬─  │
 *       │                 │
 *       │       ─┴─       │
 *       │                 │
 *       └───┐         ┌───┘
 *           │         │
 *           │         │
 *           │         │
 *           │         └──────────────┐
 *           │                        │
 *           │                        ├─┐
 *           │                        ┌─┘
 *           │                        │
 *           └─┐  ┐  ┌───────┬──┐  ┌──┘
 *             │ ─┤ ─┤       │ ─┤ ─┤
 *             └──┴──┘       └──┴──┘
 *                 神兽保佑
 *                 代码无BUG!
 */


#import <Foundation/Foundation.h>
@class citySearchModel,reportCreditBillMainModel,CompanyCarInsurancModel,EBankListModel;
@interface ListHookModel : NSObject

// 信用卡model
@property (strong,nonatomic) reportCreditBillMainModel      *credit;

// 车险公司
@property (strong,nonatomic) CompanyCarInsurancModel      *companyCarInsuranc;

// 网银流水
@property (strong,nonatomic) EBankListModel      *eBankListModel;

// 是否选中

@property (assign,nonatomic) BOOL selected;

@end


@interface CompanyCarInsurancModel : NSObject
@property (copy,nonatomic) NSString      *key;
@property (copy,nonatomic) NSString      *val;
@end


@interface EBankListModel : NSObject
@property (copy,nonatomic) NSString      *key;
@property (copy,nonatomic) NSString      *val;
@end

@interface EBankListUpModel : NSObject
@property (copy,nonatomic) NSString      *code;
@property (copy,nonatomic) NSString      *msg;
@property (copy,nonatomic) NSArray      *list;
@end
































