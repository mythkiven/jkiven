//
//  YJBaseSearchDataTool.m
//  LiMuCycle
//
//  Created by yj on 2017/2/13.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import "LMZXBaseSearchDataTool.h"
#import "LMZXHTTPTool.h"

#import "LMZXQueryInfoModel.h"
#import <CommonCrypto/CommonDigest.h>


#define API_1 @"http://192.168.110.104:8041/app"
#define API_2 @"http://192.168.110.105:8042/app/"

//授权
#define url_basicsSearchResult @"admin/backTask/basicsSearchResult"
#define url_standardSearchResult @"admin/backTask/standardSearchResult"

// 获取状态
#define url_basicsSearchStatus @"admin/backTask/basicsSearchStatus"
#define url_standardSearchStatus @"admin/backTask/standardSearchStatus"

//获取列表
#define url_basicsSearch @"basicsSearch"
#define url_standardSearch @"standardSearch"

//报告详情
#define url_ReportDetail @"ReportDetail"

@interface LMZXBaseSearchDataTool()
{
    NSDictionary *_params;
    NSData *_data1;

    
    BOOL _isSearch;// 正在查询中
    BOOL _isSuccess;// 查询成功
    BOOL _isSendAuth;// 是否发送签名
    
}
/**
// 请求地址
// */
//@property (nonatomic, copy) NSString *url;
///**
// 定时器
// */
//@property (nonatomic, strong) NSTimer *timer;

/**
 定时器
 */
@property (nonatomic, strong) NSTimer *timer;

/**
 查询类型
 */
@property (nonatomic, copy) NSString *bizType;
/**
 1.授权
 */
@property (nonatomic, copy) NSString *getTokenUrl;
/**
 2.状态
 */
@property (nonatomic, copy) NSString *getStatusUrl;
/**
 3.结果
 */
@property (nonatomic, copy) NSString *getResultUrl;

/**
 4.列表
 */
@property (nonatomic, copy) NSString *getListUrl;

/**
 授权
 */
@property (nonatomic, copy) NSString *token;

/**
 第一次请求等待时间
 */
@property (nonatomic, assign) CGFloat firstTime;

/**
 循环请求间隔
 */
@property (nonatomic, assign) CGFloat circleTime;

/**
 请求超时时间
 */
@property (nonatomic, assign) CGFloat timeOut;
/**
 循环请求总时间
 */
@property (nonatomic, assign) CGFloat totalCircleTime;


@end

@implementation LMZXBaseSearchDataTool

- (void)dealloc
{
//    MYLog(@"-------%@销毁了",self);
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _firstTime=1;
        _circleTime=1.5;
        _timeOut = 60;
        _isSendAuth = NO;
    }
    return self;
}
+ (instancetype)searchDataTool {
    return [[self alloc] init];
}


#pragma mark- 对外方法

- (void)searchType:(LMBCSearchType)type name:(NSString *)name mobile:(NSString *)mobile idNO:(NSString *)idNO position:(NSString *)position {
     [self setSearchType:type];
    
    [self getTaskIDWithName:name mobile:mobile idNO:idNO position:position];
}

- (void)searchType:(LMBCSearchType)type queryInfoModel:(LMZXQueryInfoModel*)queryInfoModel {
    [self searchType:type name:queryInfoModel.name mobile:queryInfoModel.mobile idNO:queryInfoModel.identityNo position:queryInfoModel.position];
}


- (void)searchAllListWithType:(LMBCSearchType)type crrentPage:(NSString *)crrentPage requestName:(NSString *)requestName success:(LMSearchSuccess)success failure:(LMSearchFailure)failure {
    _searchSuccess = success;
    _searchFailure = failure;
    [self searchAllListWithType:type crrentPage:crrentPage requestName:requestName];
}


