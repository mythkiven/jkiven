//
//  YJURLSessionManager.m
//  CreditPlatform
//
//  Created by yj on 16/8/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJURLSessionManager.h"

@implementation YJURLSessionManager
static YJURLSessionManager *_instance;

+ (instancetype)shareURLSessionManager {
    if (_instance == nil) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _instance = [[YJURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
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


@end