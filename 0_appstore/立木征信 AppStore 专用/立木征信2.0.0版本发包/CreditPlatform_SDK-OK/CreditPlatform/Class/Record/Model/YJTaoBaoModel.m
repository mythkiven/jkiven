//
//  YJTaoBaoModel.m
//  CreditPlatform
//
//  Created by yj on 16/10/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTaoBaoModel.h"

@implementation YJTaoBaoModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"addresses" : [YJTaoBaoAddresses class],
             @"orderDetails" : [YJTaoBaoOrderDetails class]};
}

- (void)setBasicInfo:(NSDictionary *)basicInfo {
    _basicInfo = basicInfo;
    
    _taoBaoBasicInfo = [YJTaoBaoBasicInfo mj_objectWithKeyValues:basicInfo];
    
}

- (void)setAlipayInfo:(NSDictionary *)alipayInfo {
    _alipayInfo = alipayInfo;
    
    _taoBaoAlipayInfo = [YJTaoBaoAlipayInfo mj_objectWithKeyValues:alipayInfo];
}

@end


@implementation YJTaoBaoBasicInfo



@end

@implementation YJTaoBaoAlipayInfo



@end
@implementation YJTaoBaoAddresses

- (void)setAddress:(NSString *)address {
    if ([address hasPrefix:@" "]) {
        _address = [address substringFromIndex:1];
    } else {
        _address = address;
    }
}


@end


@implementation YJTaoBaoOrderDetails

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"items" : [yjTaoBaoOrderItem class]};
}

- (void)setLogisticsInfo:(NSDictionary *)logisticsInfo {
    _logisticsInfo = logisticsInfo;
    
    _taoBaoLogisticsInfo = [YJTaoBaoLogisticsInfo mj_objectWithKeyValues:logisticsInfo];
}

@end

@implementation yjTaoBaoOrderItem

@end

@implementation YJTaoBaoLogisticsInfo



@end


@implementation YJTaobaoStatisticsModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"taobaoAddrStatistics" : [YJTaobaoAddrStatistic class],
             @"taobaoConsuStatistics" : [YJTaobaoConsuStatistic class]};
}

@end

@implementation YJTaobaoAddrStatistic


@end
@implementation YJTaobaoConsuStatistic

@end

