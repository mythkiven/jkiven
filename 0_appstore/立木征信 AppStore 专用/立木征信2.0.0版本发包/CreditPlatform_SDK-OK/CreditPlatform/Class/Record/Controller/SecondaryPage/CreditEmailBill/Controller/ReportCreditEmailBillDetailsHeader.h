//
//  ReportCreditEmailBillDetailsHeader.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "reportCreditBillModel.h"
@interface ReportCreditEmailBillDetailsHeader : UIView
@property (strong,nonatomic) reportCreditBillModel  *model;
+ (id)creditEmailBillView;
@end
