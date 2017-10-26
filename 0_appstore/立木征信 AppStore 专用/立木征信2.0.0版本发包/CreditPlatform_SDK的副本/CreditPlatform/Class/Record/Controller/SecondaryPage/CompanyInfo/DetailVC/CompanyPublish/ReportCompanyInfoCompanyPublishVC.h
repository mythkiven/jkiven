//
//  ReportCompanyInfoCompanyPublishVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/26.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  enum {
    ReportCompanyInfoCompanyPublishTypeStockHolderPurse = 40, //股东及出资信息
    ReportCompanyInfoCompanyPublishTypeStockHolderPurseChange,// 股东及出资变更信息
    ReportCompanyInfoCompanyPublishTypeStockRightChange,// 股权变更信息
    ReportCompanyInfoCompanyPublishTypeAdministrationPremit , // 行政许可信息
    ReportCompanyInfoCompanyPublishTypeIntellectualProperty, // 知识产权出质登记信息
    ReportCompanyInfoCompanyPublishTypeAdministrationPunish, // 行政处罚信息
}ReportCompanyInfoCompanyPublishType ;

@interface ReportCompanyInfoCompanyPublishVC : UIViewController
//控制器类型
@property (assign,nonatomic) ReportCompanyInfoCompanyPublishType    type;

@end
