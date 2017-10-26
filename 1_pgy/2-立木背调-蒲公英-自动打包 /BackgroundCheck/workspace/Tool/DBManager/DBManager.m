//
//  DBManager.m
//  CreditPlatform
//
//  Created by yj on 16/7/11.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "DataModel.h"

// FMDatabase:封装了iOS对sqlite3数据库操作的第三方库
@interface DBManager ()
{
    FMDatabase          *_fmdb;
}

@end

@implementation DBManager

// 单例
+ (instancetype)shareManager {
    static DBManager *dbManager = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        if (!dbManager) {
            dbManager = [[DBManager alloc] init];
        }
    });
    
    return dbManager;
}

- (instancetype)init {
    if (self = [super init]) {
        
        NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"data.db"];
        
        // 创建数据库对象
        _fmdb = [FMDatabase databaseWithPath:dbPath];
        
        // 打开数据库
        if ([_fmdb open]) {
            // 建表
            NSString *sql = @"create table if not exists user(id integer primary key autoincrement, name varchar(300), num integer, image blob)";
            
            // 执行sql语句, 建表, 插入, 修改, 删除都用executeUpdate
            BOOL isSuccess = [_fmdb executeUpdate:sql];
            if (isSuccess) {
                MYLog(@"建表成功");
            } else {
                MYLog(@"建表失败:%@", _fmdb.lastErrorMessage);
            }
        }
    }
    
    return self;
}

#pragma mark 插入数据的方法
- (void)insertDataWithModel:(DataModel *)model {
    
    // sql语句里面的占位符是?
    NSString *sql = @"insert into user(name, age, image) values(?, ?, ?)";
    
    // 将png格式的图片转成data
    NSData *imageData = UIImagePNGRepresentation(model.dataIcon);
    
    // 插入数据的时候,所有的值必须是NSObject类型
    BOOL isSuccess = [_fmdb executeUpdate:sql, model.dataName, @(model.dataNum), imageData];
    
    if (isSuccess) {
//        Log(@"插入成功");
    } else {
//        Log(@"插入失败:%@", _fmdb.lastErrorMessage);
    }
    
}

#pragma mark 查询所有数据
- (NSArray *)selectAllData {
    NSMutableArray *userArr = [NSMutableArray array];
    
    NSString *sql = @"select * from user";
    
    // 结果集
    FMResultSet *set = [_fmdb executeQuery:sql];
    
    // 遍历结果集取出数据 [set next]返回YES表示下一条数据存在
    while ([set next]) {
        
        DataModel *model = [[DataModel alloc] init];
        model.dataID = [set stringForColumn:@"id"];
        model.dataName = [set stringForColumn:@"name"];
        model.dataNum = [set intForColumn:@"age"];
        
        NSData *data = [set dataForColumn:@"image"];
        model.dataIcon = [UIImage imageWithData:data];
        
        [userArr addObject:model];
    }
    
    return userArr;
}

#pragma mark 修改数据的方法
- (void)updateDataWithModel:(DataModel *)model {
    
    NSData *imageData = UIImagePNGRepresentation(model.dataIcon);
    
    NSString *sql = @"update user set name =  ?, age = ?, image = ? where id = ?";
    
    BOOL isSuccess = [_fmdb executeUpdate:sql, model.dataName, @(model.dataNum), imageData, model.dataID];
    
    if (isSuccess) {
    } else {
    }
    
}

#pragma mark 删除的方法
- (void)deleteDataWithID:(NSString *)ID {
    
    NSString *sql = @"delete from user where id = ?";
    
    BOOL isSuccess = [_fmdb executeUpdate:sql, ID];
    
    if (isSuccess) {
        MYLog(@"删除成功");
    } else {
        MYLog(@"删除失败:%@", _fmdb.lastErrorMessage);
    }
    
}

#pragma mark 根据名字查询数据是否已经存在
- (BOOL)selectDataIsExistsWithName:(NSString *)name {
    
    NSString *sql = @"select * from user where name = ?";
    
    FMResultSet *set = [_fmdb executeQuery:sql, name];
    
    return [set next];
}


@end
