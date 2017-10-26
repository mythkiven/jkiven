//
//  RechargeNavTypeModel.h
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/9/8.
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
@class RechargeNavTypeModelTotalList;
@interface RechargeNavTypeModel : NSObject
@property (assign,nonatomic) BOOL      canTouch;
@property (assign,nonatomic) BOOL      showIcon;
@property (assign,nonatomic) NSInteger  Tag;
@property (copy,nonatomic) NSString*  Name;
// 后台 0:全部 1:待支付。2交易成功。3交易关闭。
@property (assign,nonatomic) NSString*      tagL;
@property(strong,nonatomic) RechargeNavTypeModelTotalList *type;
//返回处理后的model
+(NSMutableArray*)creatWith:(RechargeNavTypeModelTotalList*)arr;

@end


//后台数据
@interface RechargeNavTypeModelNameType : NSObject
//name
@property (copy,nonatomic) NSString      *statusCode  ;
//id
@property (copy,nonatomic) NSString      *statusName ;
@end


//后台数据
@class RechargeNavTypeModelNameType;
@interface RechargeNavTypeModelTotalList : NSObject

//name
@property (copy,nonatomic) NSString      *code ;
//id
@property (copy,nonatomic) NSString      *msg ;
//id
@property (copy,nonatomic) NSDictionary *data ;

@property (copy,nonatomic) NSArray      *list ;

@end




