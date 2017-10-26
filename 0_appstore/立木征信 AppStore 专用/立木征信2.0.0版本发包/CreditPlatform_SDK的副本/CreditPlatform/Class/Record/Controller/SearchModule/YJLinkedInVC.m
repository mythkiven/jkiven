//
//  YJLinkedInVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJLinkedInVC.h"
#import "ReportFirstCommonModel.h"
#import "ReportLinkedinDetailsVC.h"
@interface YJLinkedInVC ()

@end

@implementation YJLinkedInVC

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
    
    
    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
    ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
    resultVc.token = mm.token;
    resultVc.biztype = kBizType_linkedin;
    resultVc.getResult = @"0";
    resultVc.url = result_web_url_;
    YJNavigationController *navResultVC = [[YJNavigationController alloc] initWithRootViewController:resultVc];
    [self presentViewController:navResultVC
                       animated:YES
                     completion:nil];
    //    // 上边是H5
    // 下边是原始:
//    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
//    ReportLinkedinDetailsVC *vc = [[ReportLinkedinDetailsVC alloc] init];
//    vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//    vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
//    vc.recodeType = self.searchType;
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
    ReportLinkedinDetailsVC *vc = [[ReportLinkedinDetailsVC alloc] init];
    vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
    vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
    vc.recodeType = self.searchType;
    vc.searchConditionModel.ID = mm.id;
    
    return vc;
    
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
