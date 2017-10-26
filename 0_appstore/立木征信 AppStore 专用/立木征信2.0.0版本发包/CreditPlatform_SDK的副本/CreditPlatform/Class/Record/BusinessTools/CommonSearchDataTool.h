//
//  CommonBaseDataTool.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/11.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJBaseSearchDataTool.h"

@interface CommonSearchDataTool : YJBaseSearchDataTool



/**
 首次轮训的差异method
 */
@property (strong,nonatomic) NSString   *method;
/**
 不同历史版本的version
 */
@property (strong,nonatomic) NSString   *version;


/**
 
 *  获取央行征信、学信网、脉脉、社保、公积金等不发送验证码的接口；
 */
- (void)searchDataSuccesssuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;


/**
 *  其他 
 */

@end
