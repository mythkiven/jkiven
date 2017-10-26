//
//  ReportFirstCommonModel.h
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


@interface ReportFirstCommonMainModel : NSObject

/**
 当前查询页码数
 */
@property (nonatomic, copy) NSString *pageNum;
/**
 每页查询数量
 */
@property (nonatomic, copy) NSString *pageSize;
/**
 总数据记录条数
 */
@property (nonatomic, copy) NSString *total;
/**
 总页数
 */
@property (nonatomic, copy) NSString *pages;
/**
 是否最后一页
 */
@property (nonatomic, copy) NSString *isLastPage;
/**
 列表数据
 */
@property (nonatomic, strong) NSArray *list;
//
//@property (copy,nonatomic) NSString *code ;
//@property (copy,nonatomic) NSString *success ;
//@property (copy,nonatomic) NSString *data ;
//@property (copy,nonatomic) NSString *msg ;
//@property (copy,nonatomic) NSArray *list ;

@end


@interface ReportFirstCommonModel : NSObject

@property (copy,nonatomic) NSString *apiId ;
@property (copy,nonatomic) NSString *apiType ;
@property (copy,nonatomic) NSString *apiMethod ;
@property (copy,nonatomic) NSString *province ;
#warning 类型待确认
@property (copy,nonatomic) id  requestData ;
@property (copy,nonatomic) id  responseData ;
@property (copy,nonatomic) NSString *serialNo ;
@property (copy,nonatomic) NSString *status ;
@property (copy,nonatomic) NSString *accountNameStr ;
@property (copy,nonatomic) NSString *accountName ;
@property (copy,nonatomic) NSString *updateDate ;
@property (copy,nonatomic) NSString *socialSecurityData ;
@property (copy,nonatomic) NSString *realName ;
@property (copy,nonatomic) NSString *responseTime ;
@property (copy,nonatomic) NSString *channel ;
@property (copy,nonatomic) NSString *idCard ;
@property (copy,nonatomic) NSString *id ;
@property (copy,nonatomic) NSString *provinceName ;
@property (copy,nonatomic) NSString *token ;
@property (copy,nonatomic) NSString *mobile ;
@property (copy,nonatomic) NSString *condition ;
@property (copy,nonatomic) NSString *requestTime ;
@property (copy,nonatomic) NSString *accountPwd ;
@property (copy,nonatomic) NSString *createDate ;
@property (copy,nonatomic) NSString *userName ;
@property (copy,nonatomic) NSString *remark ;
@property (copy,nonatomic) NSString *userId ;
@property (copy,nonatomic) NSString *createDateApp ;
@property (copy,nonatomic) NSString *position ;

/// 车险的字段
@property (copy,nonatomic) NSString *plateNo ;
@property (copy,nonatomic) NSString *policyNo ;




@end
















