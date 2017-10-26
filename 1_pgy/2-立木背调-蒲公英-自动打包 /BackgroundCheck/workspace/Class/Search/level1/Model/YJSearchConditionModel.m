//
//  YJSearchConditionModel.m
//  CreditPlatform
//
//  Created by yj on 16/8/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJSearchConditionModel.h"

@implementation YJSearchConditionModel
- (void)setAccount:(NSString *)account passWord:(NSString *)passWord servicePass:(NSString *)service{
    _account = account;
    _passWord = passWord;
    _servicePass = (!service)?@"":service;
    
}

- (void)setCityCode:(NSString *)cityCode account:(NSString *)account passWord:(NSString *)passWord servicePass:(NSString *)service{
    _cityCode = cityCode;
    [self setAccount:account passWord:passWord servicePass:service];
}
- (void)setCityCode:(NSString *)cityCode account:(NSString *)account passWord:(NSString *)passWord servicePass:(NSString *)service otherInfo:(NSString *)otherInfo{
    _cityCode = cityCode;
    _otherInfo = otherInfo;
    [self setAccount:account passWord:passWord servicePass:service];
}

@end
