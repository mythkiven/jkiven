//
//  YJCompanyInfoVC.m
//  CreditPlatform
//
//  Created by yj on 2016/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCompanyInfoVC.h"

@interface YJCompanyInfoVC ()

@end

@implementation YJCompanyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
//    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
//    YJReportTaoBaoDetailsVC *vc = [[YJReportTaoBaoDetailsVC alloc] init];
//    vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//    vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
//    vc.searchConditionModel.ID = mm.id;
//    [self.navigationController pushViewController:vc animated:YES];
    //
}
#pragma mark---UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    if (self.presentedViewController) {
        return nil;
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)previewingContext.sourceView];
    
//    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
//    YJReportTaoBaoDetailsVC *vc = [[YJReportTaoBaoDetailsVC alloc] init];
//    vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//    vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
//    vc.searchConditionModel.ID = mm.id;
    
    return nil;
    
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    
    [self showViewController:viewControllerToCommit sender:self];
    
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
