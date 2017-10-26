//
//  DBManager.h
//  CreditPlatform
//
//  Created by yj on 16/7/11.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface DBManager : NSObject
// 因为整个工程中都是对同一个数据库做操作，所以我们将DBManager设计成单例模式
// 单例模式
+ (instancetype)shareManager;

// 插入数据的方法
- (void)insertDataWithModel:(DataModel *)model;

// 修改数据的方法
- (void)updateDataWithModel:(DataModel *)model;

// 删除数据的方法
- (void)deleteDataWithID:(NSString *)ID;

// 查询所有数据
- (NSArray *)selectAllData;

// 查询部分数据(按条件查询)
// 根据名字查询,这条数据是否已经存在.存在返回YES。
- (BOOL)selectDataIsExistsWithName:(NSString *)name;
@end
