//
//  YJBaseListViewController.m
//  BackgroundCheck
//
//  Created by yj on 2017/9/19.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "YJBaseListViewController.h"
#import "YJSearchResultViewController.h"

#import "LoginVC.h"
#import "YJReportListCell.h"

#import <CommonCrypto/CommonDigest.h>
#import "YJAuthorizationViewController.h"
#import "YJAuthTipModalView.h"
#import "YJNODataView.h"
#import "YJStartSearchViewController.h"
#import "LMZXBaseSearchDataTool.h"
#import "YJListModel.h"
#import "LMBaseReportViewController.h"
@interface YJBaseListViewController ()<UIViewControllerPreviewingDelegate>
{
    UISearchBar *_searchBar;
    UIButton *_searchBarBtn;
    UIView *_startSearchView;
    YJRefreshGifHeader *_refreshGifHeader;
    MJRefreshFooter *_refreshFooter;
    LMZXBaseSearchDataTool *_searchDataTool;
    
    int _currentPage;
    BOOL _isMore;
    //LMZXSDK * _lmzxSDK;

}
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) YJAuthTipModalView *authTipModalView;


@end

@implementation YJBaseListViewController

static NSString *cellID = @"YJReportListCellID";

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (YJAuthTipModalView *)authTipModalView {
    if (_authTipModalView == nil) {
        _authTipModalView = [[YJAuthTipModalView alloc] init];
    }
    return _authTipModalView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"YJReportListCell" bundle:nil] forCellReuseIdentifier:cellID];
    
    

        self.tableView.rowHeight = 140.0 + 10;

    
    [self setupRefreshControl];
    [_refreshGifHeader beginRefreshing];
    [self setupNODataSearchView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showView) name:YJNotificationUserLogout object:nil];
    
    
}
#pragma mark---监听到退出登录调用
-(void)showView{
    self.dataArray = nil;
    [_searchBarBtn removeFromSuperview];
    _searchBarBtn = nil;
    self.tableView.tableFooterView= nil;
    _searchBar = nil;
    [self setupNODataSearchView];
    
    [_refreshGifHeader beginRefreshing];
    [self.tableView reloadData];
    
}
#pragma mark--当有记录时创建
- (void)creatUI {
    if (_startSearchView.superview) {
        [_startSearchView removeFromSuperview];
    }
    
    [self setupSearchBar];
    //    [self setupFooterNODataView];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}


- (void)setupSearchBar {
    if (_searchBarBtn == nil) {
        _searchBarBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _searchBarBtn.backgroundColor = RGB_pageBackground;
        _searchBarBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
//        [_searchBarBtn setTitle:@"搜索" forState:(UIControlStateNormal)];
//        [_searchBarBtn setTitle:@"搜索" forState:(UIControlStateHighlighted)];
//        [_searchBarBtn setImage:[UIImage imageNamed:@"icon_search"] forState:(UIControlStateNormal)];
//        [_searchBarBtn setImage:[UIImage imageNamed:@"icon_search"] forState:(UIControlStateHighlighted)];
//        [_searchBarBtn setTitleColor:RGB_grayPlaceHoldText forState:(UIControlStateNormal)];
//        [_searchBarBtn setTitleColor:RGB_grayPlaceHoldText forState:(UIControlStateHighlighted)];
//        [_searchBarBtn setBackgroundColor:RGB_white];
//        _searchBarBtn.layer.borderWidth = 0.5;
//        _searchBarBtn.layer.borderColor = RGB(204, 204, 204).CGColor;
//        _searchBarBtn.layer.cornerRadius = 3;
//        _searchBarBtn.clipsToBounds = YES;
        
        [_searchBarBtn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"搜索";
        _searchBar.contentMode = UIViewContentModeCenter;
        _searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        _searchBar.barTintColor = RGB_pageBackground;
        _searchBar.userInteractionEnabled = NO;
        UIImageView *view = [[[_searchBar.subviews objectAtIndex:0] subviews] firstObject];
        view.layer.borderColor = RGB_pageBackground.CGColor;
        view.layer.borderWidth = 1;

        for (UIView *sonV in _searchBar.subviews) {
            if (sonV.subviews.count) {
                for (UIView *vv in sonV.subviews) {
                    if ([vv isKindOfClass:[UITextField class]]) {
                        UITextField *tf = (UITextField *)vv;
                        tf.layer.borderWidth = 0.5;
                        tf.layer.borderColor = RGB(204, 204, 204).CGColor;
                        tf.layer.cornerRadius = 3;
                        tf.clipsToBounds = YES;
                        tf.textAlignment = NSTextAlignmentCenter;
                        break;
                    }
                }
            }
        }
        [_searchBarBtn addSubview:_searchBar];
        self.tableView.tableHeaderView = _searchBarBtn;
    }
    
    
    
}
/**
 *  设置刷新控件
 */
- (void)setupRefreshControl {
    
    __weak typeof(self) sself = self;
    
    // 下拉刷新
    _refreshGifHeader = [YJRefreshGifHeader yj_headerWithRefreshingBlock:^{
        
        // 加载数据
        _isMore = NO;
        [sself sendNetWorking];
        
    }];
    
    
    self.tableView.mj_header = _refreshGifHeader;
    
    
    _refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _isMore = YES;
        [sself sendNetWorking];
    }];
    _refreshFooter.hidden = YES;
    self.tableView.mj_footer = _refreshFooter;
    
}

