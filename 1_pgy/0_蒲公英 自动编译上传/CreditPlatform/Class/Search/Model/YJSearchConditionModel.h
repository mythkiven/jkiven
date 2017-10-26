//
//  YJSearchConditionModel.h
//  CreditPlatform
//
//  Created by yj on 16/8/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    YJGoToSearchResultTypeFromHome = 11,//  代表从首页查询进入
    YJGoToSearchResultTypeFromRecord//  代表从记录页面进入
} YJGoToSearchResultType;

@interface YJSearchConditionModel : NSObject

@property (assign, nonatomic) YJGoToSearchResultType type;

/**车险 2 保单 1 账号*/
@property (assign,nonatomic) NSInteger   searchType;

/**城市code、公司代号、网银流水的银行等等 */
@property (copy,nonatomic) NSString    *cityCode;
/**账号 对应 username*/
@property (copy,nonatomic) NSString    *account;
/**密码 对应 password*/
@property (copy,nonatomic) NSString    *passWord;
/**客服密码、真实姓名、央行验证码、*/
@property (copy,nonatomic) NSString    *servicePass;

/**公积金社保新增：*/
@property (copy,nonatomic) NSString    *otherInfo;

/** ID 如果是从记录页面进入*/
@property (copy,nonatomic) NSString    *ID;

- (void)setAccount:(NSString *)account passWord:(NSString *)passWord servicePass:(NSString *)service;

- (void)setCityCode:(NSString *)cityCode account:(NSString *)account passWord:(NSString *)passWord servicePass:(NSString *)service;
- (void)setCityCode:(NSString *)cityCode account:(NSString *)account passWord:(NSString *)passWord servicePass:(NSString *)service otherInfo:(NSString *)otherinfo;
@end
