//
//  YJCentralBankVC.m
//  CreditPlatform
//
//  Created by yj on 16/8/17.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCentralBankVC.h"
#import "ReportFirstCommonModel.h"

#import "YJReportCentralBankDetailsVC.h"
@interface YJCentralBankVC ()

@end

@implementation YJCentralBankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeContactAdd)];
//    [btn addTarget:self action:@selector(gogogog) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:btn];
//    btn.center = self.view.center;
    
    
}

- (void)gogogog {
    YJReportCentralBankDetailsVC *vc = [[YJReportCentralBankDetailsVC alloc] init];
    YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    
    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
    ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
    resultVc.token = mm.token;
    resultVc.biztype = kBizType_credit;
    resultVc.getResult = @"0";
    resultVc.url = result_web_url_;
    YJNavigationController *navResultVC = [[YJNavigationController alloc] initWithRootViewController:resultVc];
    [self presentViewController:navResultVC
                       animated:YES
                     completion:nil];
    
    //    // 上边是H5
    // 下边是原始:
//    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
//    YJReportCentralBankDetailsVC *vc = [[YJReportCentralBankDetailsVC alloc] init];
//    vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//    vc.searchConditionModel.type = 12;
//    vc.searchConditionModel.ID = mm.id;
//    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark---UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    if (self.presentedViewController) {
        return nil;
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)previewingContext.sourceView];
    
    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
    YJReportCentralBankDetailsVC *vc = [[YJReportCentralBankDetailsVC alloc] init];
    vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
    vc.searchConditionModel.type = 12;
    vc.searchConditionModel.ID = mm.id;
    return vc;
    
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    
    [self showViewController:viewControllerToCommit sender:self];
    
}
@end
