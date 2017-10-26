//
//  YJCarInsuranceDetailsVC.m
//  CreditPlatform
//
//  Created by yj on 2016/11/1.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportNetbankBillDetailsVC.h"
#import "YJCarInsuranceDetHeaderView.h"
#import "YJEBankBillModel.h"
#import "YJCarInsuranceTypeInfoVC.h"
#import "YJCarInsuranceOtherInfoVC.h"
#import "YJNetBankBillHeaderView.h"
#import "YJEBankDealDetVc.h"
@interface YJReportNetbankBillDetailsVC ()

@end

@implementation YJReportNetbankBillDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"网银流水报告";
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

    
    [self.tableView reloadData];
}

- (void)setupHeaderView {
    YJNetBankBillHeaderView *headerView = [YJNetBankBillHeaderView netBankBillHeaderView];
    headerView.index = self.index;
    headerView.eBankBillModel = self.eBankBillModel;
    
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 520);
    
    
//    [self.tableView addSubview:headerView];
//    
//    
//    self.tableView.contentInset = UIEdgeInsetsMake(540, 0, 0, 0);
    
    UIView *v = [[UIView alloc] init];
    
    v.frame = CGRectMake(0, 0, SCREEN_WIDTH, 520);
    
    [v addSubview:headerView];
    v.backgroundColor = RGB(245, 245, 245);
    self.tableView.tableHeaderView = v;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
}

- (void)creatgroup0 {
    __weak typeof(self) weakSelf = self;
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"交易明细" destVc:nil];
    
    item0.option = ^(NSIndexPath *indexPath) {
        YJEBankDealDetVc *vc = [[YJEBankDealDetVc alloc] init];
        vc.billDets = [weakSelf.eBankBillModel.cards[weakSelf.index] bills];

        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}


@end
