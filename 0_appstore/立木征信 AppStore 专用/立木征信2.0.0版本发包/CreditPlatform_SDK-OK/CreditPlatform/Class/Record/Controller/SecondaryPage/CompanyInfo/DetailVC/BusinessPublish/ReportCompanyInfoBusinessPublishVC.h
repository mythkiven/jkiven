//
//  ReportCompanyInfoBusinessPublishVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  enum {
    ReportCompanyInfoBusinessPublishTpyeLogin = 30, // 登记信息
    ReportCompanyInfoBusinessPublishTpyeRecord,// 备案信息
    ReportCompanyInfoBusinessPublishTpyeMoveProperty,// 动产抵押
    ReportCompanyInfoBusinessPublishTpyeStock , // 股权出质
    ReportCompanyInfoBusinessPublishTpyeAdministrationPunish, // 行政处罚
    ReportCompanyInfoBusinessPublishTpyeOperateError, // 经营异常
    ReportCompanyInfoBusinessPublishTpyeBreakLaw, // 严重违法
    ReportCompanyInfoBusinessPublishTpyeCheck, // 抽查检查
}ReportCompanyInfoBusinessPublishType ;



@interface ReportCompanyInfoBusinessPublishVC : UITableViewController
//控制器类型
@property (assign,nonatomic) ReportCompanyInfoBusinessPublishType    type;

@end
