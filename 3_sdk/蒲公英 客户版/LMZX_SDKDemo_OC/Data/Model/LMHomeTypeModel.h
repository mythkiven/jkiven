//
//  LMHomeTypeModel.h
//  LMZX_SDKDemo_OC
//
//  Created by yj on 2017/3/29.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LMHomeTypefunction : NSObject

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)homeTypefunctionWithDict:(NSDictionary *)dict;


@end


@interface LMHomeTypeModel : NSObject

@property (nonatomic, copy) NSString *groupTitle;

@property (nonatomic, copy) NSString *titleColor;

@property (nonatomic, strong) NSArray *functions;

@property (nonatomic, strong) NSArray *functionModels;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)homeTypeModelWithDict:(NSDictionary *)dict ;

@end
