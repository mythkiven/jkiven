//
//  YJCityModel.h
//  CreditPlatform
//
//  Created by yj on 16/7/20.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JFundSocialSearchCellUpModel;
@interface YJCityInfoModel : NSObject
@property (copy,nonatomic) NSString      *areaCode;
@property (copy,nonatomic) NSString      *areaName;
@property (copy,nonatomic) NSString      *updateDate ;
@property (copy,nonatomic) NSString      *parentId  ;
@property (copy,nonatomic) NSString      *id ;
@property (copy,nonatomic) NSString      *areaSequence ;
@property (copy,nonatomic) NSString      *remark ;
@property (copy,nonatomic) NSString      *status ;
@property (copy,nonatomic) NSString      *createDate ;
@property (copy,nonatomic) NSString      *areaDomain ;
@property (copy,nonatomic) NSString      *accountPlaceholder  ;
@property (copy,nonatomic) NSString      *passwordPlaceholder  ;
@property (copy,nonatomic) id             fieldItemCfg ;
@property (copy,nonatomic) JFundSocialSearchCellUpModel  *fundSocialModel ;
@property (nonatomic, assign) BOOL isSelected;

@end

/** 公积金社保 search用*/
@interface JFundSocialSearchCellModel : NSObject
@property (copy,nonatomic) NSString      *lable;
@property (copy,nonatomic) NSString      *name;
@property (copy,nonatomic) NSString      *elementType;
@property (copy,nonatomic) NSString      *placeHolder;
@property (copy,nonatomic) NSString      *checkEmpty;
@property (copy,nonatomic) NSString      *checkMoble;
@property (copy,nonatomic) NSString      *checkLength;
@property (copy,nonatomic) NSString      *checkEmail;
@property (copy,nonatomic) NSString      *checkIdCard;
@property (copy,nonatomic) NSString      *checkNumber;
@property (copy,nonatomic) NSString      *onHasKeyShowInfo;
@end

@interface JFundSocialSearchCellUpModel : NSObject
@property (copy,nonatomic) NSArray      *elements;;
@end



@interface YJCityModel : NSObject
//@property (copy,nonatomic) NSString      * code;
//@property (copy,nonatomic) NSString      * success;
//@property (copy,nonatomic) NSString      * data;
//@property (copy,nonatomic) NSString      * msg;
//@property (copy,nonatomic) NSArray       * list;


@property (copy,nonatomic) NSString      * key;
@property (copy,nonatomic) NSArray       * sortList;

/**👆为公积金、社保的城市列表*/


/**👇为企业认证的城市选择*/
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *cityCode;
+ (instancetype)cityModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
