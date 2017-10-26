//
//  RechargeNavTypeModel.m
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/9/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "RechargeNavTypeModel.h"

@implementation RechargeNavTypeModel


+(NSMutableArray*)creatWith:(RechargeNavTypeModelTotalList*)arr{
    NSMutableArray *arrA = [NSMutableArray arrayWithCapacity:0];
    
    RechargeNavTypeModel *model = [[RechargeNavTypeModel alloc]init];
    model.canTouch =YES;
    model.showIcon =NO;
    model.Tag =0;
    model.Name = @"全部";
    model.tagL = @"NULL";
    [arrA addObject:model];
    
    for (int i=1; i<arr.list.count+1; i++) {
        RechargeNavTypeModelNameType*m = arr.list[i-1];
        RechargeNavTypeModel *model = [[RechargeNavTypeModel alloc]init];
        
        model.canTouch =YES;
        model.showIcon =NO;
        model.Tag =i;
        model.Name = m.statusName;
        model.tagL = m.statusCode;
       
        
        [arrA addObject:model];
    }
    
    return arrA;
}
@end




@implementation RechargeNavTypeModelNameType

@end


@implementation RechargeNavTypeModelTotalList

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":[RechargeNavTypeModelNameType class]};
}

@end