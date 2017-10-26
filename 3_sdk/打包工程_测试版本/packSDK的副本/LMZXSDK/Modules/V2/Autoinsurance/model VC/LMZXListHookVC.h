//
//  CitySelectVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMZXDemoAPI.h"

//#import "LMZXBaseViewController.h"

 
// 通用列表展示VC

//  本VC 作为数据处理和中转的 VC


/** 选中Cell*/
typedef void(^SelectedCityBlock)(id);


@interface LMZXListHookVC : UITableViewController

/**首页传入 type*/
@property (nonatomic, assign,readwrite) LMZXSearchItemType  searchItemType;



/**选中cell*/
@property(strong,nonatomic) SelectedCityBlock selectedOneCity;


// 数据源 数据源 
@property (strong,nonatomic) NSMutableArray *listData;

// 如果有,就使用
@property (strong,nonatomic) NSString      *url;

@end




















