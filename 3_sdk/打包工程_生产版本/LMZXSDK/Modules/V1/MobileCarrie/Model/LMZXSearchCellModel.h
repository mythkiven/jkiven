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
@interface LMZXSearchCellModel : NSObject

//cell位置 123,上中下
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

@property (strong,nonatomic) LMZXCityLoginElement      *fundModel;


// 公积金社保 model

+ (NSArray*)dataArrWithFundSocialModel:(NSArray *)data Withtype:(LMZXSearchItemType)type;
@end







