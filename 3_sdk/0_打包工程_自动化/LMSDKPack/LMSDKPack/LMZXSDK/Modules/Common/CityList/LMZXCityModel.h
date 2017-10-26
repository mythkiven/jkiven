//
//  LMZXCityModel.h
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/2/15.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMZXCityLoginElement : NSObject


/**
 元素名  如：username 、password，对应接口字段的名称
 */
@property (nonatomic, copy) NSString *name;

/**
 城市名称
 */
@property (nonatomic, copy) NSString *label;

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



+ (instancetype)cityLoginElementWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end



@interface LMZXCityModel : NSObject


/**
 0: 维护中  1：正常
 */
@property (nonatomic, copy) NSString *status;

/**
 地区代码
 */
@property (nonatomic, copy) NSString *areaCode;

/**
 地区名称
 */
@property (nonatomic, copy) NSString *areaName;

/**
 地区首字母(全拼)
 */
@property (nonatomic, copy) NSString *sortLetter;



/**
 地区登录元素
 */
@property (nonatomic, strong) NSArray *elements;



/**
 是否选中当前城市
 */
@property (nonatomic, assign) BOOL isSelected;


/**
 地区简拼
 */
@property (nonatomic, copy) NSString *spellShort;

/**
 纳入搜索列表(控制不重复出现)
 */
@property (nonatomic, assign) BOOL isInSearchList;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)cityWithDict:(NSDictionary *)dict;

@end
