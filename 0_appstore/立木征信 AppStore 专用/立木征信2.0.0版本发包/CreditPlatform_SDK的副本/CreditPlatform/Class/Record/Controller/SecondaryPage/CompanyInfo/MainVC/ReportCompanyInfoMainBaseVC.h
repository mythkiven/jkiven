//
//  ReportCompanyInfoMainBaseVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/10/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  enum {
    ReportCompanyInfoTypeBusinessPublish = 20, // 工商公示
    ReportCompanyInfoTypeCompanyPublish,// 企业公示
    ReportCompanyInfoTypeOtherDepartment,// 其他部门
    ReportCompanyInfoTypeLawAssist // 司法协助
}ReportCompanyInfoType ;

@interface ReportCompanyInfoMainBaseVC : UITableViewController

/***控制器类型*/
@property (assign,nonatomic) ReportCompanyInfoType    type;
/***纯数据源*/
@property (nonatomic, strong) NSArray *dataArray;


@end
