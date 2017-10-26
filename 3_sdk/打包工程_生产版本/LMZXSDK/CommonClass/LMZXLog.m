//
//  LMZXLog.m
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/3/20.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXLog.h"

@interface LMZXLog ()
{
    BOOL _isLogging;
}

@end
static LMZXLog *_instance;
@implementation LMZXLog

+(LMZXLog*)defaultLog{
    if (_instance == nil) {
        _instance = [[LMZXLog alloc] init];
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isLogging = NO;
    }
    return self;
}
- (void)unlockLog {
    _isLogging = YES;
}
- (void)closeLog {
    _isLogging = NO;
    
}

- (void)LMZXLogging:(NSString *)info {
    if (_isLogging) {
        NSLog(@"%@",info);
    }
}

@end
