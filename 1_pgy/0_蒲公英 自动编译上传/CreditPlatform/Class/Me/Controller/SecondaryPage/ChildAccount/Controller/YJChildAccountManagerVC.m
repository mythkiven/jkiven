//
//  YJChildAccountManagerVC.m
//  CreditPlatform
//
//  Created by yj on 2016/11/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJChildAccountManagerVC.h"
#import "YJChildAccountListCell.h"
#import "YJChildAccountListModel.h"
#import "YJCreateChildAccountVC.h"
#import "YJChildAccountInfoVC.h"
#import "YJRefreshGifHeader.h"

@interface YJChildAccountManagerVC ()
{
//    MJRefreshGifHeader *_refreshGifHeader;
    
    YJRefreshGifHeader *_refreshGifHeader;
    
}
@property (nonatomic, strong) NSArray *childAccountList;

@property (nonatomic, strong) YJNODataView *noDataView;

@property (nonatomic, strong) UIButton *greeBtn;

/**
 控制是否刷新数据
 */
@property (nonatomic, assign) BOOL isRefresh;

@end

@implementation YJChildAccountManagerVC

- (YJNODataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [YJNODataView NODataView:(NODataTypeChildAccount)];
    }
    return _noDataView;
}
- (UIButton *)greeBtn {
    if (!_greeBtn) {
        _greeBtn = [UIButton greeButtonWithTitle:@"创建子账号" target:self action:@selector(createChildAccount)];
        _greeBtn.frame = CGRectMake(kMargin_15, 200 + 64 + 90, SCREEN_WIDTH-kMargin_15*2, 45);
    }
    return _greeBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad]; 
    self.title = @"子账户管理";
    self.tableView.rowHeight = 75;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"创建" style:(UIBarButtonItemStyleDone) target:self action:@selector(createChildAccount)];
    
    _isRefresh = YES;
    
    [self setupRefreshControl];
    
}

/**
 *  设置刷新控件
 */

- (void)setupRefreshControl {
    __weak typeof(self) weakSelf = self;
    
    // 下拉刷新
    _refreshGifHeader = [YJRefreshGifHeader yj_headerWithRefreshingBlock:^{
        [weakSelf loadChildAccountData];
    }];

    self.tableView.mj_header = _refreshGifHeader;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_refreshGifHeader.isRefreshing) {
        return;
    }
    
    if (_isRefresh) {
        [_refreshGifHeader beginRefreshing];
    } else {
        _isRefresh = YES;
    }

}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

}




#pragma mark  加载数据
- (void)loadChildAccountData {
    // 获取是否有空数据
    NSDictionary *dict = @{@"method" :      urlJK_queryUserOperatorList,
                           @"mobile" :      kUserManagerTool.mobile,
                           @"userPwd" :     kUserManagerTool.userPwd,
                           @"appVersion":   VERSION_APP_1_4_1,
                           @"status" : @""
                           };
    
    __weak typeof(self) weakSelf = self;
    [weakSelf.noDataView removeFromSuperview];
    [weakSelf.greeBtn removeFromSuperview];
    
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryUserOperatorList] params:dict success:^(id obj) {
        MYLog(@"子账号列表%@",obj);
        
        if (![obj[@"list"] isKindOfClass:[NSNull class]]) {
            
           weakSelf.childAccountList = [YJChildAccountListModel mj_objectArrayWithKeyValuesArray:obj[@"list"]];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_refreshGifHeader endRefreshing];
            
            if (weakSelf.childAccountList.count == 0) {
                [weakSelf.tableView addSubview:weakSelf.noDataView];
                [weakSelf.tableView addSubview:weakSelf.greeBtn];
                
            }
            
            [weakSelf.tableView reloadData];

            

            
        });
        
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_refreshGifHeader endRefreshing];
            
            [self.view makeToast:@"请求失败，请重试！"];

        });
        
    }];
    
}

#pragma mark--》创建子账号
- (void)createChildAccount {
    YJCreateChildAccountVC *VC = [[YJCreateChildAccountVC alloc] init];
    VC.cancelBlock = ^() {
        MYLog(@"------取消创建子账号");
        _isRefresh = NO;
    };
    
    YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:VC];
//    [self.navigationController pushViewController:VC animated:YES];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.childAccountList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJChildAccountListCell *cell = [YJChildAccountListCell childAccountListCellWithTableView:tableView];
    cell.listModel = self.childAccountList[indexPath.row];
    
    if (indexPath.row == self.childAccountList.count - 1) {
        cell.bottomLine.hidden = NO;
    } else {
        cell.bottomLine.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YJChildAccountInfoVC *vc = [[YJChildAccountInfoVC alloc] init];
    vc.childAccountModel = self.childAccountList[indexPath.row];
    vc.cancelBlock = ^() {
        MYLog(@"------取消修改子账号");
        _isRefresh = NO;
    };
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}


@end
