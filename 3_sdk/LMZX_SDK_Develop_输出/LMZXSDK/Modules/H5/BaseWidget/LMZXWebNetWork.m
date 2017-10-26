//
//  JNetWork.m
//  WKWebViewDemo
//
//  Created by gyjrong on 16/12/10.
//  Copyright © 2016年 Methodname. All rights reserved.
//

#import "LMZXHTTPTool.h" 
#import "LMZXWebNetWork.h"
#import "LMZXDemoAPI.h"
@implementation LMZXWebNetWork



+ (void)post:(NSString *)url timeoutInterval:(NSTimeInterval)timeoutInterval headers:(NSDictionary*)headers params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure{
 
    
    if (!url) {
        return;
    }
    if (url.length<1) {
        return;
    }
    
    if (timeoutInterval==0) timeoutInterval =30;
    

    /**
     1> NSURLRequestUseProtocolCachePolicy = 0, 默认的缓存策略， 如果缓存不存在，直接从服务端获取。如果缓存存在，会根据response中的Cache-Control字段判断下一步操作，如: Cache-Control字段为must-revalidata, 则询问服务端该数据是否有更新，无更新的话直接返回给用户缓存数据，若已更新，则请求服务端.
     2> NSURLRequestReloadIgnoringLocalCacheData = 1, 忽略本地缓存数据，直接请求服务端.
     3> NSURLRequestIgnoringLocalAndRemoteCacheData = 4, 忽略本地缓存，代理服务器以及其他中介，直接请求源服务端.
     4> NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData
     5> NSURLRequestReturnCacheDataElseLoad = 2, 有缓存就使用，不管其有效性(即忽略Cache-Control字段), 无则请求服务端.
     6> NSURLRequestReturnCacheDataDontLoad = 3, 死活加载本地缓存. 没有就失败. (确定当前无网络时使用)
     7> NSURLRequestReloadRevalidatingCacheData = 5, 缓存数据必须得得到服务端确认有效才使用(貌似是NSURLRequestUseProtocolCachePolicy中的一种情况)
     */
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:timeoutInterval];
    
    [request setHTTPMethod:@"POST"];
    
    if (headers) {
        for (NSString *key in headers) {
            NSString *value = [headers objectForKey:key];
            [request setValue:value forHTTPHeaderField:key];
            
        }
    }
    //请求头
//    [request setValue:@"ApiKey 6149056c09e1498ca9b1bcd534b5ad0c" forHTTPHeaderField:@"Authorization"];
//    //请求头
//    [request setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    
    NSMutableArray *array = [NSMutableArray array];
    if (params) {
        for (NSString *key in params) {
            NSString *value = [params objectForKey:key];
            [array addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
        }
        NSString *body = [array componentsJoinedByString:@"&"];
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    }else{
        request.HTTPBody = nil;
    }
    

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 主线程回调结果
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                if (failure) {
                    failure(error);
                }
            }else if ( !data ) {
                if (failure) {
                    failure(error);
                }
            }else if (data.length<1 ) {
                if (failure) {
                    failure(error);
                }
            } else {
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
            }
        });
        
    }];
    [dataTask resume];
}
+ (void)get:(NSString *)url timeoutInterval:(NSInteger)timeoutInterval success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure{
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    if (!url) {
        return;
    }
    if (url.length<1) {
        return;
    }
        NSURLSession *session = [NSURLSession sharedSession];
        
    if (timeoutInterval<=1) {
        timeoutInterval = 20;
    }
        NSMutableURLRequest *request= [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:timeoutInterval];
    request.timeoutInterval = timeoutInterval;

    
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 主线程回调结果
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    if (failure) {
                        failure(error);
                    }
                    
                } else {
                    
                    
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
                    
                    
                }
            });
//            NSString *resultingString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            //        NSLog(@"%@", resultingString);
//            
//            NSError * err;
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
//            if (!dict && err && resultingString.length) {
//                if (success) {
//                    success(resultingString);
//                }
//            }else{
//                if (error) {
//                    if (failure) {
//                        failure(error);
//                    }
//                    
//                } else {
//                    if (success) {
//                        success(dict);
//                    }
//                }
//            }
            
            
        }];
        [dataTask resume];
        
//    });
    
    
    
    
   
}

-(void)getDataWithURL:(NSString*)url{
    
}



@end
