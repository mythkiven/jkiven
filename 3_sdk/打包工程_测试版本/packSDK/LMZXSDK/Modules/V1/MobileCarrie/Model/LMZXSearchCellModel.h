//
//  CommonSearchCellModel.h
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/8/17.
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
#import "LMZXCommonSearchCell.h"
#import "LMZXCityModel.h"
//#import "CommonSearchSortModel.h"
#import "LMZXSearchCellModel.h"
@class LMZXMobileLoginElement;
@interface LMZXSearchCellModel : NSObject

//cell位置 123,上中下...2个的是:13..3个的是123..4个的是1223
@property (assign,nonatomic) NSInteger  location;

//cell的样式: 1 箭头 2 眼睛 3 无
@property (assign,nonatomic) LMZXCommonSearchCellType type;

//左侧title
@property (copy,nonatomic) NSString*  Name;

//placehold
@property (copy,nonatomic) NSString*  placeholdText;

//text内容
@property (copy,nonatomic) NSString*  Text;

// 输入错误提示内容
@property (copy,nonatomic) NSString*  hint;

//name 长度
@property (assign,nonatomic) CGFloat  maxLength;


@property (nonatomic, assign) LMZXSearchItemType  searchItemType;

// 公积金 社保  共用
@property (strong,nonatomic) LMZXCityLoginElement      *fundModel;


//   运营商
@property (strong,nonatomic) LMZXMobileLoginElement     *mobileModel;


// 公积金社保 model
+ (NSArray*)dataArrWithFundSocialModel:(NSArray *)data Withtype:(LMZXSearchItemType)type;

// 运营商 model
+ (NSArray*)dataArrWithMobileModel:(NSArray *)data Withtype:(LMZXSearchItemType)type;

@end








///////////////////////////// 运营商 登录 元素 配置 /////////


@interface LMZXMobileLoginElement : NSObject

/**
 标签
 */
@property (nonatomic, copy) NSString *label;


/**
 元素名  如：username 、password，对应接口字段的名称
 */
@property (nonatomic, copy) NSString *name;


/**
 类型   text:文本框  password：密码框
 */
@property (nonatomic, copy) NSString *type;

/**
 输入提示
 */
@property (nonatomic, copy) NSString *prompt;

/**
 是否必须
 */
@property (nonatomic, copy) NSString *required;

/**
 输入格式正则表达式
 */
@property (nonatomic, copy) NSString *regex;




+ (instancetype)mobileLoginElementWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

 





