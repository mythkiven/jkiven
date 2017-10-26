//
//  YJReportOperatorsVC.m
//  CreditPlatform
//
//  Created by yj on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportOperatorsVC.h"
#import "OperatorsReportMainVC.h"
#import "ReportFirstCommonModel.h"
#import "YJReportHouseFundCell.h"
#import "OperatorsReportMainVC.h"
@interface YJReportOperatorsVC ()
{
    ReportFirstCommonModel *reportFirstCommonModel_;
    NSArray *data_;
}
@end

@implementation YJReportOperatorsVC

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    resultVc.biztype = kBizType_mobile;
    resultVc.getResult = @"0";
    resultVc.url = result_web_url_;
    YJNavigationController *navResultVC = [[YJNavigationController alloc] initWithRootViewController:resultVc];
    [self presentViewController:navResultVC
                       animated:YES
                     completion:nil];
    // 上边是H5
    // 下边是原始:
//    
//    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
//    OperatorsReportMainVC *vc = [[OperatorsReportMainVC alloc] init];
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
    OperatorsReportMainVC *vc = [[OperatorsReportMainVC alloc] init];
    vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
    vc.searchConditionModel.type = 12;
    vc.searchConditionModel.ID = mm.id;
    
    return vc;
    
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    
    [self showViewController:viewControllerToCommit sender:self];
    
}






@end
