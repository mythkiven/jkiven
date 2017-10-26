//
//  YJCarInsuranceOtherInfoCell.h
//  CreditPlatform
//
//  Created by yj on 2016/11/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCarInsuranceBaseInfoCell.h"



@class YJCarInsuranceVehicleVesselTax;
@interface YJCarInsuranceTaxInfoCell : YJCarInsuranceBaseInfoCell

// 代收车船税
@property (nonatomic, strong) YJCarInsuranceVehicleVesselTax *vehicleVesselTax;



@end
