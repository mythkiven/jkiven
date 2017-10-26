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
@class citySearchModel,LMZXCreditListModel,LMZXCompanyCarInsurancModel,LMZXEBankListModel;
@interface LMZXListHookModel : NSObject

// 信用卡model
@property (strong,nonatomic) LMZXCreditListModel      *creditList;

// 车险公司
@property (strong,nonatomic) LMZXCompanyCarInsurancModel      *companyCarInsuranc;

// 网银
@property (strong,nonatomic) LMZXEBankListModel      *eBankListModel;

// 是否选中

@property (assign,nonatomic) BOOL selected;

@end

// 车险
@interface LMZXCompanyCarInsurancModel : NSObject
@property (copy,nonatomic) NSString      *code;
@property (copy,nonatomic) NSString      *name;
@property (copy,nonatomic) NSString       *logo;
@end

// 网银
@interface LMZXEBankListModel : NSObject
@property (copy,nonatomic) NSString      *code;
@property (copy,nonatomic) NSString      *name;
@property (copy,nonatomic) NSString       *logo;
@end

// 信用卡账单
@interface  LMZXCreditListModel : NSObject
@property (copy,nonatomic) NSString      *code;
@property (copy,nonatomic) NSString      *name;
@property (copy,nonatomic) NSString       *logo;
@end


// 总
@interface LMZXSourceALLDataList : NSObject
@property (copy,nonatomic) NSString      *bizType;
@property (copy,nonatomic) NSString      *status;
@property (strong,nonatomic) NSMutableArray      *items;

/** 车险*/
-(instancetype)initWithCarInsurancDic:(NSDictionary*)dic;

/** 网银*/
-(instancetype)initWithEBankDic:(NSDictionary*)dic;

/** 信用卡账单*/
-(instancetype)initWithCreditListDic:(NSDictionary*)dic;

@end































