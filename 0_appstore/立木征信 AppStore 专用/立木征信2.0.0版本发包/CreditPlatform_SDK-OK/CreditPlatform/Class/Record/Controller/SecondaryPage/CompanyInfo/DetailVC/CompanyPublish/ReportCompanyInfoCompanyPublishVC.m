//
//  ReportCompanyInfoCompanyPublishVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/26.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ReportCompanyInfoCompanyPublishVC.h"

@interface ReportCompanyInfoCompanyPublishVC ()

@end

@implementation ReportCompanyInfoCompanyPublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.type) {
        case ReportCompanyInfoCompanyPublishTypeStockHolderPurse :{ //股东及出资信息
            self.title = @"股东及出资信息";
            break;
            
        }case ReportCompanyInfoCompanyPublishTypeStockHolderPurseChange :{ // 股东及出资变更信息
            self.title = @"股东及出资变更信息";
            break;
            
        }case ReportCompanyInfoCompanyPublishTypeStockRightChange :{ //股权变更信息
            self.title = @"股权变更信息";
            break;
            
        }case ReportCompanyInfoCompanyPublishTypeAdministrationPremit :{ //行政许可信息
            self.title = @"行政许可信息";
            break;
            
        }case ReportCompanyInfoCompanyPublishTypeIntellectualProperty :{ // 知识产权出质登记信息
            self.title = @"知识产权出质登记信息";
            break;
            
        }case ReportCompanyInfoCompanyPublishTypeAdministrationPunish :{ // 行政处罚信息
            self.title = @"行政处罚信息";
            break;
            
        }default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
