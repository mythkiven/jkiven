//
//  LMZXLoadingFunctionTypeModel.m
//  LMZX_SDK_Develop
//
//  Created by gyjrong on 17/5/17.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import "LMZXWebLoadingType.h"


@implementation LMZXWebLoadingType
-(instancetype)init{
    if (self =[super init]) {
        self.mail_sina = @"mail-sina";
        self.mail_163 = @"mail-163";
        self.mail_126 = @"mail-126";
        self.mail_139 = @"mail-139";
        self.mail_qq = @"mail-qq";
        self.ctrip = @"ctrip";
        self.maimai = @"maimai";
        self.linkedin = @"linkedin";
        self.taobao = @"taobao";
        self.diditaxi = @"diditaxi";
        self.jd = @"jd";
    }
    return self;
}

-(BOOL)saveLastWebLoginInfo:(id)obj {
    
    BOOL obj1 =[obj isKindOfClass:[NSNull class]];
    BOOL obj2 =[obj isKindOfClass:[NSString class]];
    
    if (obj1 | obj2) {
        return NO;
    }else if ([obj isKindOfClass:[NSArray class]] ) {
        NSArray *arr = (NSArray*)obj;
        NSMutableDictionary *webInfoDic = [NSMutableDictionary new];
        if(arr.count>=1){
            for(NSDictionary *dd in arr){
                if ([dd isKindOfClass:[NSDictionary class]] && arr && arr.count) {
                    LMZXWebLoginModel *model  = [[LMZXWebLoginModel alloc]initWithDic:dd];
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
                    [webInfoDic setObject:data forKey:model.type];
                }
            }
            
            NSUserDefaults *webDefatluts = [NSUserDefaults standardUserDefaults];
            NSDictionary *webDic = [webDefatluts objectForKey:LMZX_LAST_WEBLOGIN_INFO];
            if (webDic) {
                [self removeLastWebLoginInfo];
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:webInfoDic forKey:LMZX_LAST_WEBLOGIN_INFO];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return  YES;
        }else{
            return NO;
        }
    }
    
    return NO;
}

-(LMZXWebLoginModel *)getLastWebLoginInfo:(NSString*)type{
    NSUserDefaults *webDefatluts = [NSUserDefaults standardUserDefaults];
    NSDictionary *webDic = [webDefatluts objectForKey:LMZX_LAST_WEBLOGIN_INFO];
    
    if (webDic[type]) {
        LMZXWebLoginModel* data = [NSKeyedUnarchiver unarchiveObjectWithData:webDic[type]];
        
        return data;
    }
    return nil;
    
}

-(void)removeLastWebLoginInfo{
    NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
    [userDefatluts removeObjectForKey:LMZX_LAST_WEBLOGIN_INFO];
    [userDefatluts synchronize];
}

@end



@implementation LMZXWebLoginModel

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.bizType forKey:@"bizType"];
    [aCoder encodeObject:self.category forKey:@"category"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.items forKey:@"items"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.bizType = [aDecoder decodeObjectForKey:@"bizType"];
        self.category = [aDecoder decodeObjectForKey:@"category"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.items = [aDecoder decodeObjectForKey:@"items"];
    }
    return self;
}

-(instancetype)initWithDic:(NSDictionary*)dic{
    
    if (self = [super init]) {
        
        self.type = dic[@"type"];
        self.bizType = dic[@"bizType"];
        self.category = dic[@"category"];
        self.status = dic[@"status"];
        
        LMZXWebLoginItemsModel *items = [[LMZXWebLoginItemsModel alloc]init];
        
        items.logo = dic[@"items"][@"logo"];
        items.loginType = dic[@"items"][@"loginType"];
        items.loginUrl = dic[@"items"][@"loginUrl"];
        
        NSArray *arr = dic[@"items"][@"loginInputUrl"];
        if (arr.count==1) {
            NSArray *aaa = [arr[0]  componentsSeparatedByString:@" "];
            if (aaa.count==2) {// 处理掉空格
                items.loginInputUrl =@[aaa[0]];
            }else{
                items.loginInputUrl =[arr[0]  componentsSeparatedByString:@","];
            }
            
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

@implementation LMZXWebLoginItemsModel
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.logo forKey:@"logo"];
    [aCoder encodeObject:self.loginType forKey:@"loginType"];
    [aCoder encodeObject:self.loginUrl forKey:@"loginUrl"];
    [aCoder encodeObject:self.loginInputUrl forKey:@"loginInputUrl"];
    [aCoder encodeObject:self.successUrl forKey:@"successUrl"];
    [aCoder encodeObject:self.jsUrl forKey:@"jsUrl"];
    [aCoder encodeObject:self.userAgent forKey:@"userAgent"];
    [aCoder encodeObject:self.isWebLogin forKey:@"isWebLogin"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.logo = [aDecoder decodeObjectForKey:@"logo"];
        self.loginType = [aDecoder decodeObjectForKey:@"loginType"];
        self.loginUrl = [aDecoder decodeObjectForKey:@"loginUrl"];
        self.loginInputUrl = [aDecoder decodeObjectForKey:@"loginInputUrl"];
        self.successUrl = [aDecoder decodeObjectForKey:@"successUrl"];
        self.jsUrl = [aDecoder decodeObjectForKey:@"jsUrl"];
        self.userAgent = [aDecoder decodeObjectForKey:@"userAgent"];
        self.isWebLogin = [aDecoder decodeObjectForKey:@"isWebLogin"];
    }
    return self;
}
@end

