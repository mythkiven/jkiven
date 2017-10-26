//
//  CompanyDetailModel.h
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/8/6.
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

@interface CompanyDetailModel : NSObject

@property (copy,nonatomic) NSString *auditDate ;
@property (copy,nonatomic) NSString *busiLicenseCode ;
@property (copy,nonatomic) NSString *busiLicenseFileid ;
@property (copy,nonatomic) NSString *busiLicensePicture ;
@property (copy,nonatomic) NSString *certiType ;
@property (copy,nonatomic) NSString *certiTypestr ;
@property (copy,nonatomic) NSString *companyAddress ;
@property (copy,nonatomic) NSString *companyCity ;
@property (copy,nonatomic) NSString *companyName ;
@property (copy,nonatomic) NSString *companyProvince ;
@property (copy,nonatomic) NSString *createDate ;
//@property (copy,nonatomic) NSString *ID ;
@property (copy,nonatomic) NSString *mobile ;
@property (copy,nonatomic) NSString *remark ;
@property (copy,nonatomic) NSString *status  ;
@property (copy,nonatomic) NSString *statusStr ;
@property (copy,nonatomic) NSString *updateDate ;
@property (copy,nonatomic) NSString *userId ;

@end













