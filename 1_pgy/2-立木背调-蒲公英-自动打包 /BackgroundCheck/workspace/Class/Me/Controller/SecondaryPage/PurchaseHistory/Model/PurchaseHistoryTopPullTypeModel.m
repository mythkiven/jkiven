//
//  PurchaseHistoryTopPullTypeModel.m
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "PurchaseHistoryTopPullTypeModel.h"

@implementation PurchaseHistoryTopPullTypeModel


+(NSMutableArray*)creatWith:(PurchaseHistoryTopPullTypeTotalList*)arr{
    if (!arr.list) {
        return nil;
    }
    NSMutableArray *arrL = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arrR = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arrA = [NSMutableArray arrayWithCapacity:0];
    
    if (arr.list.count>=1) {
        for (int i=0; i<arr.list.count; i++) {
            if (i%2==0) {
                [arrL addObject:arr.list[i]];
            }else{
                [arrR addObject:arr.list[i]];
            }
        }
        int j =(int)arr.list.count/2;
        NSInteger k =arr.list.count%2;
        if (k==1) {
            j+=1;
        }
        
        for (int i=0; i<=j-1; i++) {//4-1
            PurchaseHistoryTopPullTypeserViceNameType *typeL,*typeR;
            typeL = [[PurchaseHistoryTopPullTypeserViceNameType alloc]init];
            typeR = [[PurchaseHistoryTopPullTypeserViceNameType alloc]init];
            if (arrL.count-1>=i) {//3-1
                typeL = arrL[i] ;
            }
            if (arrR.count-1>=i) {//4-1
               typeR = arrR[i] ;
            }
            
            PurchaseHistoryTopPullTypeModel *model = [[PurchaseHistoryTopPullTypeModel alloc]init];
            if (typeR.serviceName.length) {
                model.tagR = typeR.apiType;
                model.nameRight = typeR.serviceName;
            }
            if (typeL.serviceName.length) {
                model.tagL = typeL.apiType;
                model.nameLeft = typeL.serviceName;
            }
            model.selectedL = NO;
            model.selectedR = NO;
            [arrA addObject:model];
        }
    }
    //插入全部
    PurchaseHistoryTopPullTypeModel *model = [[PurchaseHistoryTopPullTypeModel alloc]init];
    model.nameT = @"全部";
    model.tagT = @"全部";//直接传给后台的
    model.selectedT = NO;
    [arrA insertObject:model atIndex:0];
    return arrA;
}
@end



@implementation PurchaseHistoryTopPullTypeserViceNameType

@end


@implementation PurchaseHistoryTopPullTypeTotalList

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":[PurchaseHistoryTopPullTypeserViceNameType class]};
}

@end