//
//  YJDiDiListVC.m
//  CreditPlatform
//
//  Created by yj on 2017/5/19.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import "YJDiDiListVC.h"
#import "YJReportCarInsurancTypeVC.h"
#import "ReportFirstCommonModel.h"
#import "YJReportNetbankBillTypeVC.h"

@interface YJDiDiListVC ()

@end

@implementation YJDiDiListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)gotoNextViewControllerWithSelectIndexPath:(NSIndexPath *)indexPath {
    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
    YJReportNetbankBillTypeVC *vc = [[YJReportNetbankBillTypeVC alloc] init];
    vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
    vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
    vc.searchConditionModel.ID = mm.id;
    
    return vc;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    
    
    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
    ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
    resultVc.token = mm.token;
    resultVc.biztype = kBizType_diditaxi;
    resultVc.getResult = @"0";
    resultVc.url = result_web_url_;
    YJNavigationController *navResultVC = [[YJNavigationController alloc] initWithRootViewController:resultVc];
    [self presentViewController:navResultVC
                       animated:YES
                     completion:nil];
    
    // 上边是H5
    // 下边是原始:
    
//    [self.navigationController pushViewController:[self gotoNextViewControllerWithSelectIndexPath:indexPath] animated:YES];
    
}
#pragma mark---UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    if (self.presentedViewController) {
        return nil;
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)previewingContext.sourceView];
    
    return [self gotoNextViewControllerWithSelectIndexPath:indexPath];
    
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    [self showViewController:viewControllerToCommit sender:self];
    
}
@end
