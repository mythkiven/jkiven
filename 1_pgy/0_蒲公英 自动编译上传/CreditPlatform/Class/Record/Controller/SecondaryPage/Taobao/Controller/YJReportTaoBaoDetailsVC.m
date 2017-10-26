//
//  YJReportTaoBaoDetailsVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportTaoBaoDetailsVC.h"
#import "YJTaoBaoDataTool.h"
#import "YJReportTaoBaoHeaderView.h"
#import "YJTaoBaoModel.h"
#import "YJTaoBaoAlipayInfoVC.h"
#import "YJTaoBaoAddressesVC.h"
#import "YJTaoBaoOrderDetailsVC.h"

#import "YJTaoBaoStatisticsVC.h"


@interface YJReportTaoBaoDetailsVC ()
{
    YJTaoBaoDataTool *_taoBaoDataTool;
}

@property (nonatomic, strong) YJTaoBaoModel *taoBaoModel;

@property (nonatomic, strong) YJTaobaoStatisticsModel *taoBaoStatisticsModel;

@end

@implementation YJReportTaoBaoDetailsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"淘宝报告";
    
    switch (self.searchConditionModel.type) {
        case YJGoToSearchResultTypeFromHome:
            [self laodTaoBaoData];
            break;
        case YJGoToSearchResultTypeFromRecord:
            [self checkDetailReport];
            break;
            
        default:
            break;
    }
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_taoBaoDataTool removeTimer];
    
}






-(void)checkDetailReport{
    __weak typeof(self) weakSelf = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    NSDictionary *dicParams =@{@"method" : urlJK_recordDetailProcess,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"reportId":self.searchConditionModel.ID,
                               @"appVersion": VERSION_APP_1_3_3};
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_recordDetailProcess] params:dicParams success:^(id responseObj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MYLog(@"淘宝数据：%@",responseObj);
            [YJCreditWaitingView yj_hideWaitingViewForView:self.view animated:YES];

            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                weakSelf.taoBaoStatisticsModel = [YJTaobaoStatisticsModel mj_objectWithKeyValues:responseObj[@"data"][@"taobaoStatistics"]];
                
                weakSelf.taoBaoModel = [YJTaoBaoModel mj_objectWithKeyValues:responseObj[@"data"][@"taobaoRespVo"][@"data"]];
                
                [weakSelf creatUI];

                
            }
            
            
        });

       
        
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJCreditWaitingView yj_hideWaitingViewForView:self.view animated:YES];
            [self.view makeToast:errorInfo];
            [weakSelf performSelector:@selector(outself) withObject:nil afterDelay:2.5];
        });
        
    }];
}
#pragma mark---请求数据
- (void)laodTaoBaoData {
    __weak typeof(self) weakSelf = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    
    _taoBaoDataTool = [[YJTaoBaoDataTool alloc] init];
    _taoBaoDataTool.searchConditionModel = self.searchConditionModel;
    _taoBaoDataTool.searchType = self.searchType;

    _taoBaoDataTool.searchFailure = ^(NSError *error) {
        
        [YJCreditWaitingView yj_hideWaitingViewForView:weakSelf.view animated:YES];
        NSString *errorStr = nil;
        if (error.domain) {
            errorStr = error.domain;
        } else {
            errorStr =@"数据请求失败";
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.view makeToast:errorStr];
            [weakSelf performSelector:@selector(outself) withObject:nil afterDelay:1.6];

        });
        
        MYLog(@"退出控制器--------");
        
    };
    
    
    [_taoBaoDataTool searchTaoBaoDataSuccesssuccess:^(id responseObj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MYLog(@"淘宝数据：%@",responseObj);
            [YJCreditWaitingView yj_hideWaitingViewForView:self.view animated:YES];
            
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                weakSelf.taoBaoStatisticsModel = [YJTaobaoStatisticsModel mj_objectWithKeyValues:responseObj[@"data"][@"taobaoStatistics"]];
                
                weakSelf.taoBaoModel = [YJTaoBaoModel mj_objectWithKeyValues:responseObj[@"data"][@"taobaoRespVo"][@"data"]];
                
                [weakSelf creatUI];
                
                
            }
            
            
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJCreditWaitingView yj_hideWaitingViewForView:self.view animated:YES];
        });
    }];
    
    
}

