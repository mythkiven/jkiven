//
//  YJBaseSearchDataTool.h
//  CreditPlatform
//
//  Created by yj on 16/8/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJSearchConditionModel.h"
#import "HomeSearchType.h"
typedef void(^SearchSuccess)(id);
typedef void(^SearchFailure)(id);
//typedef void(^SearchTimeOut)(id);

@interface YJBaseSearchDataTool : NSObject
{
//    NSTimer *_timer;
    __block  NSString *_token;
//    /** 轮训总时间*/
//    long long Long;
}
@property (strong,nonatomic) NSTimer      *timer;
/** 用于定义超时时间*/
@property (assign,nonatomic) SearchItemType    searchType;

/** 超时时间*/
@property (nonatomic, assign) float timeOut;

@property (nonatomic, strong) UIViewController  *vc;

@property (nonatomic, strong) YJSearchConditionModel *searchConditionModel;

@property (nonatomic, copy) SearchSuccess searchSuccess;

///**超时回调*/
//@property (nonatomic, copy) SearchTimeOut searchTimeOut;

@property (nonatomic, copy) SearchFailure searchFailure;
/* 添加定时器 */
- (void)addTimer;

/**
 *  停止定时器
 *  结束循环请求
 */
- (void)removeTimer;


@end
