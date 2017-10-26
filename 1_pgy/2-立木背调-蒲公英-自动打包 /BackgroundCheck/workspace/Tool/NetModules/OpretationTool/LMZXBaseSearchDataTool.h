//
//  YJBaseSearchDataTool.h
//  LiMuCycle
//
//  Created by yj on 2017/2/13.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LMZXQueryInfoModel;
typedef enum {
    LMBCSearchTypeBasic,
    LMBCSearchTypeStandard
}LMBCSearchType;


/** 成功回调:
 @param obj 成功数据
 */
typedef void(^LMSearchSuccess)(id obj);

/** 失败回调:
 @param error 查询失败的 msg,展示在 SDK 中,替代 block: SearchFailure
 */
typedef void(^LMSearchFailure)(NSString * error);


@interface LMZXBaseSearchDataTool : NSObject



//#warning --- 如果有验证码,必须传值.
/** 查询的 model
 
*/
@property (nonatomic, strong) LMZXQueryInfoModel *queryInfoModel;




/**
 查询成功回调
 */
@property (nonatomic, copy) LMSearchSuccess searchSuccess;

/**
 查询失败/状态回调
 */
@property (nonatomic, copy) LMSearchFailure searchFailure;


/**
 用户是否终止查询
 */
@property (nonatomic, assign) BOOL isUserStopSearch;


#pragma mark- 对外方法

+ (instancetype)searchDataTool;

/**
 用户终止查询,会有回调
 */
- (void)stopSearch ;


/**
 查询

 @param type 基础or标准
 @param name 姓名
 @param mobile 手机号
 @param idNO 身份证
 @param position 职位
 */
- (void)searchType:(LMBCSearchType)type name:(NSString *)name mobile:(NSString *)mobile idNO:(NSString *)idNO position:(NSString *)position;


/**
 查询

 @param type 基础or标准
 @param queryInfoModel 查询模型数据
 */
- (void)searchType:(LMBCSearchType)type queryInfoModel:(LMZXQueryInfoModel*)queryInfoModel;


/**
 显示报告列表

 @param type 基础or标准
 @param crrentPage 当前页码
 @param requestName 搜索条件：手机号或者姓名
 @param success 成功回调
 @param failure 失败回调
 */
- (void)searchAllListWithType:(LMBCSearchType)type crrentPage:(NSString *)crrentPage requestName:(NSString *)requestName success:(LMSearchSuccess)success failure:(LMSearchFailure)failure;


/**
 显示报告列表

 @param type 基础or标准
 @param crrentPage 当前页码
 @param requestName 搜索条件：手机号或者姓名
 */
- (void)searchAllListWithType:(LMBCSearchType)type crrentPage:(NSString *)crrentPage requestName:(NSString *)requestName;


/**
 根据UID获取报告

 @param UID UID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)getReportWithUID:(NSString*)UID success:(LMSearchSuccess)success failure:(LMSearchFailure)failure;
/**
 根据UID获取报告
 
 */
- (void)getReportWithUID:(NSString*)UID;




@end
