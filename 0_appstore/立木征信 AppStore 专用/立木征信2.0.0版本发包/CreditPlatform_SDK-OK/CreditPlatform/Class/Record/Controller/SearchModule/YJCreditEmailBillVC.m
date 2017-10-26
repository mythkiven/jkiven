//
//  YJCreditEmailBillVC.m
//  CreditPlatform
//
//  Created by yj on 2016/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCreditEmailBillVC.h"
#import "ListHookVC.h"
#import "ReportFirstCommonModel.h"

@interface YJCreditEmailBillVC ()

@end

@implementation YJCreditEmailBillVC

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
    ListHookVC *vc = [[ListHookVC alloc] init];
    vc.searchItemType = SearchItemTypeCreditCardBill;
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
    resultVc.biztype = kBizType_bill;
    resultVc.getResult = @"0";
    resultVc.url = result_web_url_;
    YJNavigationController *navResultVC = [[YJNavigationController alloc] initWithRootViewController:resultVc];
    [self presentViewController:navResultVC
                       animated:YES
                     completion:nil];
    //    // 上边是H5
    // 下边是原始:
//    
//    
//    
////    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
////    CitySelectVC *vc = [[CitySelectVC alloc] init];
////    vc.index = @"12";
////    vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
////    vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
////    vc.searchConditionModel.ID = mm.id;
//    [self.navigationController pushViewController:[self gotoNextViewControllerWithSelectIndexPath:indexPath] animated:YES];
    //
}
#pragma mark---UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    if (self.presentedViewController) {
        return nil;
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)previewingContext.sourceView];
    
//    ReportFirstCommonModel * mm = self.dataArray[indexPath.row];
//    CitySelectVC *vc = [[CitySelectVC alloc] init];
//    vc.index = @"12";
//    vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//    vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
//    vc.searchConditionModel.ID = mm.id;
    
    return [self gotoNextViewControllerWithSelectIndexPath:indexPath];
    
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
