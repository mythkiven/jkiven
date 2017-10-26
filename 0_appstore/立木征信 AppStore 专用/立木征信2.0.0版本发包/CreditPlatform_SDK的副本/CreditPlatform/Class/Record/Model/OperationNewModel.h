//
//  NewOperationModel.h
//  CreditPlatform
//
//  Created by gyjrong on 17/2/23.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

// 用于展示新的结果集 和 OperationModel 共存

@interface OperationNewModel : NSObject

@property (copy,nonatomic) NSString *mobileOperator;//运营商
@property (copy,nonatomic)  NSArray *recordInfo10List;//前十通话记录
@property (copy,nonatomic) NSString *mobileAreaAddress;//归属地
@property (copy,nonatomic) NSString *networkAge;//网龄

@end



@interface OperationNewCallTen : NSObject

//
@property (copy,nonatomic) NSString *mobileArea;// 归属地
@property (copy,nonatomic) NSString *callTotalTime;//
@property (copy,nonatomic) NSString *oldCallTime;//
@property (copy,nonatomic) NSString *mobileNo;//
@property (copy,nonatomic) NSString *callCount;//
@property (copy,nonatomic) NSString *callTotalTimeStr;//
@property (copy,nonatomic) NSString *nearCallTime;// 
@end

