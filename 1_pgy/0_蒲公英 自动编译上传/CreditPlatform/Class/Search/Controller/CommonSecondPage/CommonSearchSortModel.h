//
//  CommonSearchSortModel.h
//  CreditPlatform
//
//  Created by gyjrong on 16/11/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YJCityModel.h"

@interface CommonSearchSortModel : NSObject

/**城市信息*/
@property (nonatomic, assign,readwrite) YJCityInfoModel *selectCityInfoModel;

@property (assign,nonatomic) CGFloat      titleWidth;
/**类型*/
@property (nonatomic, assign,readwrite) SearchItemType  searchItemType;

/** 公积金社保专用：根据城市，返回对应tableview 数据源 */
-(NSMutableArray*)factoryArr:(NSMutableArray*)marr city:(NSString *)city;

/** 车险  index=2 保单  =1 账号*/
-(NSMutableArray*)factoryArrWithIndex:(NSInteger)index;


@end
