//
//  LMZXCreditBillLoadingVC.h
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/3/14.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXLoadingReportBaseVC.h"
#import "LMZXDemoAPI.h"


@interface LMZXCreditBillLoadingVC : LMZXLoadingReportBaseVC

/**模块类型:qq=0 126=1 163=2 139=3   sina=4 aliyun=5
 */

@property (assign,nonatomic) LMZXCreditCardBillMailType type;

@property (assign,nonatomic) BOOL isNative;



@end
