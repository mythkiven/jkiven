//
//  YJHomeItemModel.h
//  CreditPlatform
//
//  Created by yj on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJHomeItemModel : NSObject
/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  子标题
 */
@property (nonatomic, copy) NSString *subTitle;
/**
 *  查询类型
 */
@property (nonatomic, assign) int searchItemType;
/**
 *  查询类型字符串
 */
@property (nonatomic, copy) NSString *type;

/**
 *  查询价格
 */
@property (nonatomic, copy) NSString *price;
/**
 *  若设置有选中图标，是否被选中
 */
@property (nonatomic, assign) BOOL isSelected;
@end
