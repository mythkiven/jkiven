//
//  CitySelectVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTypeBaseVC.h"

// 通用列表展示VC

//  本VC 作为数据处理和中转的 VC


/** 选中Cell*/
typedef void(^SelectedCityBlock)(id);


@interface ListHookVC : JTypeBaseVC


/**选中cell*/
@property(strong,nonatomic) SelectedCityBlock selectedOneCity;


// 数据源 数据源 
@property (strong,nonatomic) NSMutableArray *listData;


@property (strong,nonatomic) NSString      *loginType;

@end

















