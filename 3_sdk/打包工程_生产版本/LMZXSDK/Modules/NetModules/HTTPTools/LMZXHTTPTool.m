//
//  YJHTTPTool.m
//  CreditPlatform
//
//  Created by yj on 16/7/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXHTTPTool.h"
#import "LMZXURLRequestSerialization.h"
@implementation LMZXFormData


@end


@implementation LMZXHTTPTool


- (void)dealloc
{
//    MYLog(@"========%@销毁了",self);
}
#pragma mark-- GET请求
/**
 GET请求
 
 @param url 请求路径
 @param params 请求参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSString *error))failure {
    [self requestWithMethod:@"GET" URLString:url parameters:params timeoutInterval:-1 success:success failure:failure];
}

/**
 GET请求
 
 @param url 请求路径
 @param params 请求参数
 @param timeOut 请求超时
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params timeoutInterval:(NSTimeInterval)timeOut success:(void (^)(id responseObj))success failure:(void (^)(NSString *error))failure {
    [self requestWithMethod:@"GET" URLString:url parameters:params timeoutInterval:timeOut success:success failure:failure];
}

#pragma mark-- POST请求
/**
 POST请求
 
 @param url 请求路径
 @param params 请求参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSString *))failure{

    [self requestWithMethod:@"POST" URLString:url parameters:params timeoutInterval:-1 success:success failure:failure];
    
    
}
/**
 POST请求
 
 @param url 请求路径
 @param params 请求参数
 @param timeOut 请求超时
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params timeoutInterval:(NSTimeInterval)timeOut success:(void (^)(id responseObj))success failure:(void (^)(NSString *error))failure {
    
    [self requestWithMethod:@"POST" URLString:url parameters:params timeoutInterval:timeOut success:success failure:failure];
}



#pragma mark-- 私有
+ (void)requestWithMethod:(NSString *)method URLString:(NSString *)url parameters:(NSDictionary *)params timeoutInterval:(NSTimeInterval)timeOut success:(void (^)(id))success failure:(void (^)(NSString *))failure{
    // 1.创建一个网络请求
    NSMutableURLRequest *request = [[LMZXHTTPRequestSerializer serializer] requestWithMethod:method URLString:url parameters:params error:nil];
    if (timeOut>=1) {
        request.timeoutInterval = timeOut;
    }
    
    // 2.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 3.根据会话对象，创建一个Task任务
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 主线程回调结果
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                if (failure) {
                    failure(error.localizedDescription);
                }
                
            }else { 
                
                if (data.length) {
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
                    if (dict) {
                        if (success) {
                            success(dict);
                        }
                        
                    } else {
                        // json字符串
                        NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        if (success) {
                            success(jsonStr);
                        }
                        
                    }
                    
                } else {
                    if (failure) {
                        failure(@"数据为空");
                    }
                }
                
            }
        });
    }];
    //4.最后一步，执行任务，(resume也是继续执行)。
    [sessionDataTask resume];
}



@end
