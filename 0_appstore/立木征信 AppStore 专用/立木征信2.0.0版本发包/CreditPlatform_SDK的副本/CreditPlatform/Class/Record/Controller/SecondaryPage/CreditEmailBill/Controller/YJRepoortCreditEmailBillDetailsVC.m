//
//  YJRepoortCreditEmailBillDetailsVC.m
//  CreditPlatform
//
//  Created by yj on 2016/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJRepoortCreditEmailBillDetailsVC.h"
#import "ReportCreditEmailBillDetailsHeader.h"
#import "reportCreditBillModel.h"

#import "YJRepoortCreditEmailBillDetailsBillListVC.h"

@interface YJRepoortCreditEmailBillDetailsVC ()
{
    CommonSearchDataTool *_commonSearchDataTool;
}



@end

@implementation YJRepoortCreditEmailBillDetailsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用卡报告";
    if (_mainModel) {
        [self creatUI];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_commonSearchDataTool removeTimer];
    
}

#pragma mark --创建UI
- (void)creatUI {
    [self setupHeaderView];
    [self creatGroupData];
    [self.tableView reloadData];
}

- (void)setupHeaderView {
  
    ReportCreditEmailBillDetailsHeader *headerView = [ReportCreditEmailBillDetailsHeader creditEmailBillView];
    MYLog(@"%@",NSStringFromCGRect(headerView.frame) );
    headerView.model = _mainModel.cardInfo;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220);
 
    MYLog(@"%@",NSStringFromCGRect(headerView.frame) );
    
    UIView *v = [[UIView alloc] init];
    v.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220);
    [v addSubview:headerView];
    self.tableView.tableHeaderView = v;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
     MYLog(@"%@",NSStringFromCGRect(headerView.frame) );
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
  
}



#pragma mark - 创建model view
-(void)creatGroupData{
    __block typeof(self)  sself = self;
    NSArray *arr =self.mainModel.cardChangeInfo;
    
    
    // 账单分期
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"账单分期" destVc:nil];
    item0.option = ^(NSIndexPath *indexPath){
        YJRepoortCreditEmailBillDetailsBillListVC *vc = [[YJRepoortCreditEmailBillDetailsBillListVC alloc]init];
        vc.fenqiData = sself.mainModel.cardInstallments;
        vc.detailType = RepoortCreditEmailBillDetailsTypeEver;
        vc.reportCreditBillChangeInfo = [arr firstObject];
        [sself.navigationController pushViewController:vc animated:YES];
    };
    
    YJItemGroup *group = [[YJItemGroup alloc] init];
    group.groups = @[item0];
    [self.dataSource addObject:group];
    
    if (arr.count) {
        for (reportCreditBillChangeInfo *dic in arr) {
            
            // 月份数据 待处理
            NSString *str = [dic.statementMonth DateString_Year_Month_Day];
            if (![str hasStr:@"月"]) {
               str = [str stringByAppendingString:@"月"];
            }
            YJArrowItem *item = [YJArrowItem itemWithTitle:[str stringByAppendingString:@"账单"]destVc:nil];
            item.option = ^(NSIndexPath *indexPath){
                YJRepoortCreditEmailBillDetailsBillListVC *vc = [[YJRepoortCreditEmailBillDetailsBillListVC alloc]init];
                vc.reportCreditBillChangeInfo = dic;
                vc.detailType = RepoortCreditEmailBillDetailsTypeMonth;
                [sself.navigationController pushViewController:vc animated:YES];
                

                
            };
            YJItemGroup *group = [[YJItemGroup alloc] init];
            group.groups = @[item];
            [self.dataSource addObject:group];
            
            
        }
    }
    
}



- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    //    __weak typeof(self) weakSelf = self;
    
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"取消" style:(UIPreviewActionStyleDestructive) handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    
    return @[action];
}


@end
