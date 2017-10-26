//
//  YJCarInsuranceOtherInfoCell.m
//  CreditPlatform
//
//  Created by yj on 2016/11/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCarInsuranceTaxInfoCell.h"
#import "YJCarInsuranceModel.h"

@interface YJCarInsuranceTaxInfoCell ()




@end
@implementation YJCarInsuranceTaxInfoCell

#pragma mark--创建UI

- (void)creatUI {
    
    _leftTitles = @[@"纳税人识别号",@"完税凭证号",@"滞纳金",@"当年应缴",@"往年补缴",@"合计税项"];
    _leftLbWidth = 95;

    
    _rightLbWidth = SCREEN_WIDTH - kMargin_15 * 3 - _leftLbWidth;
    
    [self addSubViewToCell];
    
    
}


#pragma mark--车船税
- (void)setVehicleVesselTax:(YJCarInsuranceVehicleVesselTax *)vehicleVesselTax {
    _vehicleVesselTax = vehicleVesselTax;
    [self creatUI];
    
     [self loadTaxInfo];
    
    [self layoutSubview];
}

#pragma mark--加载数据

/**
 车船税信息
 */
- (void)loadTaxInfo {
    YJCarInsuranceVehicleVesselTax *vehicleVesselTax = self.vehicleVesselTax;
    
    // 纳税人识别号
    if (![vehicleVesselTax.taxpayerNo isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[0];
        lb.text = vehicleVesselTax.taxpayerNo;
    }
    
    // 完税凭证号
    if (![vehicleVesselTax.vouchNo  isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[1];
        lb.text = vehicleVesselTax.vouchNo;
    }
    // 滞纳金
    if (![vehicleVesselTax.lateAmt isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[2];
        lb.text = vehicleVesselTax.lateAmt;
    }
    // 当年应缴
    if (![vehicleVesselTax.payableAmt isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[3];
        lb.text = vehicleVesselTax.payableAmt;
    }
    // 往年应缴
    if (![vehicleVesselTax.supplementAmt isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[4];
        lb.text = vehicleVesselTax.supplementAmt;
    }
    // 合计税项
    if (![vehicleVesselTax.taxSum  isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[5];
        lb.text = vehicleVesselTax.taxSum ;
    }
}



@end