#pragma mark --创建UI
- (void)creatUI {
    [self setupHeaderView];
    
    [self creatgroup0];
    [self creatgroup1];
    [self creatgroup2];
    [self creatgroup3];
    [self creatgroup4];
    
    [self.tableView reloadData];
}
- (void)setupHeaderView {
    
    YJReportTaoBaoHeaderView *headerView = [YJReportTaoBaoHeaderView taoBaoHeaderView];
    //    _headerView = headerView;
    headerView.taoBaoBasicInfo = self.taoBaoModel.taoBaoBasicInfo;
    
    CGFloat headerViewH = 510;
    if ((iPhone5 || iPhone4s  || iPhone6) && [self.taoBaoModel.taoBaoBasicInfo.identityStatus isEqualToString:@"已认证"]) {
        headerViewH = 510 +20;
    }
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, headerViewH);
    
    
    UIView *v = [[UIView alloc] init];
    
    v.frame = CGRectMake(0, 0, SCREEN_WIDTH, headerViewH);
    
    [v addSubview:headerView];
    v.backgroundColor = RGB(245, 245, 245);
    self.tableView.tableHeaderView = v;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
}

- (void)creatgroup0 {
    __weak typeof(self) weakSelf = self;
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"绑定支付宝信息" destVc:nil];
    
    item0.option = ^(NSIndexPath *indexPath) {
        
        YJTaoBaoAlipayInfoVC *alipayVC = [[YJTaoBaoAlipayInfoVC alloc] init];
        alipayVC.taoBaoAlipayInfo = weakSelf.taoBaoModel.taoBaoAlipayInfo;
        [weakSelf.navigationController pushViewController:alipayVC animated:YES];
        
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}

- (void)creatgroup1 {
    __weak typeof(self) weakSelf = self;
    
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"收货地址" destVc:nil];
    item0.option = ^(NSIndexPath *indexPath) {
        YJTaoBaoAddressesVC *addressVc = [[YJTaoBaoAddressesVC alloc] init];
        addressVc.addresses = weakSelf.taoBaoModel.addresses;
        [weakSelf.navigationController pushViewController:addressVc animated:YES];

    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}

- (void)creatgroup2 {
    __weak typeof(self) weakSelf = self;
    
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"历史消费地址统计" destVc:nil];
    item0.option = ^(NSIndexPath *indexPath) {
        
        YJTaoBaoStatisticsVC *addressStatisticsVC = [[YJTaoBaoStatisticsVC alloc] init];
        addressStatisticsVC.statisticType = YJTaoBaoStatisticTypeAddress;
        addressStatisticsVC.statisticsModel = weakSelf.taoBaoStatisticsModel;
        [weakSelf.navigationController pushViewController:addressStatisticsVC animated:YES];
        
        
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}

- (void)creatgroup3 {
    __weak typeof(self) weakSelf = self;
    
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"按月消费数据统计" destVc:nil];
    item0.option = ^(NSIndexPath *indexPath) {
        YJTaoBaoStatisticsVC *monthStatisticsVC = [[YJTaoBaoStatisticsVC alloc] init];
        monthStatisticsVC.statisticType = YJTaoBaoStatisticTypeMonth;
        monthStatisticsVC.statisticsModel = weakSelf.taoBaoStatisticsModel;
        [weakSelf.navigationController pushViewController:monthStatisticsVC animated:YES];
        
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}

- (void)creatgroup4 {
    __weak typeof(self) weakSelf = self;
    
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"订单详情" destVc:nil];
    item0.option = ^(NSIndexPath *indexPath) {
        
        YJTaoBaoOrderDetailsVC *detailsVC = [[YJTaoBaoOrderDetailsVC alloc] init];
        detailsVC.orderDetails = weakSelf.taoBaoModel.orderDetails;
        [weakSelf.navigationController pushViewController:detailsVC animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}

-(void)outself{
    [self.navigationController popViewControllerAnimated:YES];
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
