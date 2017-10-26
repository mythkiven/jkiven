//
//  EducationModel.m
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/8/18.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "EducationModel.h"

@implementation EducationModel
-(void)setEducationInfo:(NSDictionary *)educationInfo{
    _educationInfo = educationInfo;
    _EEducationInfo = [EducationInfo mj_objectWithKeyValues:educationInfo];
}
-(void)setStudentStatusInfo:(NSDictionary *)studentStatusInfo{
    _studentStatusInfo = studentStatusInfo;
    _SStudentStatusInfo = [StudentStatusInfo mj_objectWithKeyValues:studentStatusInfo];
}

@end

@implementation StudentStatusInfo

@end@implementation EducationInfo

@end
