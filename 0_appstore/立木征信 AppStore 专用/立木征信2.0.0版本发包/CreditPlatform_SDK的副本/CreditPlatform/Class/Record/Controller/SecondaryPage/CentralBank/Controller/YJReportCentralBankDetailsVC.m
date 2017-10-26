//
//  YJReportCentralBankDetailsVC.m
//  CreditPlatform
//
//  Created by yj on 16/8/18.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportCentralBankDetailsVC.h"

#import "YJCentralBankModel.h"
#import "YJCentralBankHeaderView.h"

#import "YJCentralBankPublicRecordVC.h"
#import "YJCentralBankContentVC.h"
#import "YJCentralBankGroupVC.h"
#import "YJCentralBankRecordRemarkVC.h"

@interface YJReportCentralBankDetailsVC ()
{
    CommonSearchDataTool *_commonSearchDataTool;
}

@property (nonatomic, strong) YJCentralBankModel *centralBankModel;

@end

@implementation YJReportCentralBankDetailsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"央行征信报告";
    
    switch (self.searchConditionModel.type) {
        case YJGoToSearchResultTypeFromHome:
            [self laodCentralBankData];
            break;
        case YJGoToSearchResultTypeFromRecord:
            [self checkDetailReport];
            break;
            
        default:
            break;
    }
    
//    [self checkDetailReport];


    
//    [self creatUI];
    
}




- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_commonSearchDataTool removeTimer];
}



#pragma mark  记录数据
-(void)checkDetailReport{
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    NSDictionary *dicParams =@{@"method" : urlJK_recordDetailProcess,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"reportId":self.searchConditionModel.ID,
                               @"appVersion": VERSION_APP_1_3_0};
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_recordDetailProcess] params:dicParams success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            if (![responseObj[@"data"][@"creditRespVo"] isKindOfClass:[NSNull class]]) {
                sself.centralBankModel = [YJCentralBankModel mj_objectWithKeyValues:responseObj[@"data"][@"creditRespVo"][@"data"]];
            }
            sself.centralBankModel.dataCreditRecordSummary = [YJCentralBankSummary mj_objectArrayWithKeyValuesArray:responseObj[@"data"][@"dataCreditRecordSummary"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
                [sself creatUI];
            });
            
        } else {
            [sself.view makeToast:@"暂无数据"];
            [sself jOutSelf];
        }
        
        
    } failure:^(NSError *error) {
        //统一展示，
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
            [sself.view makeToast:errorInfo];
            [sself jOutSelf];
        });
    }];
}
#pragma mark  首页 数据
- (void)laodCentralBankData {
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];

    _commonSearchDataTool = [[CommonSearchDataTool alloc] init];
    _commonSearchDataTool.searchConditionModel = self.searchConditionModel;
    
    _commonSearchDataTool.searchType =self.searchType;
    _commonSearchDataTool.method = urlJK_queryCredit;
    _commonSearchDataTool.version = VERSION_APP_1_3_0;
    
    _commonSearchDataTool.searchFailure = ^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
            NSString *errorStr = nil;
            if (error.domain) {
                errorStr = error.domain;
            } else {
                errorStr =errorInfo;
            }
            [sself.view makeToast:errorStr];
            [sself jOutSelf];
        });
        
    };
    
    [_commonSearchDataTool searchDataSuccesssuccess:^(id obj) {
        if (![obj[@"data"] isKindOfClass:[NSNull class]]) {
            
            if (![obj[@"data"][@"creditRespVo"] isKindOfClass:[NSNull class]]) {
                sself.centralBankModel = [YJCentralBankModel mj_objectWithKeyValues:obj[@"data"][@"creditRespVo"][@"data"]];
            }
            
            sself.centralBankModel.dataCreditRecordSummary = [YJCentralBankSummary mj_objectArrayWithKeyValuesArray:obj[@"data"][@"dataCreditRecordSummary"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
                [sself creatUI];
            });
            
        } else {
            [sself.view makeToast:@"暂无数据"];
            [sself jOutSelf];
        }

    } failure:^(NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
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
    [self creatgroup5];
    [self creatgroup6];
    [self creatgroup7];
    
    
    [self.tableView reloadData];
}

- (void)setupHeaderView {
    
    YJCentralBankHeaderView *headerView = [YJCentralBankHeaderView centralBankView];
    //    _headerView = headerView;
    headerView.basicInfoModel = self.centralBankModel.basicInfoModel;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 270);
    
    
    UIView *v = [[UIView alloc] init];
    v.frame = CGRectMake(0, 0, SCREEN_WIDTH, 270);
    [v addSubview:headerView];
    v.backgroundColor = RGB(245, 245, 245);
    self.tableView.tableHeaderView = v;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
}

