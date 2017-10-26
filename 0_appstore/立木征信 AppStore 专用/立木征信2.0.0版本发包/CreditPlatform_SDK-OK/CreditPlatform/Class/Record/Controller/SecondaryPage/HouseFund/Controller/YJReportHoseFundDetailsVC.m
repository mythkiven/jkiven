//
//  YJReportHoseFundViewController.m
//  CreditPlatform
//
//  Created by yj on 16/7/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportHoseFundDetailsVC.h"
#import "YJHouseFundView.h"
#import "YJHouseFundLoanInfoVC.h"
#import "YJHousfundPayDetailsVC.h"
#import "YJHouseFundModel.h"

@interface YJReportHoseFundDetailsVC ()
{
     CommonSearchDataTool *_commonSearchDataTool;
}

@property (nonatomic, strong) YJHouseFundModel *houseFundModel;
@end

@implementation YJReportHoseFundDetailsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"公积金报告";
    
    if (self.sdkEnter) { // 直接取数据, 不使用 H5的结果页
        
         self.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemtarget:self action:@selector(back)];
        
        
        __weak typeof(self) sself = self;
        
         [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
        
        NSDictionary *dict = @{@"method":@"api.common.getResult",
                               @"apiKey":[LMZXSDK shared].lmzxApiKey,
                               @"version":@"1.2.0",
                               @"token":self.sdktoken,
                               @"bizType":kBizType_housefund
                               };
        
        // 3.获取查询结果  直接从 APXI 拿结果
        [YJHTTPTool postResult:[[LMZXSDK shared].lmzxTestURL stringByAppendingPathComponent:@"api/gateway"] params:dict success:^(id obj) {
            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
             MYLog(@"我的结果-------结果列表：%@",obj);
            
            BOOL obj4 =[obj isKindOfClass:[NSDictionary class]];
            if (!obj | !obj4) {
                // 失败
            }
            if ([obj[@"code"] isEqualToString:@"0000"]) {
                sself.houseFundModel = [YJHouseFundModel mj_objectWithKeyValues:obj[@"data"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [sself creatUI];
                });
//                // 成功
//                [sself queryResult];
            } else {
                [sself.view makeToast:@"暂无数据"];
                [sself jOutSelf];
            }
            
        } failure:^( NSError *error) {
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
        }];
        
        
        
    } else {
        switch (self.searchConditionModel.type) {
            case YJGoToSearchResultTypeFromHome:
                [self laodHouseFundData];
                break;
            case YJGoToSearchResultTypeFromRecord:
                [self checkDetailReport];
                break;
                
            default:
                break;
        }
    }
    
}
#pragma mark  从 APP **3.查询结果**
- (void)queryResult {
    
    
    // 直接加载数据
    __weak typeof(self) sself = self;
   
    NSDictionary *dict3 = @{@"method":urlJK_queryResult,
                            @"mobile":[kUserManagerTool mobile],
                            @"userPwd":[kUserManagerTool userPwd],
                            @"token":self.sdktoken,
                            @"bizType":kBizType_housefund,
                            @"appVersion":VERSION_APP_1_3_0};
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryResult] params:dict3 success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            
            if(responseObj[@"data"][@"data"]){
                sself.houseFundModel = [YJHouseFundModel mj_objectWithKeyValues:responseObj[@"data"][@"data"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [sself creatUI];
                });
            }else {
                [sself.view makeToast:@"暂无数据"];
                [sself jOutSelf];
            }
            MYLog(@"第三步获取公积金数据-------%@",responseObj[@"data"][@"data"]);
            //无数据
        }else {
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_commonSearchDataTool removeTimer];

}
#pragma mark  返回
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 记录 网络
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
            sself.houseFundModel = [YJHouseFundModel mj_objectWithKeyValues:responseObj[@"data"][@"data"]];
            
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
#pragma mark - 首页 网络
- (void)laodHouseFundData {
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];

    _commonSearchDataTool = [[CommonSearchDataTool alloc] init];
    _commonSearchDataTool.searchConditionModel = self.searchConditionModel;
    
    _commonSearchDataTool.searchType = self.searchType;
    _commonSearchDataTool.method = urlJK_queryHouseFund;
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
        if(obj[@"data"][@"data"]){
            sself.houseFundModel = [YJHouseFundModel mj_objectWithKeyValues:obj[@"data"][@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
                [sself creatUI];
            });
        }else {
            [sself.view makeToast:@"暂无数据"];
            [sself jOutSelf];
        }
        MYLog(@"第三步获取公积金数据-------%@",obj[@"data"][@"data"]);
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
    
    [self.tableView reloadData];
}

- (void)setupHeaderView {
    
    YJHouseFundView *headerView = [YJHouseFundView houseFundView];
//    _headerView = headerView;
    headerView.houseFundModel = self.houseFundModel;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 462);


    
    UIView *v = [[UIView alloc] init];

    v.frame = CGRectMake(0, 0, SCREEN_WIDTH, 462);

    [v addSubview:headerView];
    v.backgroundColor = RGB(245, 245, 245);
    self.tableView.tableHeaderView = v;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
}

- (void)creatgroup0 {
    __weak typeof(self) weakSelf = self;
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"存缴明细" destVc:nil];

    item0.option = ^(NSIndexPath *indexPath) {
        YJHousfundPayDetailsVC *vc = [[YJHousfundPayDetailsVC alloc] init];
        vc.title = @"存缴明细";
        vc.houseFundDetails = weakSelf.houseFundModel.details;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
  
}

- (void)creatgroup1 {
    __weak typeof(self) weakSelf = self;

    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"贷款明细" destVc:nil];
    item0.option = ^(NSIndexPath *indexPath) {
        YJHouseFundLoanInfoVC *vc = [[YJHouseFundLoanInfoVC alloc] init];
        vc.title =@"贷款明细";
        vc.loadInfo = weakSelf.houseFundModel.loadMsg;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0];
    
    [self.dataSource addObject:group];
    
}

//-(void)outself{
//    [self.navigationController popViewControllerAnimated:YES];
//}


- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    //    __weak typeof(self) weakSelf = self;
    
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"取消" style:(UIPreviewActionStyleDestructive) handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    
    return @[action];
}

@end
