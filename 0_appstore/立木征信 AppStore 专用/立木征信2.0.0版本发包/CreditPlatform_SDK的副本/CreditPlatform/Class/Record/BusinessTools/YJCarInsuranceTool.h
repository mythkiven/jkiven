//
//  YJTaoBaoDataTool.h
//  CreditPlatform
//
//  Created by yj on 16/10/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJBaseSearchDataTool.h"

@interface YJCarInsuranceTool : YJBaseSearchDataTool
/**
 *  获取车险数据
 *
 *  @param success 请求成功返回结果
 *  @param failure 请求失败回调
 */
- (void)searchCarInsuranceDataSuccesssuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
