//
//  YJPageBaseModel.h
//  CreditPlatform
//
//  Created by yj on 2017/5/18.
//  Copyright © 2017年 kangcheng. All rights reserved.
//  数据分页模型

#import <Foundation/Foundation.h>

@interface YJPageBaseModel : NSObject

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

@end
