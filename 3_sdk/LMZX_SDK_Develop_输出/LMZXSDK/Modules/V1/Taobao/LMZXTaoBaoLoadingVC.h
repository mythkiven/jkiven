//
//  LMZXTaoBaoLoadingAnimaVC.h
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/2/14.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXLoadingReportBaseVC.h"
#import "LMZXDemoAPI.h"
//@class LMZXWebViewBaseVC;
@interface LMZXTaoBaoLoadingVC  : LMZXLoadingReportBaseVC


/**模块类型
 
 typedef  enum {
 LMZXWebBusinessTypeQQ   = 0,
 LMZXWebBusinessTypeTaobao = 1,
 LMZXWebBusinessTypeJD  = 2 ,
 LMZXWebBusinessTypeAlipay = 3,
 }LMZXWebBusinessType;
 
 */
@property (assign,nonatomic) NSInteger type;

@end
