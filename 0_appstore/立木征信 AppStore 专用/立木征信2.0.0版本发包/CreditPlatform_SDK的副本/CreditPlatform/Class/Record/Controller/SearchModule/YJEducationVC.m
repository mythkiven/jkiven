//
//  YJEducationVC.m
//  CreditPlatform
//
//  Created by yj on 16/8/17.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJEducationVC.h"
#import "ReportFirstCommonModel.h"
#import "YJEducationVC.h"
#import "YJSearchConditionModel.h"
#import "YJReportEducationDetailsVC.h"
@interface YJEducationVC ()

@end

@implementation YJEducationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    MYLog(@"------%@",self.searchType);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
    ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
    resultVc.token = mm.token;
    resultVc.biztype = kBizType_education;
    resultVc.getResult = @"0";
    resultVc.url = result_web_url_;
    YJNavigationController *navResultVC = [[YJNavigationController alloc] initWithRootViewController:resultVc];
    [self presentViewController:navResultVC
                       animated:YES
                     completion:nil];
    // 上边是H5
    // 下边是原始:
//    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
//    YJReportEducationDetailsVC *vc = [[YJReportEducationDetailsVC alloc] init];
//    vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//    vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
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
    YJReportEducationDetailsVC *vc = [[YJReportEducationDetailsVC alloc] init];
    vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
    vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
    vc.searchConditionModel.ID = mm.id;
    
    return vc;
    
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    
    [self showViewController:viewControllerToCommit sender:self];
    
}
@end
