//
//  YJHTTPTool.h
//  CreditPlatform
//
//  Created by yj on 16/7/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LMZXFormData : NSObject

@property (strong, nonatomic) NSData *data;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *filename;

@property (nonatomic, copy) NSString *mimeType;



@end


@interface LMZXHTTPTool : NSObject






#pragma mark-- GET请求
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSString *error))failure;

+ (void)get:(NSString *)url params:(NSDictionary *)params timeoutInterval:(NSTimeInterval)timeOut success:(void (^)(id responseObj))success failure:(void (^)(NSString *error))failure;

#pragma mark-- POST请求
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSString *))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params timeoutInterval:(NSTimeInterval)timeOut success:(void (^)(id responseObj))success failure:(void (^)(NSString *error))failure;



@end
