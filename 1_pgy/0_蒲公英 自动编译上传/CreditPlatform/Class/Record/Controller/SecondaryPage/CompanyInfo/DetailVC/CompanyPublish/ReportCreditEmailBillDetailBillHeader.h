//
//  ReportCreditEmailBillDetailBillHeader.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/26.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "reportCreditBillModel.h"
@interface ReportCreditEmailBillDetailBillHeader : UIView

// 顶部
@property (strong,nonatomic) reportCreditBillChangeInfo      *model;


+ (instancetype)reportCreditEmailBillDetailBillCellHeader;



@end
