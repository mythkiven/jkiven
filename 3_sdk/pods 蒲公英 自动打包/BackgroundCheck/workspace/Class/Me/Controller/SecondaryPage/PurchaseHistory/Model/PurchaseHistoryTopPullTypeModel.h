//
//  PurchaseHistoryTopPullTypeModel.h
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/9/7.
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
@class PurchaseHistoryTopPullTypeTotalList;
@interface PurchaseHistoryTopPullTypeModel : NSObject
@property (strong,nonatomic) NSString      *nameLeft;
@property (strong,nonatomic) NSString      *nameRight;
@property (assign,nonatomic) BOOL      selectedL;
@property (assign,nonatomic) BOOL      selectedR;

@property (assign,nonatomic) BOOL      selectedT;
@property (assign,nonatomic) NSString*      tagT;
@property (strong,nonatomic) NSString      *nameT;

@property (assign,nonatomic) NSString*      tagL;
@property (assign,nonatomic) NSString*      tagR;

@property(strong,nonatomic) PurchaseHistoryTopPullTypeTotalList *type;
//返回处理后的model
+(NSMutableArray*)creatWith:(PurchaseHistoryTopPullTypeTotalList*)arr;

@end


//后台数据
@interface PurchaseHistoryTopPullTypeserViceNameType : NSObject
//name
@property (copy,nonatomic) NSString      *serviceName ;
//id
@property (copy,nonatomic) NSString      *apiType ;
@end


//后台数据
@class PurchaseHistoryTopPullTypeserViceNameType;
@interface PurchaseHistoryTopPullTypeTotalList : NSObject

//name
@property (copy,nonatomic) NSString      *code ;
//id
@property (copy,nonatomic) NSString      *msg ;
//id
@property (copy,nonatomic) NSArray      *list ;

@property (copy,nonatomic) NSDictionary *data ;

@end



