- (void)creatgroup0 {
    __weak typeof(self) weakSelf = self;
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"信贷记录" destVc:nil];
    
    item0.option = ^(NSIndexPath *indexPath) {
        YJCentralBankContentVC *vc = [[YJCentralBankContentVC alloc] init];
        vc.title = @"信贷记录";
        vc.dataArray = weakSelf.centralBankModel.dataCreditRecordSummary;
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    group.groups = @[item0];
    [self.dataSource addObject:group];
    
}

- (void)creatgroup1 {
    __weak typeof(self) weakSelf = self;
    
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"信用卡明细" destVc:nil];
    item0.option = ^(NSIndexPath *indexPath) {
        YJCentralBankGroupVC *vc = [[YJCentralBankGroupVC alloc] init];
        vc.title = @"信用卡明细";
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
        for (YJCentralBankDetail *det in weakSelf.centralBankModel.creditRecordModel.detail) {
            if ([det.type isEqualToString:@"信用卡 "]) {
                [tempArr addObject:det];
            }
        }
        vc.dataArray = tempArr;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}
- (void)creatgroup2 {
    __weak typeof(self) weakSelf = self;
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"购房贷款明细" destVc:nil];
    
    item0.option = ^(NSIndexPath *indexPath) {
        YJCentralBankGroupVC *vc = [[YJCentralBankGroupVC alloc] init];
        vc.title = @"购房贷款明细";
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
        for (YJCentralBankDetail *det in weakSelf.centralBankModel.creditRecordModel.detail) {
            if ([det.type isEqualToString:@"购房贷款"]) {
                [tempArr addObject:det];
            }
        }
        vc.dataArray = tempArr;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    group.groups = @[item0];
    [self.dataSource addObject:group];
    
}

- (void)creatgroup3 {
    __weak typeof(self) weakSelf = self;
    
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"其它贷款明细" destVc:nil];
    item0.option = ^(NSIndexPath *indexPath) {
        YJCentralBankGroupVC *vc = [[YJCentralBankGroupVC alloc] init];
        vc.title = @"其它贷款明细";
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
        for (YJCentralBankDetail *det in weakSelf.centralBankModel.creditRecordModel.detail) {
            if ([det.type isEqualToString:@"其他贷款"]) {
                [tempArr addObject:det];
            }
        }
        vc.dataArray = tempArr;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}

- (void)creatgroup4 {
    __weak typeof(self) weakSelf = self;
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"信贷记录备注" destVc:nil];
    item0.option = ^(NSIndexPath *indexPath) {

        YJCentralBankRecordRemarkVC *vc = [[YJCentralBankRecordRemarkVC alloc] init];
        vc.title = @"信贷记录备注";
        vc.dataArray = weakSelf.centralBankModel.creditRecordModel.comment;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    group.groups = @[item0];
    [self.dataSource addObject:group];
    
}

- (void)creatgroup5 {
    __weak typeof(self) weakSelf = self;
    
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"公共描述" destVc:nil];
    item0.option = ^(NSIndexPath *indexPath) {
        YJCentralBankPublicRecordVC *vc = [[YJCentralBankPublicRecordVC alloc] init];
        vc.title = @"公共描述";
        vc.publicRecordModel = weakSelf.centralBankModel.publicRecordModel;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}

- (void)creatgroup6 {
    __weak typeof(self) weakSelf = self;
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"个人查询明细" destVc:nil];
    
    item0.option = ^(NSIndexPath *indexPath) {
        YJCentralBankContentVC *vc = [[YJCentralBankContentVC alloc] init];
        vc.title = @"个人查询明细";
        for (YJCentralBankSearchRecordDet *det in weakSelf.centralBankModel.searchRecordModel.searchRecordDet) {
            if ([det.type isEqualToString:@"个人查询记录明细"]) {
//                vc.dataArray = det.item;
                vc.det = det;

            }
        }
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    group.groups = @[item0];
    [self.dataSource addObject:group];
    
}

- (void)creatgroup7 {
    __weak typeof(self) weakSelf = self;
    
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"机构查询明细" destVc:nil];
    item0.option = ^(NSIndexPath *indexPath) {
        YJCentralBankContentVC *vc = [[YJCentralBankContentVC alloc] init];
        vc.title = @"机构查询明细";
        for (YJCentralBankSearchRecordDet *det in weakSelf.centralBankModel.searchRecordModel.searchRecordDet) {
            if ([det.type isEqualToString:@"机构查询记录明细"]) {
//                vc.dataArray = det.item;
                vc.det = det;
            }
        }
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}

//-(void)outself{
//    [self.navigationController popViewControllerAnimated:YES];
//}
@end
