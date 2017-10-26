//
//  YJCarInsuranceDetailsVC.m
//  CreditPlatform
//
//  Created by yj on 2016/11/1.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCarInsuranceDetailsVC.h"
#import "YJCarInsuranceDetHeaderView.h"
#import "YJCarInsuranceModel.h"
#import "YJCarInsuranceTypeInfoVC.h"
#import "YJCarInsuranceOtherInfoVC.h"

@interface YJCarInsuranceDetailsVC ()

@end

@implementation YJCarInsuranceDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"汽车保险报告";
    [self creatUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --创建UI
- (void)creatUI {
    [self setupHeaderView];
    
    [self creatgroup0];
    [self creatgroup1];
    [self creatgroup2];
    
    
    YJCarInsurancePolicyDetails *policyDetail = self.carInsuranceModel.policyDetails[self.index];
    if (![policyDetail.insuranceAlias isEqualToString:@"商业险"]) { // 如果是商业险，就不显示
        [self creatgroup3];
    }
    
    
    [self.tableView reloadData];
}

- (void)setupHeaderView {
    YJCarInsuranceDetHeaderView *headerView = [YJCarInsuranceDetHeaderView carInsuranceDetHeaderView];
    headerView.basicInfo = self.carInsuranceModel.basicInfoModel;
    
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 390);
    
    UIView *v = [[UIView alloc] init];
    
    v.frame = CGRectMake(0, 0, SCREEN_WIDTH, 390);
    
    [v addSubview:headerView];
    v.backgroundColor = RGB(245, 245, 245);
    self.tableView.tableHeaderView = v;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
}

- (void)creatgroup0 {
    __weak typeof(self) weakSelf = self;
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"保单信息" destVc:nil];
    
    item0.option = ^(NSIndexPath *indexPath) {
        YJCarInsuranceOtherInfoVC *vc = [[YJCarInsuranceOtherInfoVC alloc] init];
        vc.showType = CarInsuranceShowTypePolicy;
        vc.policyDetails = weakSelf.carInsuranceModel.policyDetails[weakSelf.index];

        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}

- (void)creatgroup1 {
    __weak typeof(self) weakSelf = self;
    
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"车辆信息" destVc:nil];
    item0.option = ^(NSIndexPath *indexPath) {
        YJCarInsuranceOtherInfoVC *vc = [[YJCarInsuranceOtherInfoVC alloc] init];
        vc.showType = CarInsuranceShowTypeCarInfo;
        vc.policyDetails = weakSelf.carInsuranceModel.policyDetails[weakSelf.index];

        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}

- (void)creatgroup2 {
    __weak typeof(self) weakSelf = self;
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"险种信息" destVc:nil];
    
    item0.option = ^(NSIndexPath *indexPath) {
        YJCarInsuranceTypeInfoVC *vc = [[YJCarInsuranceTypeInfoVC alloc] init];
        YJCarInsurancePolicyDetails *policyDetails = weakSelf.carInsuranceModel.policyDetails[weakSelf.index];
        vc.insurances = policyDetails.insurances;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}

- (void)creatgroup3 {
    __weak typeof(self) weakSelf = self;
    
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"代收车船税" destVc:nil];
    item0.option = ^(NSIndexPath *indexPath) {
        YJCarInsuranceOtherInfoVC *vc = [[YJCarInsuranceOtherInfoVC alloc] init];
        vc.showType = CarInsuranceShowTypeTax;
        vc.policyDetails = weakSelf.carInsuranceModel.policyDetails[weakSelf.index];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}

//-(void)outself{
//    [self.navigationController popViewControllerAnimated:YES];
//}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
