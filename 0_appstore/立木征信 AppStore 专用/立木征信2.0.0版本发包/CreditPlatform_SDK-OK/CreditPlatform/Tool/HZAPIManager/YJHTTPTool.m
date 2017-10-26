//
//  YJHTTPTool.m
//  CreditPlatform
//
//  Created by yj on 16/7/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJHTTPTool.h"
#import "AFNetworking.h"
#import "YJURLSessionManager.h"

@implementation YJFormData


@end

@implementation YJHTTPTool


+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    
    [self setCoookie];
    
    // 1.获得请求管理者
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
   NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:params error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        
        if (error) {
            MYLog(@"Error: %@", error);
            if (failure) {
                failure(error);
            }
            
        } else {
            MYLog(@"%@ %@", response, responseObject);
            
            if (success) {
                success(responseObject);
            }
        }
        
        
    }];
    [dataTask resume];
}
// 需要超时时间的方法。
+ (void)post:(NSString *)url  timeoutInterval:(float)timeOut params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    // cookie
    [self setCoookie];
    
    
    // 1.获得请求管理者
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    YJURLSessionManager *manager = [YJURLSessionManager shareURLSessionManager];

    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:params error:nil];
    request.timeoutInterval = timeOut;
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:params error:nil];
    
    
   NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
       
       if (error) {
//           MYLog(@"失败-------: %@", error);
           if (failure) {
               failure(error);
           }
           
           
       } else {
//           MYLog(@"成功：response：%@ ------- responseObject：%@", response, responseObject);
           
           if (success) {
               
               //////////////////////////
               if ([responseObject isKindOfClass:[NSDictionary class]]) {
                   NSDictionary *dict = responseObject;
                   if ([dict[@"code"] isKindOfClass:[NSString class]]) {
                       if([dict[@"code"] isEqualToString:@"4029"]){
                           // 用于保证只会弹出一个登录页面,防止多次弹出
                           BOOL key = [Tool boolForKey: baozheng_duoci_qingqiu_meici_tanchu_yige_yemian];
                           if(!key){
                               [Tool setBool:YES forKey:baozheng_duoci_qingqiu_meici_tanchu_yige_yemian];
                               [self showLoginView];
                           }
                           
                       }else{
                           success(dict);
                       }
                   }else{
                       success(dict);
                   }
               }else{
                   success(responseObject);
               }
               //////////////////////////
               
           }
       }
       
    }];
    [task resume];
    

}


+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
//    if([url hasStr:@"https"]){
//        
//    }else{
//        
//    }
//    
//    AFHTTPSessionManager *managerQ = [AFHTTPSessionManager manager];
//    managerQ.responseSerializer = [AFHTTPResponseSerializer serializer];
//    AFSecurityPolicy *policy =  [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    //接收无效的证书 默认是NO
//    policy.allowInvalidCertificates = YES;
//    //不验证域名,默认是YES
//    policy.validatesDomainName = NO;
//    managerQ.securityPolicy = policy;
//    managerQ.responseSerializer = [AFJSONResponseSerializer serializer];
    
//    [managerQ GET:@"https://www.baidu.com/" parameters:nil progress:nil
//         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//             NSLog(@"success----%@", [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
//          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//             NSLog(@"error----%@", error);
//         }];
//    
//    
//    [managerQ POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//            MYLog(@"----%@",error);
//        }
//    }];
//    
//    return;
    // 1.获得请求管理者
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    // cookie
    [self setCoookie];
    
    
    YJURLSessionManager *manager = [YJURLSessionManager shareURLSessionManager];

    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:params error:nil];
    //    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:params error:nil];
    
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            //           MYLog(@"失败-------: %@", error);
            if (failure) {
                failure(error);
            }
            
            
        } else {
            
            if (success) {
//                NSLog(@"%@",responseObject);
                
                //////////////////////////
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dict = responseObject;
                    if ([dict[@"code"] isKindOfClass:[NSString class]]) {
                        if([dict[@"code"] isEqualToString:@"4029"]){
                            // 用于保证只会弹出一个登录页面,防止多次弹出
                            BOOL key = [Tool boolForKey: baozheng_duoci_qingqiu_meici_tanchu_yige_yemian];
                            if(!key){
                                [Tool setBool:YES forKey:baozheng_duoci_qingqiu_meici_tanchu_yige_yemian];
                                [self showLoginView];
                            }
                            
                        }else{
                            success(dict);
                        }
                    }else{
                        success(dict);
                    }
                }else{
                    success(responseObject);
                }
                //////////////////////////
            }
        }
        
    }];
    [task resume];
    
    
}

+ (void)postWithURLStr:(NSString *)urlStr parameters:(NSDictionary *)parameters formDataArray:(NSArray *)formDataArray success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
        
        for (YJFormData *formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
            
        }
    } error:nil];
    
    
    // cookie
    [self setCoookie];
    
    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    YJURLSessionManager *manager = [YJURLSessionManager shareURLSessionManager];

    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      
                      
                      dispatch_async(dispatch_get_main_queue(), ^{
                          // 在主线程刷新UI
//                          [progressView setProgress:uploadProgress.fractionCompleted];
                      });
                      
                      
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      
                      if (error) {
                          MYLog(@"Error: %@", error);
                          if (failure) {
                              failure(error);
                          }
                          
                          
                      } else {
                          MYLog(@"%@ %@", response, responseObject);
                          
                          if (success) {
                              
                              
                              //////////////////////////
                              if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                  NSDictionary *dict = responseObject;
                                  if ([dict[@"code"] isKindOfClass:[NSString class]]) {
                                      if([dict[@"code"] isEqualToString:@"4029"]){
                                          // 用于保证只会弹出一个登录页面,防止多次弹出
                                          BOOL key = [Tool boolForKey:baozheng_duoci_qingqiu_meici_tanchu_yige_yemian];
                                          if(!key){
                                              [Tool setBool:YES forKey:baozheng_duoci_qingqiu_meici_tanchu_yige_yemian];
                                              [self showLoginView];
                                          }
                                          
                                      }else{
                                          success(dict);
                                      }
                                  }else{
                                      success(dict);
                                  }
                              }else{
                                  success(responseObject);
                              }
                              //////////////////////////
                              
                          }
                      }
                      
                  }];
    
    [uploadTask resume];
    
}


#pragma mark 登录
+ (void)showLoginView {
    LoginVC *login = [[LoginVC alloc] init];
    YJNavigationController *LL = [[YJNavigationController alloc]initWithRootViewController:login];
    [[self getPresentedViewController] presentViewController:LL animated:YES completion:NULL];
    
}


+ (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
/**
 获取当前控制器
 */
- (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
    
}

#pragma mark 再取出保存的cookie重新设置cookie
+ (void)setCoookie {
    //取出保存的cookie
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //对取出的cookie进行反归档处理
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:cookie_session_login_lmzx]];
    if (cookies) {
        //设置cookie 
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (id cookie in cookies) {
            [cookieStorage setCookie:(NSHTTPCookie *)cookie];
        }
    }else{
        NSLog(@"无cookie");
//        // 登录
//        [self showLoginView];
        
    }
}




#pragma mark - 私有 用于 获取结果
+ (void)postResult:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure{
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    
    [request setHTTPMethod:@"POST"];
    
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



@end