- (void)searchAllListWithType:(LMBCSearchType)type crrentPage:(NSString *)crrentPage requestName:(NSString *)requestName{
    [self setSearchType:type];
    
    if (!requestName.length) {
        requestName = @"";
    }
    NSDictionary *dict = @{
                           @"companyName":kUserManagerTool.companyName,
                           @"requestName":requestName,
                               @"reportType":_bizType,
                           @"crrentPage":crrentPage,
                           @"pageSize":@"20"
                           };
    
    // 3.获取查询结果
    [YJHTTPTool post:_getListUrl params:dict success:^(id obj) {
        MYLog(@"立木背调Log:列表......%@",obj);
        if ([obj isKindOfClass:[NSNull class]]) {
            if (_searchFailure) {
                _searchFailure(@"获取结果请求失败");
            }
        } else {
            if ([obj[@"code"] isEqualToString:@"000000"] || [obj[@"code"] isEqualToString:@"error_0001"]) {
                if (_searchSuccess) {
                    _searchSuccess(obj);
                }
            } else {
                if (_searchFailure) {
                    _searchFailure(obj[@"msg"]);
                }
            }
            
        }
        


    } failure:^(NSError *error) {
        MYLog(@"立木背调Log:查询失败:%@",error);
        if (_searchFailure) {
            _searchFailure(@"网络加载失败");
        }
    }];
    
}

- (void)getReportWithUID:(NSString*)UID success:(LMSearchSuccess)success failure:(LMSearchFailure)failure {
    _searchSuccess = success;
    _searchFailure = failure;
    [self getReportWithUID:UID];
}

- (void)getReportWithUID:(NSString*)UID {
    [self queryResultWithTaskId:UID];
}


#pragma mark - 用户停止查询
- (void)stopSearch {
    // 如果正在查询
    if (_isSearch) {
        
        if (self.searchFailure) {
            self.searchFailure(@"用户取消查询");
        }
        
        [self removeTimer];
        
        _isUserStopSearch = YES;
    }
    
}



#pragma mark - ***************私有方法****************
- (void)setSearchType:(LMBCSearchType)type {
    _getResultUrl = [API_2 stringByAppendingString:url_ReportDetail];

    switch (type) {
        case LMBCSearchTypeBasic:
            _bizType = @"beidiaobasic";
            _getTokenUrl = [API_1 stringByReplacingOccurrencesOfString:@"app" withString:url_basicsSearchResult];
            _getStatusUrl = [API_1 stringByReplacingOccurrencesOfString:@"app" withString:url_basicsSearchStatus];
            _getListUrl = [API_2 stringByAppendingString:url_basicsSearch];

            break;
        case LMBCSearchTypeStandard:
            _bizType = @"beidiaostandard";
            _getTokenUrl = [API_1 stringByReplacingOccurrencesOfString:@"app" withString:url_standardSearchResult];
            _getStatusUrl = [API_1 stringByReplacingOccurrencesOfString:@"app" withString:url_standardSearchStatus];
            _getListUrl = [API_2 stringByAppendingString:url_standardSearch];

            break;
        default:
            break;
    }
}

#pragma mark- 添加定时器
- (void)addTimer {
    if (_timer == nil) {
        // 增加定时器前，先进行一次请求
        [self startRequestData];
        // 第一次请求结束后，添加定时器开始轮训
        [self performSelector:@selector(startCycleRequest) withObject:nil afterDelay:_firstTime];
    }
}

#pragma mark- 开启轮循
- (void)startCycleRequest {
    // 添加定时器前，是否已经终止了查询
    if (!_isUserStopSearch) {
        _firstTime = 0;
        _timer = [NSTimer timerWithTimeInterval:_circleTime target:self selector:@selector(startRequestData) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
    }
}


#pragma mark- 请求超时，移除定时器
- (void)removeTimerWithTimeOut {
    [self removeTimer];
    if (_searchFailure) {
        _searchFailure(@"查询超时，请重试。");
    }
    MYLog(@"立木背调Log:请求超时");
}

#pragma mark- 移除定时器，停止循环请求
- (void)removeTimer {
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        
        _isSearch = NO;
    }

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startCycleRequest) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
}

