//
//  YJReportDishonestyDetailsVC.m
//  CreditPlatform
//
//  Created by yj on 2016/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportDishonestyDetailsVC.h"
#import "YJFilingTimeCell.h"
#import "reportDishonestyModel.h"
#import "YJDishonestyInfoVC.h"
@interface YJReportDishonestyDetailsVC ()
{
    NSIndexPath *_currentIndexPath;

    CommonSearchDataTool *_commonSearchDataTool;
}
@property (nonatomic, strong) NSArray *dataSource;
@property(strong,nonatomic) YJNODataView * NODataView;

@end

@implementation YJReportDishonestyDetailsVC
- (YJNODataView *)NODataView {
    if (_NODataView == nil) {
        _NODataView = [YJNODataView NODataView:(NODataTypeRedNormal)];
        
    }
    return _NODataView;
}



- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray array];
        
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"失信被执行报告";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = RGB_pageBackground;
    self.tableView.rowHeight = 45;
    
    
    
    switch (self.searchConditionModel.type) {
        case YJGoToSearchResultTypeFromHome:
            [self laodDishonestData];
            break;
        case YJGoToSearchResultTypeFromRecord:
            if ([self.recodeType isEqualToString:kBizType_shixin]) {
                self.searchType = SearchItemTypeLostCredit;
            }
            
            [self checkDetailReport];
            break;
            
        default:
            break;
    }
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_commonSearchDataTool removeTimer];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
}


#pragma mark - 记录 网络
-(void)checkDetailReport{
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    NSDictionary *dicParams =@{@"method" : urlJK_recordDetailProcess,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"reportId":self.searchConditionModel.ID,
                               @"appVersion": VERSION_APP_1_4_0};
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_recordDetailProcess] params:dicParams success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            
            if (![responseObj[@"data"][@"data"] isKindOfClass:[NSNull class]]) {
                sself.dataSource = [reportDishonestyModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"][@"data"][@"dishonests"]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
                    [sself creatUI];
                });
            }
            
            
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
- (void)laodDishonestData {
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    
    _commonSearchDataTool = [[CommonSearchDataTool alloc] init];
    _commonSearchDataTool.searchConditionModel = self.searchConditionModel;
    
    _commonSearchDataTool.searchType = self.searchType;
    _commonSearchDataTool.method = urlJK_queryShixin;
    _commonSearchDataTool.version = VERSION_APP_1_4_0;
    
    
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
            
            if (![obj[@"data"][@"data"] isKindOfClass:[NSNull class]]) {
                sself.dataSource = [reportDishonestyModel mj_objectArrayWithKeyValuesArray:obj[@"data"][@"data"][@"dishonests"]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
                    [sself creatUI];
                    
                });
            }
            
            
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
    
    if (self.dataSource.count == 0) {
        [self.view addSubview:self.NODataView];

        return;
    } else {
        [self.NODataView removeFromSuperview];
    }
    
    [self setupHeaderView];
    
    [self.tableView reloadData];

}

- (void)setupHeaderView {
    // 头部标题
    UIView *v = [[UIView alloc] init];
    v.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = RGB_grayLine;
    topLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    [v addSubview:topLine];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.font = Font18;
    lb.text = @"立案时间";
    lb.textAlignment = NSTextAlignmentLeft;
    lb.frame = CGRectMake(15, 0.5, SCREEN_WIDTH, 45-0.5);
    

    
    [v addSubview:lb];
    v.backgroundColor = RGB_white;
    self.tableView.tableHeaderView = v;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    
    // 底部分割线
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = RGB_grayLine;
    bottomLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    self.tableView.tableFooterView = bottomLine;
    
    
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJFilingTimeCell *cell = [YJFilingTimeCell filingTimeCellWithTableView:tableView];
    cell.reportDishonestyModel = self.dataSource[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    reportDishonestyModel *selectedModel = self.dataSource[_currentIndexPath.row];
    selectedModel.isSelected = NO;
    
    reportDishonestyModel *currentModel = self.dataSource[indexPath.row];
    currentModel.isSelected = YES;
    
    _currentIndexPath = indexPath;
    [self.tableView reloadData];
    
    // 跳转控制器
    YJDishonestyInfoVC *dishonestyInfoVC = [[YJDishonestyInfoVC alloc] init];
    dishonestyInfoVC.reportDishonestyModel = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:dishonestyInfoVC animated:YES];
    
    
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
