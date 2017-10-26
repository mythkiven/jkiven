//
//  LMZXAnalysisWebModel.h
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/3/22.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LMZXAnalysisWebItemsModel;
@interface LMZXAnalysisWebModel : NSObject

@property (copy,nonatomic) NSString      *type;
@property (copy,nonatomic) NSString      *bizType;
@property (copy,nonatomic) NSString      *category;
@property (copy,nonatomic) NSString      *status;
@property (strong,nonatomic) LMZXAnalysisWebItemsModel  *items;

-(instancetype)initWithDic:(NSDictionary*)dic;

@end

@interface LMZXAnalysisWebItemsModel : NSObject
@property (copy,nonatomic) NSString      *logo;
@property (copy,nonatomic) NSString      *loginType;
@property (copy,nonatomic) NSString      *loginUrl;
@property (copy,nonatomic) NSArray      *loginInputUrl;
@property (copy,nonatomic) NSArray      *successUrl;
@property (copy,nonatomic) NSArray      *jsUrl;
@property (copy,nonatomic) NSString      *userAgent;
@property (copy,nonatomic) NSString      *isWebLogin;


@end