#pragma mark - **1.获取token**
- (void)getTaskIDWithName:(NSString *)name mobile:(NSString *)mobile idNO:(NSString *)idNO position:(NSString *)position {
    __weak typeof(self) weakSelf = self;
    NSDictionary *dict = @{@"realName" : name,
                           @"iCard" : idNO,
                           @"telephone" : mobile,
                           @"position" : position,
                           @"type" : _bizType,
                           @"companyName" : kUserManagerTool.companyName,
                           @"queryPhone" : kUserManagerTool.mobile
                           };
    
    _isSearch = YES;
    [YJHTTPTool post:_getTokenUrl params:dict success:^(id responseObj) {
        _isSearch = NO;
        MYLog(@"1.背调查询---%@",responseObj);
        if (!responseObj) {//某些特殊情况
            
            if (_searchFailure) {
                _searchFailure(@"查询失败");
            }
            return;
        }
        
        if (![responseObj[@"code"] isKindOfClass:[NSNull class]]) {
            if ([responseObj[@"code"] isEqualToString:@"00010"]) {
                
                _token = responseObj[@"taskId"];
                
                [weakSelf addTimer];
                
            } else {
                if (_searchFailure) {
                    _searchFailure([self decodeCode:responseObj[@"code"]] );
                }
                
            }
        } else {
            if (_searchFailure) {
                _searchFailure(@"请求失败" );
            }
        }
        
        
    } failure:^(NSError *error) {
        MYLog(@"1.背调查询失败---%@",error);
        _isSearch = NO;
        if (_searchFailure) {
            _searchFailure(@"网络加载失败");
        }
    }];
}




#pragma mark  **2.轮循--状态**
- (void)startRequestData {
    //    MYLog(@"-----**2.轮循**");
    // MYLog(@"立木背调Log:2-数据获取中");
    // 1.请求总用时超过 超时时长，就停止请求
    if (_totalCircleTime >= _timeOut) {
        [self removeTimerWithTimeOut];
        return;
    }
    
    // 2.统计请求用时
    _totalCircleTime += _circleTime;
    
    // 3.开始请求
    __weak typeof(self) weakSelf = self;
    NSDictionary *dict = @{@"taskId":_token,
                           };
    _isSearch = YES;
    [YJHTTPTool post:_getStatusUrl params:dict success:^(id obj) {
        // NSLog(@"立木背调Log:查询中......%@",obj);
        MYLog(@"立木背调Log:查询中......%@",obj);
        
        BOOL obj4 =[obj isKindOfClass:[NSDictionary class]];
        if (!obj | !obj4) {
            MYLog(@"立木背调Log:查询失败");
            //错误类型 根据 code 决定
            [weakSelf removeTimer];
            if (_searchFailure) {
                _searchFailure(@"获取状态请求失败");
                _isSearch = NO;
            }
        }else {
            if (![obj[@"code"] isKindOfClass:[NSNull class]]) {
                if ([obj[@"code"] isEqualToString:@"00010"]) { // 1 查询成功
                    MYLog(@"立木背调Log:查询成功");
          
                    [weakSelf removeTimer];
                    _isSearch = NO;
                    [self queryResultWithTaskId:_token];
                    
                }
            } else {
                //obj[@"code"]为空的时候轮循
                _isSearch = YES;
            }
            
        }
    } failure:^(NSError *error) {
        MYLog(@"立木背调Log:查询失败:%@",error);
        //错误类型 根据 code 决定
        [weakSelf removeTimer];
        if (_searchFailure) {
            _isSearch = NO;
            _searchFailure(@"网络加载失败");
        }
    }];
    
    
    
}

