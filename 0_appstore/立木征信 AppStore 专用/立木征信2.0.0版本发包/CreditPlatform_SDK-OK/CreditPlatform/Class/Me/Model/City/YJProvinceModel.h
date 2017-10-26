//
//  YJProvinceModel.h
//  CreditPlatform
//
//  Created by yj on 16/7/20.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJProvinceModel : NSObject

@property (nonatomic, copy) NSString *province;
@property (nonatomic, strong) NSArray *cities;

+ (instancetype)provinceModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
