//
//  YJReportCarInsurancTypeVC.m
//  CreditPlatform
//
//  Created by yj on 2016/11/1.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportNetbankBillTypeVC.h"
#import "YJCarInsurancTypeCell.h"
#import "YJEBankBillModel.h"
#import "YJNetBankBillTool.h"
#import "YJReportNetbankBillDetailsVC.h"
@interface YJReportNetbankBillTypeVC ()
{
    NSIndexPath *_currentIndexPath;
    
    YJNetBankBillTool *_netBankBillTool;
}
@property (nonatomic, strong) NSArray *dataSource;
@property(strong,nonatomic) YJNODataView * NODataView;

@property (nonatomic, strong) YJEBankBillModel *eBankBillModel;

@end

@implementation YJReportNetbankBillTypeVC
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
    
    self.title = @"网银流水报告";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = RGB_pageBackground;
    self.tableView.rowHeight = 45;
    
    
    
    switch (self.searchConditionModel.type) {
        case YJGoToSearchResultTypeFromHome:
            [self laodCarInsuranceData];
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
    [_netBankBillTool removeTimer];
    
}



#pragma mark - 记录 网络
-(void)checkDetailReport{
    __weak typeof(self) weakSelf = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    NSDictionary *dicParams =@{@"method" : urlJK_recordDetailProcess,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"reportId":self.searchConditionModel.ID,
                               @"appVersion": VERSION_APP_1_4_2};
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_recordDetailProcess] params:dicParams success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            
            if (![responseObj[@"data"][@"data"] isKindOfClass:[NSNull class]]) {
                
                weakSelf.eBankBillModel = [YJEBankBillModel mj_objectWithKeyValues:responseObj[@"data"][@"data"]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [YJCreditWaitingView yj_hideWaitingViewForView:weakSelf.view animated:YES];
                    [weakSelf creatUI];
                });
            }
            
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.view makeToast:@"暂无数据"];
                [weakSelf jOutSelf];
            });
            
        }
        
        
    } failure:^(NSError *error) {
        //统一展示，
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJCreditWaitingView yj_hideWaitingViewForView:weakSelf.view animated:YES];
            [weakSelf.view makeToast:errorInfo];
            [weakSelf jOutSelf];
        });
        
    }];
}
#pragma mark - 首页 网络
- (void)laodCarInsuranceData{
    __weak typeof(self) weakSelf = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    
    _netBankBillTool = [[YJNetBankBillTool alloc] init];
    _netBankBillTool.searchConditionModel = self.searchConditionModel;
    _netBankBillTool.searchType = self.searchType;
    
    _netBankBillTool.searchFailure = ^(NSError *error) {
        
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
    
    
    [_netBankBillTool netBankBillDataSuccesssuccess:^(id responseObj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJCreditWaitingView yj_hideWaitingViewForView:self.view animated:YES];
            
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {

                weakSelf.eBankBillModel = [YJEBankBillModel mj_objectWithKeyValues:responseObj[@"data"][@"data"]];
                
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
    
//    if (self.dataSource.count == 0) {
//        [self.view addSubview:self.NODataView];
//        return;
//    } else {
//        [self.NODataView removeFromSuperview];
//    }
    
    
    
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
    lb.text = @"卡号";
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
    
    return self.eBankBillModel.cards.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJCarInsurancTypeCell *cell = [YJCarInsurancTypeCell carInsurancTypeCellWithTableView:tableView];
    
    YJEBankCards *eBankCards = self.eBankBillModel.cards[indexPath.row];
    
    cell.typeLB.text = [NSString decodeCredit:self.eBankBillModel.bankCode];
    
    cell.eBankCards = eBankCards ;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YJEBankCards *selectedModel = self.eBankBillModel.cards[_currentIndexPath.row];
    selectedModel.isSelected = NO;

    YJEBankCards *currentModel = self.eBankBillModel.cards[indexPath.row];
    currentModel.isSelected = YES;
    
    _currentIndexPath = indexPath;
    [self.tableView reloadData];
    
    // 跳转控制器
    YJReportNetbankBillDetailsVC *DetailsVC = [[YJReportNetbankBillDetailsVC alloc] init];
    DetailsVC.eBankBillModel = self.eBankBillModel;
    DetailsVC.index = (int)indexPath.row;
    [self.navigationController pushViewController:DetailsVC animated:YES];
    
    
}


-(void)outself{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    //    __weak typeof(self) weakSelf = self;
    
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"取消" style:(UIPreviewActionStyleDestructive) handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    
    return @[action];
}



@end
