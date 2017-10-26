//
//  OperatorsDataTool.h
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/8/3.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
/*
 *
 *          ┌─┐       ┌─┐
 *       ┌──┘ ┴───────┘ ┴──┐
 *       │                 │
 *       │       ───       │
 *       │  ─┬┘       └┬─  │
 *       │                 │
 *       │       ─┴─       │
 *       │                 │
 *       └───┐         ┌───┘
 *           │         │
 *           │         │
 *           │         │
 *           │         └──────────────┐
 *           │                        │
 *           │                        ├─┐
 *           │                        ┌─┘
 *           │                        │
 *           └─┐  ┐  ┌───────┬──┐  ┌──┘
 *             │ ─┤ ─┤       │ ─┤ ─┤
 *             └──┴──┘       └──┴──┘
 *                 神兽保佑
 *                 代码无BUG!
 */


#import "YJBaseSearchDataTool.h"

@interface OperatorsDataTool : YJBaseSearchDataTool
@property (copy,nonatomic) NSString      *info;
@property (copy,nonatomic) NSString      *mobile;
@property (copy,nonatomic) NSString      *password;
@property (copy,nonatomic) NSString      *password2;

// 验证码页面是91。运营商重置密码：前一个页面：81 后一个页面：88
@property (assign,nonatomic) NSInteger isfrom;
/**
 *  获取运营商数据
 *  dic 请求信息
 *  @param success 请求成功返回结果
 *  @param failure 请求失败回调
 */
- (void)searchInfo:(NSDictionary *)dic OperatorsDataSuccesssuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;
// 验证码接口
- (void)messageInfo:(NSDictionary *)dic OperatorsDataMeaasgasuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;
// 重置密码接口
- (void)resetInfo:(NSDictionary *)dic OperatorsData:(void (^)(id))success failure:(void (^)(NSError *))failure;

















@end
