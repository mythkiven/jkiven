//
//  JDReportModel.m
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/8/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "JDReportModel.h"

@implementation JDReportModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"bankInfo" : [JDbankInfoModel class],
             @"addressInfo" : [JDaddressInfoModel class],
             @"orderDetail" : [JDorderDetailModel class],};
}
-(void)setBasicInfo:(NSDictionary *)basicInfo{
    _basicInfo = basicInfo;
    _basicInfoS = [JDbasicInfoModel mj_objectWithKeyValues:basicInfo];
    
}
-(void)setBaiTiaoInfo:(NSDictionary *)baiTiaoInfo {
    _baiTiaoInfo = baiTiaoInfo;
    _baiTiaoInfoS = [JDbaiTiaoInfoModel mj_objectWithKeyValues:baiTiaoInfo];
    
}
//-(void)setJdorderStatisticsModel:(JDorderStatisticsModel *)jdorderStatisticsModel{
//    
//}
//-(void)setJdorderCostBarChartModel:(JDorderCostBarChartModel *)jdorderCostBarChartModel{
//    
//}
@end

@implementation JDbasicInfoModel

@end
@implementation JDbankInfoModel

@end
@implementation JDbaiTiaoInfoModel

@end
@implementation JDaddressInfoModel

@end
@implementation JDorderDetailModel

@end


@implementation  JDorderStatisticsModel


@end


@implementation  JDorderCostBarChartModel



@end



