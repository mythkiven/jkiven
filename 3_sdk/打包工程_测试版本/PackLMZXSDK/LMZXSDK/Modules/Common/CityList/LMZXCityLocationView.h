//
//  LMZXCityLocationView.h
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/2/22.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LMZXCityModel;

typedef void(^SelectedCurrentCity)(LMZXCityModel*);

typedef void(^LocationSuccessBock)();

typedef void(^LocationSettingBock)();

@interface LMZXCityLocationView : UIView


@property (nonatomic, strong) LMZXCityModel *cityModel;

/**
 当前城市名字
 */
@property (nonatomic, copy) NSString *currentCityName;


@property (nonatomic, copy) LocationSuccessBock locationSuccessBock;

@property (nonatomic, copy) SelectedCurrentCity selectedCurrentCity;

@property (nonatomic, copy) LocationSettingBock locationSettingBock;

+ (instancetype)cityLocationView ;


/**
 开始定位
 */
- (void)startLocation ;
    
/**
 设置选中了该地区
 */
- (void)setupSelectedArea;

/**
 设置暂时不支持该地区
 */
- (void)setupUnsupportedArea;

@end
