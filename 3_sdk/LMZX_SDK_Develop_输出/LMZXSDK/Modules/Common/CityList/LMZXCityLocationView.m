//
//  LMZXCityLocationView.m
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/2/22.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXCityLocationView.h"
#import <CoreLocation/CoreLocation.h>
#import "LMZXSDK.h"
#define iOS8Later_lmzx ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

typedef enum : NSUInteger {
    LocationResultSuccess,// 定位成功
    LocationResultServicesEnabled, // 定位服务未打开
    LocationResultFailure,// 定位失败
    LocationResultUnsupportedArea// 不支持的地区
} LocationResult;


@interface LMZXCityLocationView ()<CLLocationManagerDelegate>
{
    CLLocationManager *_locManager;//定位管理类
}
/**
 定位管理类
 */
//@property (nonatomic, strong) CLLocationManager *locManager;

/**
 反地理编码
 */
@property (nonatomic, strong) CLGeocoder *reverseGeo;

@property (strong, nonatomic)  UIView *contentView;

/**
 定位成功✅
 */
@property (strong, nonatomic)  UIImageView *selectedImgView;

/**
 所在城市
 */
@property (nonatomic, strong) UILabel *titleLb;

@property (strong, nonatomic)  UIView *bottomLine;


@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;


/**
 定位成功显示城市，并可点击
 */
@property (nonatomic, strong) UIButton *cityBtn;


@property (nonatomic, assign) LocationResult locationResult;


@end

@implementation LMZXCityLocationView

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        _titleLb.text = @"所在城市";
        _titleLb.font = [UIFont systemFontOfSize:13];
    }
    return _titleLb;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    }
    return _bottomLine;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

/**
 菊花
 */
- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        _activityIndicatorView.hidesWhenStopped = YES;
        
        UILabel *lb = [[UILabel alloc] init];
        lb.text = @"定位中...";
        lb.font = [UIFont systemFontOfSize:15];
        lb.frame = CGRectMake(45, 0, 100, 45);
        
        [_activityIndicatorView addSubview:lb];
        
    }
    return _activityIndicatorView;
}
//城市
- (UIButton *)cityBtn {
    if (!_cityBtn) {
        _cityBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _cityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _cityBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 16.5, 0, 0);
        _cityBtn.backgroundColor = [UIColor clearColor];
        
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_cityBtn addTarget:self action:@selector(cityBtnClcik) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _cityBtn;
}

+ (instancetype)cityLocationView {
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        
        UIColor *pageColor = [LMZXSDK shared].lmzxPageBackgroundColor;
        if (pageColor) {
            self.backgroundColor = pageColor;
        }
//        self.selectedImgView.hidden = YES;
        [self addSubview:self.titleLb];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.activityIndicatorView];
        
        // 显示定位成功城市名字
        [self.contentView addSubview:self.cityBtn];
        
        [self addSubview:self.bottomLine];
        
        self.cityBtn.hidden = YES;
        
        [self locationAuthorization];
        
    }
    return self;
}




- (void)dealloc {
//    MYLog(@"-------%@销毁了",self);
}




/**
 定位授权
 */
- (void)locationAuthorization {
      _locManager = [[CLLocationManager alloc] init];
      _locManager.delegate = self;
//      if (iOS8Later_lmzx) {
//          [_locManager requestWhenInUseAuthorization];
//
//      }
    
      _locManager.desiredAccuracy = kCLLocationAccuracyBest;
      _locManager.distanceFilter = kCLDistanceFilterNone;
}



#pragma mark-- 点击按钮
- (void)cityBtnClcik {
    
    switch (self.locationResult) {
        case LocationResultSuccess:
            if (self.selectedCurrentCity) {
                self.selectedCurrentCity(self.cityModel);
                
                [self setupSelectedArea];
            }
            break;
        case LocationResultServicesEnabled:
            if (iOS8Later_lmzx) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                if (self.locationSettingBock) {
                    self.locationSettingBock();
                }
            }
            break;
        case LocationResultFailure:
            [self startLocation];
            
            break;
        case LocationResultUnsupportedArea:
            break;
        default:
        break;    }
    
    
    
    
    
}


// 2.定位成功
// 3.定位失败
// 4.定位城市不在列表

/**
 *  1.开启定位
 */
- (void)startLocation {
    self.cityBtn.hidden = YES;

    [self.activityIndicatorView startAnimating];

    if ([CLLocationManager locationServicesEnabled]) { // 系统定位
        
        if (iOS8Later_lmzx) {
            if ([ CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse ) { // 当使用的时候定位开启
                
                [_locManager startUpdatingLocation];
                
            } else {
                // 检测网络或者打开定位服务
                [self setupCityBtnTitle:@"定位失败，请开启定位" locationResult:(LocationResultServicesEnabled)];
            }
        } else {
            if ([ CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized ) {
                
                [_locManager startUpdatingLocation];
                
            } else {
                // 检测网络或者打开定位服务
                [self setupCityBtnTitle:@"定位失败，请开启定位" locationResult:(LocationResultServicesEnabled)];
            }
        }
        
        
        
        
        
    } else {
        
        // 检测网络或者打开定位服务
        [self setupCityBtnTitle:@"定位失败，请开启定位" locationResult:(LocationResultServicesEnabled)];

       
        
        
    }
}




- (void)setCityModel:(LMZXCityModel *)cityModel {
    _cityModel = cityModel;
    

}
/**
 设置选中了该地区
 */
- (void)setupSelectedArea {
    NSMutableAttributedString *attributedStr =
    [[NSMutableAttributedString alloc] initWithString:self.cityBtn.titleLabel.text attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:48/255.0 green:113/255.0 blue:242/255.0 alpha:1], NSFontAttributeName : [UIFont systemFontOfSize:15]}];
    
    [self.cityBtn setAttributedTitle:attributedStr forState:(UIControlStateNormal)];
}
/**
 设置暂时不支持该地区
 */
