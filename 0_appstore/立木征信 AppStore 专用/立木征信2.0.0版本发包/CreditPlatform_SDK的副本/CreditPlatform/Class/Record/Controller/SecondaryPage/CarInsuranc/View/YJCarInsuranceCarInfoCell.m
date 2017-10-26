//
//  YJCarInsuranceOtherInfoCell.m
//  CreditPlatform
//
//  Created by yj on 2016/11/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCarInsuranceCarInfoCell.h"
#import "YJCarInsuranceModel.h"

@interface YJCarInsuranceCarInfoCell ()




@end
@implementation YJCarInsuranceCarInfoCell




#pragma mark--创建UI

- (void)creatUI {
    

    _leftTitles = @[@"车牌号",@"车主",@"使用性质",@"车辆类型",@"行驶区域",@"初次登记日期",@"新车购置价(元)",@"厂牌型号",@"发动机号",@"车架号",@"排量",@"核定座位号"];
    _leftLbWidth = 105;

    
    
    _rightLbWidth = SCREEN_WIDTH - kMargin_15 * 3 - _leftLbWidth;
    
    [self addSubViewToCell];
    
    
}


#pragma mark--车辆信息
- (void)setVehicleInfo:(YJCarInsuranceVehicleInfo *)vehicleInfo {
    _vehicleInfo = vehicleInfo;
    [self creatUI];
    
   [self loadCarInfo];
    
    [self layoutSubview];
}


/**
 车辆信息
 */
- (void)loadCarInfo {
    
    YJCarInsuranceVehicleInfo *vehicleInfo = self.vehicleInfo;
    
    // 车牌号
    if (![vehicleInfo.plateNo isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[0];
        lb.text = vehicleInfo.plateNo;
    }
    // 车主
    if (![vehicleInfo.owner  isEqualToString:@""] ) {
        UILabel *lb = _rightLbArray[1];
        lb.text = vehicleInfo.owner;
    }
    // 使用性质
    if (![vehicleInfo.useCharacter isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[2];
        lb.text = vehicleInfo.useCharacter;
    }
    // 车辆类型
    if (![vehicleInfo.vehicleType isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[3];
        lb.text = vehicleInfo.vehicleType;
    }
    // 行驶区域
    if (![vehicleInfo.travelArea isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[4];
        lb.text = vehicleInfo.travelArea;
    }
    // 初次登记日期
    if (![vehicleInfo.registerDate  isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[5];
        lb.text = vehicleInfo.registerDate ;
    }
    // 新车购置价
    if (![vehicleInfo.newCarPrice  isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[6];
        lb.text = vehicleInfo.newCarPrice ;
    }
    // 厂牌型号
    if (![vehicleInfo.model isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[7];
        lb.text = vehicleInfo.model;
    }
    // 发动机号
    if (![vehicleInfo.engineNo isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[8];
        lb.text = vehicleInfo.engineNo;
    }
    // 车架号
    if (![vehicleInfo.vin  isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[9];
        lb.text = vehicleInfo.vin ;
    }
    // 排量
    if (![vehicleInfo.displacement isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[10];
        lb.text = vehicleInfo.displacement;
    }
    // 核定座位数
    if (![vehicleInfo.approvedCapacity isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[11];
        lb.text = vehicleInfo.approvedCapacity;
    }
}




@end
