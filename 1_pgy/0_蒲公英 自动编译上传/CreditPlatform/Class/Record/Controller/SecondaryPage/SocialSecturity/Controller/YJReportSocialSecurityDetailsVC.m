//
//  YJReportScialSecurityDetailsVC.m
//  CreditPlatform
//
//  Created by yj on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportSocialSecurityDetailsVC.h"
#import "YJSocialSecurityView.h"
#import "YJSocialSecurityDetailsVC.h"

#import "YJSocialSecurityModel.h"
//#import "YJSocialSecurityModel1.h"

#import "YJInsuranceCell.h"
#define kTopViewHeight 206

@interface YJReportSocialSecurityDetailsVC ()<UIGestureRecognizerDelegate>
{
    CommonSearchDataTool *_commonSearchDataTool;
    UIView *_autoMarginViewsContainer;
    UIView *_v;
    NSMutableArray *_containerArr;
    YJSocialSecurityView *_headerView;
    
}

@property (nonatomic, strong) YJSocialSecurityModel *socialSecurityModel;
@end

@implementation YJReportSocialSecurityDetailsVC
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社保报告";
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = RGB_pageBackground;
    
    if (self.sdkEnter) {// 直接取数据, 不使用 H5的结果页
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemtarget:self action:@selector(back)];
        
        
        // 直接加载数据
        __weak typeof(self) sself = self;
        [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
        NSDictionary *dict = @{@"method":@"api.common.getResult",
                               @"apiKey":[LMZXSDK shared].lmzxApiKey,
                               @"version":@"1.2.0",
                               @"token":self.sdktoken,
                               @"bizType":kBizType_socialsecurity
                               };
        
        // 3.获取查询结果  直接从 APXI 拿结果
        [YJHTTPTool postResult:[[LMZXSDK shared].lmzxTestURL stringByAppendingPathComponent:@"api/gateway"] params:dict success:^(id responseObj) {
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                
                MYLog(@"请求社保数据成功-------%@",responseObj);
                if (responseObj[@"data"]) {
                    sself.socialSecurityModel = [YJSocialSecurityModel mj_objectWithKeyValues:responseObj[@"data"]];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
                        
                        [sself creatUI];
                    });
                } else {
                    [sself.view makeToast:@"暂无数据"];
                    [sself jOutSelf];
                }
            }else {
            }
            
        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
                NSString *errorStr = nil;
                if (error.domain) {
                    errorStr = error.domain;
                } else {
                    errorStr = errorInfo;
                }
                [sself.view makeToast:errorStr];
                [sself jOutSelf];
            });
            
        }];
        
        
    } else {
        
        switch (self.searchConditionModel.type) {
            case YJGoToSearchResultTypeFromHome:
                [self loadSocialSecurityData];
                break;
            case YJGoToSearchResultTypeFromRecord:
                 [self checkDetailReport];
                break;
                
            default:
                break;
        }
    }
    // 系统手势返回
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark--UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_commonSearchDataTool removeTimer];
    
}

-(void)checkDetailReport{
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    NSDictionary *dicParams =@{@"method" : urlJK_recordDetailProcess,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"reportId":self.searchConditionModel.ID,
                               @"appVersion": VERSION_APP_1_3_0};
    
    MYLog(@"-----%@--%@--%@",kUserManagerTool.mobile,kUserManagerTool.userPwd,self.searchConditionModel.ID);
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_recordDetailProcess] params:dicParams success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            sself.socialSecurityModel = [YJSocialSecurityModel mj_objectWithKeyValues:responseObj[@"data"][@"data"]];
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

- (void)loadSocialSecurityData {
    
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    
    __weak typeof(self) sself = self;
    _commonSearchDataTool = [[CommonSearchDataTool alloc] init];
    _commonSearchDataTool.searchConditionModel = self.searchConditionModel;
    _commonSearchDataTool.searchType = self.searchType;
    _commonSearchDataTool.method = urlJK_querySocialsecurity;
    _commonSearchDataTool.version = VERSION_APP_1_3_0;
    
    _commonSearchDataTool.searchFailure = ^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
            NSString *errorStr = nil;
            if (error.domain) {
                errorStr = error.domain;
            } else {
                errorStr = errorInfo;
            }
            [sself.view makeToast:errorStr];
            [sself jOutSelf];
        });
        
        
        
    };
    
    [_commonSearchDataTool searchDataSuccesssuccess:^(id obj) {
        MYLog(@"请求社保数据成功-------%@",obj);
        if (obj[@"data"][@"data"]) {
            sself.socialSecurityModel = [YJSocialSecurityModel mj_objectWithKeyValues:obj[@"data"][@"data"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
                
                [sself creatUI];
            });
        } else {
            [sself.view makeToast:@"暂无数据"];
            [sself jOutSelf];
        }
        
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
            
        });
    }];
}


- (void)creatUI {

    
    [self setupHeaderView];

    
    [self.tableView reloadData];
}


- (void)setupHeaderView {
    UIView *v = [[UIView alloc] init];
    _v = v;
//    // 基本信息

    YJSocialSecurityView *headerView = [YJSocialSecurityView socialSecurityView];
    //    _headerView = headerView;
    headerView.socialSecurityModel = self.socialSecurityModel;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTopViewHeight);
    

    v.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTopViewHeight+10);

    [v addSubview:headerView];
    v.backgroundColor = RGB(245, 245, 245);
    self.tableView.tableHeaderView = v;
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.backgroundColor = YJColor(245, 245, 245);
//    self.tableView.sectionHeaderHeight = 10;
//    self.tableView.sectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 165;

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.socialSecurityModel.insurances.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJInsuranceCell *cell = [YJInsuranceCell insuranceCellWithTableView:tableView];
    
    cell.insurances = self.socialSecurityModel.insurances[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.detailOption = ^(int tag) {
        [weakSelf showDetailVc:tag];
    };
    return cell;
}

- (void)showDetailVc:(int)tag {
    YJSocialSecurityDetailsVC *vc = [[YJSocialSecurityDetailsVC alloc] init];
    NSArray *tempArray = nil;
    NSString *stringType = nil;

    switch (tag) {
        case 1:
        {
            tempArray = self.socialSecurityModel.pensionDetails;
            stringType = @"养老保险";
            break;
        }
        case 2:
        {
            tempArray = self.socialSecurityModel.medicareDetails;
            vc.isMaternity = YES;
            stringType = @"医疗保险";
            break;
        }
        case 3:
        {
            tempArray = self.socialSecurityModel.jobSecurityDetails;

            stringType = @"失业保险";
            break;
        }
        case 4:
        {
            tempArray = self.socialSecurityModel.employmentInjuryDetails;

            stringType = @"工伤保险";
            break;
        }
        case 5:
        {
            tempArray = self.socialSecurityModel.maternityDetails;

            stringType = @"生育保险";
            break;
        }
        default:
        {
            break;
        }
    }
    vc.insuranceDataArr = tempArray;
    vc.title = [stringType stringByAppendingString:@"存缴明细"];
    [self.navigationController pushViewController:vc animated:YES];
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