- (void)setupUnsupportedArea {
    [self setupCityBtnTitle:[NSString stringWithFormat:@"暂时不支持：%@",self.currentCityName] locationResult:(LocationResultUnsupportedArea)];
}


#pragma mark- 定位服务

// 反地理编码
- (CLGeocoder *)reverseGeo {
    if (!_reverseGeo) {
        _reverseGeo = [[CLGeocoder alloc] init];
    }
    return _reverseGeo;
}


#pragma mark - -CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = [locations firstObject];
    
    __weak typeof(self) weakSelf = self;
    [self.reverseGeo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error && placemarks.count > 0) {
            
            CLPlacemark *placemark = [placemarks firstObject];


            dispatch_async(dispatch_get_main_queue(), ^{
               
                
                [weakSelf setupCityBtnTitle:placemark.addressDictionary[@"City"] locationResult:(LocationResultSuccess)];
                
//                MYLog(@"====================华丽的测试线");
                if (weakSelf.locationSuccessBock) {
                    weakSelf.locationSuccessBock();
                }


                
            });
            
           
            
            
//            MYLog(@"字典addressDictionary：%@",placemark.addressDictionary);
            
            
            
        } else {
//            MYLog(@"编码失败%@",error.localizedDescription);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf setupCityBtnTitle:@"定位失败，请点击重试" locationResult:(LocationResultFailure)];
            });
            
        }
        
    }];
    
    [manager stopUpdatingLocation];
}

#pragma mark-- 设置样式
- (void)setupCityBtnTitle:(NSString *)title locationResult:(LocationResult)locationResult {
    
    
    self.locationResult = locationResult;
    self.cityBtn.hidden = NO;
    
    // 停止菊花
    [self.activityIndicatorView stopAnimating];
    

    
    // 设置字体
    NSMutableAttributedString *attributedStr =
    [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:15]}];
    
    int len = (int)title.length;
    UIColor *blueColor = [self matchingStringColor];
//    [UIColor colorWithRed:48/255.0 green:113/255.0 blue:242/255.0 alpha:1]
    switch (locationResult) {
        case LocationResultSuccess:
            self.currentCityName = title;

            
            [self.cityBtn setAttributedTitle:attributedStr forState:UIControlStateNormal];
            // 显示✅
            self.selectedImgView.hidden = NO;
            break;
            
        case  LocationResultUnsupportedArea:
        {
           
            [attributedStr addAttributes:@{NSForegroundColorAttributeName : blueColor} range:NSMakeRange(6, len-6)];
            [self.cityBtn setAttributedTitle:attributedStr forState:UIControlStateNormal];
            
            self.selectedImgView.hidden = YES;
     
            break;
        }
        case LocationResultFailure :
        {
            
            [attributedStr addAttributes:@{NSForegroundColorAttributeName : blueColor} range:NSMakeRange(6, len-6)];
            [self.cityBtn setAttributedTitle:attributedStr forState:UIControlStateNormal];
            
            self.selectedImgView.hidden = YES;
            
            break;
        }
        case LocationResultServicesEnabled:
        {
            
            [attributedStr addAttributes:@{NSForegroundColorAttributeName : blueColor} range:NSMakeRange(6, len-6)];
            [self.cityBtn setAttributedTitle:attributedStr forState:UIControlStateNormal];
            
            self.selectedImgView.hidden = YES;
            
            break;
        }
            
        default:
            break;
    }
    
    
    
    
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLb.frame = CGRectMake(15, 0, self.frame.size.width-15, 28);
    self.contentView.frame = CGRectMake(0, CGRectGetMaxY(_titleLb.frame), self.frame.size.width, self.frame.size.height-28);
    self.activityIndicatorView.frame = CGRectMake(15, 0, 45, 45);
    self.cityBtn.frame = self.contentView.bounds;

    self.bottomLine.frame = CGRectMake(0,self.frame.size.height-0.5, self.frame.size.width, 0.5);
    
//    self.selectedImgView.frame
    
}

- (UIColor *)matchingStringColor {
    if ([LMZXSDK shared].lmzxProtocolTextColor) {
        return [LMZXSDK shared].lmzxProtocolTextColor;
    }
    return [UIColor colorWithRed:48/255.0 green:113/255.0 blue:242/255.0 alpha:1];
}

@end
