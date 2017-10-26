//
//  YJHTTPTool.h
//  CreditPlatform
//
//  Created by yj on 16/7/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YJFormData : NSObject

@property (strong, nonatomic) NSData *data;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *filename;

@property (nonatomic, copy) NSString *mimeType;



@end


@interface YJHTTPTool : NSObject
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POS请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;


+ (void)post:(NSString *)url  timeoutInterval:(float)timeOut params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure ;

/**
 *  发送一个POST请求---上传多个文件
 *
 *  @param url           请求路径
 *  @param params        请求参数
 *  @param formDataArray 请求文件的数据参数
 *  @param success       请求成功后的回调
 *  @param failure       请求失败后的回调
 */
+ (void)postWithURLStr:(NSString *)urlStr parameters:(NSDictionary *)parameters formDataArray:(NSArray *)formDataArray success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;

/**
 jieguo
 */

+ (void)postResult:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

@end
