//
//  YJCitySelectedVC.h
//  CreditPlatform
//
//  Created by yj on 2016/11/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
// 选择cell
typedef void(^SelectedCityBlock)(id);

@interface YJCitySelectedVC : UIViewController
/**通用*/
@property (nonatomic, assign) SearchItemType  searchItemType;
@property (nonatomic, strong) YJSearchConditionModel *searchConditionModel;
@property(strong,nonatomic) SelectedCityBlock selectedOneCity;
@property (strong,nonatomic) NSString      *recodeType;

//选择城市所需
@property (strong,nonatomic) NSMutableArray *cityData;
// 选中的城市
@property (strong,nonatomic) NSString *cityString;



@end
