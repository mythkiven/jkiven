//
//  LMZXAnalysisWebModel.m
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/3/22.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXAnalysisWebModel.h"


@implementation LMZXAnalysisWebModel

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]) {
        self.type = dic[@"type"];
        self.bizType = dic[@"bizType"];
        self.category = dic[@"category"];
        self.status = dic[@"status"];
        
        LMZXAnalysisWebItemsModel *items = [[LMZXAnalysisWebItemsModel alloc]init];
        
        
        items.logo = dic[@"items"][@"logo"];
        items.loginType = dic[@"items"][@"loginType"];
        items.loginUrl = dic[@"items"][@"loginUrl"];
        
        NSArray *arr = dic[@"items"][@"loginInputUrl"];
        if (arr.count==1) {
            items.loginInputUrl =[arr[0]  componentsSeparatedByString:@","];
        }else{
            items.loginInputUrl = arr;
        }
        
        
        items.successUrl = dic[@"items"][@"successUrl"];
        items.jsUrl = dic[@"items"][@"jsUrl"];
        items.userAgent = dic[@"items"][@"userAgent"];
        items.isWebLogin = dic[@"items"][@"isWebLogin"];
        
        self.items =  items;
    }
    
    return self;
}
@end

@implementation LMZXAnalysisWebItemsModel

@end