#pragma mark  **3.查询结果**
- (void)queryResultWithTaskId:(NSString *)taskId {
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *dict = @{
                           @"UID":taskId,
                           };
    
    // 3.获取查询结果
    _isSearch = YES;
    [YJHTTPTool post:_getResultUrl params:dict success:^(id obj) {
        _isSearch = NO;
        MYLog(@"立木背调Log:结果......%@",obj);
        BOOL obj4 =[obj isKindOfClass:[NSDictionary class]];
        if (!obj | !obj4) {
            if (_searchFailure) {
                _searchFailure(@"获取结果请求失败");
            }
            return;
            
        } else {
            // 成功回调给外部处理
            if (weakSelf.searchSuccess) {
                weakSelf.searchSuccess(obj);
            }
        }
        
        
        
    } failure:^(NSError *error) {
        MYLog(@"立木背调Log:查询失败:%@",error);
        if (_searchFailure) {
            _isSearch = NO;
            _searchFailure(@"网络加载失败");
        }
    }];
   
    
}




#pragma mark BASE64

- (NSString *)base64Encode:(NSString *)string {
    NSData *nsdata = [string
                      dataUsingEncoding:NSUTF8StringEncoding];
    return [nsdata base64EncodedStringWithOptions:0];
}


#pragma mark   根据 code 返回输出状态

- (NSString *)decodeCode:(NSString *)code {
    if ([code isEqualToString:@"00010"]) {
        return @"处理成功";
    } else if([code isEqualToString:@"00001"]) {
        return @"参数传入错误";
    } else if([code isEqualToString:@"00002"]) {
        return @"用户未登录";
    } else if([code isEqualToString:@"00003"]) {
        return @"用户id为空";
    } else if([code isEqualToString:@"00004"]) {
        return @"账户余额不足";
    } else if([code isEqualToString:@"00005"]) {
        return @"上次查询正在进行";
    } else {
        return @"请求失败";
    }

    
}




/**
 获取当前时间毫秒
 
 @return 毫秒
 */
- (NSString *)getCurrentDateMS
{
    NSString *ms = [NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970]*1000];
    
    return ms;
}


#pragma mark -  签名算法
//签名算法如下：
//1. 对除sign以外的所有请求参数进行字典升序排列；
//2. 将以上排序后的参数表进行字符串连接，如key1=value1&key2=value2&key3=value3...keyNvalueN；
//3. 对该字符串进行SHA-1计算；
//4. 转换成16进制小写编码即获得签名串.
- (NSString *)sign:(NSDictionary*)ddic
{
    // NSMutableDictionary *restultDic = [NSMutableDictionary dictionaryWithDictionary:ddic];
    
    // 签名串
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:ddic];
    [paramsDic removeObjectForKey:@"sign"];
    
    // 1、对所有请求参数除sign外进行字典升序排列；
    //dic排序后的key 数组
    NSArray *sortedKeys = [[paramsDic allKeys] sortedArrayUsingSelector: @selector(compare:)];
    //遍历key，将dic的  value 按照顺序存放在value数组中
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *key in sortedKeys) {
        [valueArray addObject:[paramsDic objectForKey:key]];
    }
    
    //  2、将排序后的参数表进行字符串连接，如key1=value1&key2=value2&...keyN=valueN；
    //key1=value1 key2=value2 key3=value3 ；
    NSMutableArray *signArray = [NSMutableArray array];
    for (int i = 0; i < sortedKeys.count; i++) {
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@",sortedKeys[i],valueArray[i]];
        [signArray addObject:keyValueStr];
    }
    //key1=value1&key2=value2&key3=value3 ；
    NSString *sign = [signArray componentsJoinedByString:@"&"];
    
    // 3、 对该字符串进行SHA-1计算，得到签名，并转换成16进制小写编码，如： key1=value1&key2=value2&...keyN=valueNapi secret，得到签名串
    // MYLog(@"====&&&字符串%@",sign);
    
    NSMutableString *signString = [NSMutableString stringWithString:sign];
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *stringBytes = [signString dataUsingEncoding: NSUTF8StringEncoding];
    if (CC_SHA1([stringBytes bytes], (unsigned int)[stringBytes length], digest)) {
        NSMutableString *digestString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
        for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
            unsigned char aChar = digest[i];
            [digestString appendFormat:@"%02X", aChar];
        }
        NSString *value =[digestString lowercaseString];
        return value;
    }
    
    return nil;
}

+ (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        
        if ([elements count] <= 1) {
            return nil;
        }
        
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}




@end
