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
#import "CommonSearchCell.h"
#import "YJCityModel.h"
#import "CommonSearchSortModel.h"

@interface CommonSearchCellModel : NSObject

//cell位置 123,上中下
@property (assign,nonatomic) NSInteger  location;
//cell的样式: 1 箭头 2 眼睛 3 无
@property (assign,nonatomic) CommonSearchCellType type;
//左侧title
@property (copy,nonatomic) NSString*  Name;
//placehold
@property (copy,nonatomic) NSString*  placeholdText;
//text内容
@property (copy,nonatomic) NSString*  Text;
// name 长度
@property (assign,nonatomic) CGFloat  maxLength;


@property (nonatomic, assign) SearchItemType  searchItemType;

@property (strong,nonatomic) JFundSocialSearchCellModel      *fundModel;


// 公积金社保 model

+ (NSArray*)dataArrWithFundSocialModel:(NSArray *)data Withtype:(SearchItemType)type;
@end