/**
 *  底部无数据提示
 */
- (void)setupFooterNODataView {
    
    
    UILabel *noDataLB = [[UILabel alloc] init];
    noDataLB.text = @"没有更多数据了";
    noDataLB.textAlignment = NSTextAlignmentCenter;
    noDataLB.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    noDataLB.font = Font15;
    noDataLB.textColor = RGB_grayPlaceHoldText;
    UIView *bgView = [[UIView alloc] init];
    [bgView addSubview:noDataLB];
    self.tableView.tableFooterView = bgView;
}

#pragma mark---跳转控制器
- (void)click {
    
    YJSearchResultViewController *resultVC = [[YJSearchResultViewController alloc] init];
    resultVC.searchType = self.searchType;
    
    [self.parentViewController.navigationController pushViewController:resultVC animated:YES];
    
    
}

#pragma mark---数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    YJReportListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        cell.listModel = self.dataArray[indexPath.row];
        [self isForceTouchCapabilityAvailableWithSourceView:cell];
        
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 不
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LMBaseReportViewController *vc = [[LMBaseReportViewController alloc] init];
    vc.UID = [self.dataArray[indexPath.row] UID];
    [self.navigationController pushViewController:vc animated:YES];
}




/**
 判断3DTouch是否可用
 */
- (void)isForceTouchCapabilityAvailableWithSourceView:(UIView *)view {
    if (iOS9_OR_LATER) {
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [self registerForPreviewingWithDelegate:self sourceView:view];
            
        }
    }
}



#pragma mark - 网络
- (void)sendNetWorking {
    
    if (!kUserManagerTool.isLogin) {
        [_refreshGifHeader endRefreshing];
        return;
    }
    
    
    
    
    
    
    
    if (_isMore) {
        _currentPage++;
//        if (_currentPage > [_recordModel.pages intValue]) {
//            
//            [_refreshFooter endRefreshingWithNoMoreData];
//            return ;
//        }
        
    } else{
        _currentPage = 1;
    }
    
    NSString *currentPageStr = [NSString stringWithFormat:@"%d",_currentPage];
    
    __weak typeof(self) weakSelf = self;
    
   
    
    
    
    _searchDataTool = [LMZXBaseSearchDataTool searchDataTool];
    LMBCSearchType type = LMBCSearchTypeBasic;
    if (_searchType) {
        type = LMBCSearchTypeStandard;
    }
    
    
    [_searchDataTool searchAllListWithType:(type) crrentPage:currentPageStr  requestName:@"" success:^(id obj) {
        [_refreshGifHeader endRefreshing];
        [_refreshFooter endRefreshing];
        MYLog(@"=====:::::%@",obj);
        [weakSelf.dataArray removeAllObjects];
        
        weakSelf.dataArray = [YJListModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
        
        if (weakSelf.dataArray.count) {
            [weakSelf creatUI];
        }
        
        [weakSelf.tableView reloadData];

        
        
    } failure:^(NSString *error) {
         MYLog(@"=====:::::%@",error);
        [_refreshGifHeader endRefreshing];
        [_refreshFooter endRefreshing];
        
    }];
    
//    _searchDataTool.searchSuccess(<#id obj#>)
}






- (void)setupNODataSearchView {
    if (_startSearchView == nil) {
        _startSearchView = [[UIView alloc] init];
        _startSearchView.backgroundColor = RGB_clear;
        _startSearchView.frame = CGRectMake(0, -50, SCREEN_WIDTH, kScreenH-64);
        YJNODataView *noDataView = [YJNODataView NODataView:(NODataTypeRedNormal)];
        [_startSearchView addSubview:noDataView];

        
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame =CGRectMake((SCREEN_WIDTH-200)*0.5, 200+64+20, 200, 45);
        [btn setTitle:@"开始查询" forState:(UIControlStateNormal)];
        btn.layer.cornerRadius = 2;
        btn.layer.masksToBounds = YES;
        [btn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
        [btn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
        [btn setTitleColor:RGB_white forState:UIControlStateNormal];
        [btn setTitleColor:RGB_white forState:UIControlStateHighlighted];
        [_startSearchView addSubview:btn];
        [btn addTarget:self action:@selector(startSearchBtnClcik) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    [self.view addSubview:_startSearchView];

    
    
}

/**
 *  开始查询
 */
- (void)startSearchBtnClcik {
    
    
    if (!kUserManagerTool.isLogin) {
        
        LoginVC *vv =[[LoginVC alloc] init];
        //        vv.isFrom = 103;
        JENavigationController *nav = [[JENavigationController alloc] initWithRootViewController:vv];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
//    __weak typeof(self) weakSelf = self;
//    if ([kUserManagerTool.authStatus intValue] != 20){// 资质认证
//        [self.authTipModalView showInRect:self.view.frame];
//
//        self.authTipModalView.authBlock = ^(){
//            YJAuthorizationViewController  *VC = [[YJAuthorizationViewController alloc] init];
//
//            [weakSelf.navigationController pushViewController:VC animated:YES];
//        };
//
//        return;
//
//    }
    
    YJStartSearchViewController *startVc = [[YJStartSearchViewController alloc] init];
    startVc.type = _searchType;
    [self.navigationController pushViewController:startVc animated:YES];
    
    
    
}






@end
