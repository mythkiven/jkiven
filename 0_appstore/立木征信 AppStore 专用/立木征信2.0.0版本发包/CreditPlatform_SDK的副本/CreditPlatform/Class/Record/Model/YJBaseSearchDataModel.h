//
//  YJSearchDataModel.h
//  CreditPlatform
//
//  Created by yj on 16/8/3.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJBaseSearchDataModel : NSObject

/**
 *  姓名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  身份证号
 */
@property (nonatomic, copy) NSString *identityNo;
/**
 *  单位名称
 */
@property (nonatomic, copy) NSString *corpName;
/**
 *  账号状态
 */
@property (nonatomic, copy) NSString *accStatus;
/**
 *  开户日期
 */
@property (nonatomic, copy) NSString *openDate;
/**
 *  地区
 */
@property (nonatomic, copy) NSString *area;
/**
 *  数据采集时间
 */
@property (nonatomic, copy) NSString *createTime;



@end
