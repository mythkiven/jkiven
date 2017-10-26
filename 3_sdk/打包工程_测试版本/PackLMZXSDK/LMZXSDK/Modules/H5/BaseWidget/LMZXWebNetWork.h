//
//  JNetWork.h
//  WKWebViewDemo
//
//  Created by gyjrong on 16/12/10.
//  Copyright © 2016年 Methodname. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMZXWebNetWork : NSObject
//*异步操作
+ (void)get:(NSString *)url  timeoutInterval:(NSInteger)timeoutInterval  success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
/**timeoutInterval 超时，传0 使用默认30s,其余参数有则传递，无传nil*/
+ (void)post:(NSString *)url timeoutInterval:(NSTimeInterval)timeoutInterval headers:(NSDictionary*)headers params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

@end
