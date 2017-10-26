//
//  CitySelectModel.m
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/7/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXListHookModel.h"

@implementation LMZXListHookModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end

@implementation LMZXCompanyCarInsurancModel

@end

@implementation LMZXEBankListModel

@end


@implementation LMZXCreditListModel
//
//+ (NSDictionary *)mj_objectClassInArray {
//    return @{
//             @"list" : [EBankListModel class],};
//}
@end

@implementation LMZXSourceALLDataList


/** 车险*/
-(instancetype)initWithCarInsurancDic:(NSDictionary*)dic{
    if (self =[super init]) {
        if (dic) {
            self.bizType = dic[@"bizType"];
            self.status = dic[@"status"];
            NSArray *arr = dic[@"items"];
            NSMutableArray *mdata = [NSMutableArray arrayWithCapacity:0];
            if (arr.count) {
                for (NSDictionary *dd in arr) {
                    LMZXCompanyCarInsurancModel *model = [[LMZXCompanyCarInsurancModel alloc] init];
                    model.name = dd[@"name"];
                    model.code = dd[@"code"];
                    model.logo = dd[@"logo"];
                    
                    
                    LMZXListHookModel *m = [[LMZXListHookModel alloc] init];
                    m.companyCarInsuranc = model;
                    m.selected = NO;
                    
                    
                    [mdata addObject:m];
                }
            }
            self.items = mdata;
        }
    }
    return self;
}




/** 网银*/
-(instancetype)initWithEBankDic:(NSDictionary*)dic{
    if (self =[super init]) {
        if (dic) {
            self.bizType = dic[@"bizType"];
            self.status = dic[@"status"];
            NSArray *arr = dic[@"items"];
            NSMutableArray *mdata = [NSMutableArray arrayWithCapacity:0];
            if (arr.count) {
                for (NSDictionary *dd in arr) {
                    LMZXEBankListModel *model = [[LMZXEBankListModel alloc] init];
                    model.name = dd[@"name"];
                    model.code = dd[@"code"];
                    model.logo = dd[@"logo"];
                    
                    
                    LMZXListHookModel *m = [[LMZXListHookModel alloc] init];
                    m.eBankListModel = model;
                    m.selected = NO;
                    
                    
                    [mdata addObject:m];
                    
                }
            }
            self.items = [mdata copy];
        }
    }
    return self;
}

-(instancetype)initWithCreditListDic:(NSDictionary*)dic{
    if (self =[super init]) {
        if (dic) {
            self.bizType = dic[@"bizType"];
            self.status = dic[@"status"];
            NSArray *arr = dic[@"items"];
            NSMutableArray *mdata = [NSMutableArray arrayWithCapacity:0];
            if (arr.count) {
                for (NSDictionary *dd in arr) {
                    LMZXCreditListModel *model = [[LMZXCreditListModel alloc] init];
                    model.name = dd[@"name"];
                    model.code = dd[@"code"];
                    model.logo = dd[@"logo"];
                    
                    
                    LMZXListHookModel *m = [[LMZXListHookModel alloc] init];
                    m.creditList = model;
                    m.selected = NO;
                    
                    
                    [mdata addObject:m];
                    
                }
            }
            self.items = [mdata copy];
        }
    }
    return self;
}
@end


