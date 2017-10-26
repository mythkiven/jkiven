//
//  YJComboPurcjhaseDetailsVC.m
//  CreditPlatform
//
//  Created by yj on 2016/10/26.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJComboPurchaseDetailsVC.h"
#import "YJComboPurchaseDetModel.h"
#import "YJComboPurchaseDetHeaderView.h"
#import "YJComboPurchaseDetCell.h"
#import "JComboPurchaseBModel.h"
#import "JComboPurchaseBCell.h"

@interface YJComboPurchaseDetailsVC ()
{
    int _currentPage;
    
    // 下拉刷新
    MJRefreshGifHeader *_refreshGifHeader;
    
    MJRefreshFooter *_refreshFooter;
    YJComboPurchaseDetModel *_comboDetModel;
    JComboPurchaseBModel *_comboPurchaseBModel;
    BOOL _isMore;
}


@property(strong,nonatomic) YJNODataView * NODataView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) YJComboPurchaseDetHeaderView *comboHeaderView;



@end

@implementation YJComboPurchaseDetailsVC

- (YJComboPurchaseDetHeaderView *)comboHeaderView {
    if (!_comboHeaderView) {
        _comboHeaderView = [YJComboPurchaseDetHeaderView comboPurchaseDetHeaderView];// 267
        _comboHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 260);

    }
    return _comboHeaderView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

/**
 无数据页面
 */
- (YJNODataView *)NODataView {
    if (_NODataView == nil) {
        _NODataView = [YJNODataView NODataView:(NODataTypepurchase)];
    }
    return _NODataView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单详情";
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.tableFooterView = [[UIView alloc] init];
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    switch (self.comboPurchaseType) {
        case ComboPurchaseTA:{
            self.tableView.rowHeight = 276;
            break;
            
        }case ComboPurchaseTB:{
            self.tableView.rowHeight = 155;
            break;
            
        }default:
            break;
    }
    
    
    [self setupRefreshControl];
    [_refreshGifHeader beginRefreshing];
    
    
    
}

- (void)setupHeaderView {
    
    switch (self.comboPurchaseType) {
        case ComboPurchaseTA:{
            self.comboHeaderView.comboDetModel = _comboDetModel;
            break;
            
        }case ComboPurchaseTB:{
            self.comboHeaderView.jComboPurchaseBDataModel = _comboPurchaseBModel.jComboPurchaseBDataModel;
            break;
            
        }default:
            break;
    }
    
    
    self.tableView.tableHeaderView = self.comboHeaderView;

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.comboPurchaseType) {
        case ComboPurchaseTA:{
            YJComboPurchaseDetCell *cell = [YJComboPurchaseDetCell comboPurchaseDetCellWithTableView:tableView];
            cell.comboDetRow = self.dataSource[indexPath.row];
            cell.index = indexPath.row;
            
            return cell;
            break;
            
        }case ComboPurchaseTB:{
            JComboPurchaseBCell *cell= [JComboPurchaseBCell jComboPurchaseBCellWithTableView:tableView];
            cell.jComboPurchaseBModel = self.dataSource[indexPath.row];
            cell.index = indexPath.row;
            return cell;
            
            break;
            
        }default:
            break;
    }
    
    return nil;
}

#pragma mark  -
#pragma mark  - 设置刷新控件
- (void)setupRefreshControl {
    //
    NSMutableArray *pullImgs = [self animationImagesWithName:@"icon_shake_animation" count:40];
    
    NSMutableArray *shakeImgs = [self animationImagesWithName:@"icon_shake_animation" count:40];
    
    __block typeof(self) sself = self;
    // 下拉刷新
    _refreshGifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        // 加载数据
        _isMore = NO;
        [sself refreshData];
        
        _refreshFooter.hidden = YES;
        
    }];
    
    _refreshGifHeader.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    _refreshGifHeader.stateLabel.hidden = YES;
    
    [_refreshGifHeader setImages:pullImgs forState:(MJRefreshStatePulling)];
    [_refreshGifHeader setImages:shakeImgs forState:(MJRefreshStateRefreshing)];
    self.tableView.mj_header = _refreshGifHeader;
    
    
    // 上拉加载更多
    _refreshFooter = [ MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _isMore = YES;
        [sself refreshData];
    }];
    _refreshFooter.hidden = YES;
    self.tableView.mj_footer = _refreshFooter;
    
    
}

#pragma mark - --刷新数据
- (void)refreshData {
    
    if (_isMore) {
        _currentPage++;
    } else {
        _currentPage = 1;
    }
    
    NSString *currentPageStr = [NSString stringWithFormat:@"%d",_currentPage];
    NSString *spileTime = @"";
    
    if (_comboDetModel.spileTime && (_currentPage != 1)) {
        spileTime = _comboDetModel.spileTime;
    }
    
    NSString *url,*appversion;
    switch (self.comboPurchaseType) {
        case ComboPurchaseTA:{
            url =urlJK_appPackconsuDetl;
            appversion = VERSION_APP_1_4_0;
            break;
            
        }case ComboPurchaseTB:{
    
            url =urlJK_appPackconsuDetlB;
            appversion = VERSION_APP_1_4_1;
            break;
            
        }default:
            break;
    }

    
    // 获取是否有空数据
    NSDictionary *dict = @{@"method" :      url,
                           @"mobile" :      kUserManagerTool.mobile,
                           @"userPwd" :     kUserManagerTool.userPwd,
                           @"appVersion":   appversion,
                           @"pageNumber": currentPageStr,
                           @"pageSize":@"20",
                           @"spileTime":spileTime,
                           @"packConsuId" : self.packConsuId
                           };
    MYLog(@"-------%@",dict);
    
    __weak typeof(self) weakSelf = self;

    
    [self.NODataView removeFromSuperview];
    
    
    
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,url] params:dict success:^(id obj) {
        
        MYLog(@"套餐消费详情-----:%@",obj);
        if (_currentPage == 1) {
            // 刷新数据，先清空
            [weakSelf.dataSource removeAllObjects];
        }
        
        switch (self.comboPurchaseType) {
            case ComboPurchaseTA:{
                _comboDetModel = [YJComboPurchaseDetModel mj_objectWithKeyValues:obj[@"data"]];
                [weakSelf.dataSource addObjectsFromArray:_comboDetModel.rows];
                

                break;
                
            }case ComboPurchaseTB:{
                _comboPurchaseBModel = [JComboPurchaseBModel mj_objectWithKeyValues:obj];
                [weakSelf.dataSource addObjectsFromArray:_comboPurchaseBModel.list];
                
                break;
                
            }default:
                break;
        }
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_refreshGifHeader endRefreshing];
            [_refreshFooter endRefreshing];
            
            if (weakSelf.dataSource.count == 0) { // 无数据
                
                [weakSelf.tableView addSubview:weakSelf.NODataView];
                
            } else if ( !(_comboDetModel.rows.count == 0|_comboPurchaseBModel.list.count==0)){
                // 上拉加载无数据
                
                [_refreshFooter endRefreshingWithNoMoreData];

            } else { // 有数据
                
                _refreshFooter.hidden = NO;
                [weakSelf setupHeaderView];
                
                if (_comboDetModel.rows.count < 20) {
                    
                    [_refreshFooter endRefreshingWithNoMoreData];

                }
                  
            }
            
            [weakSelf.tableView reloadData];
            
        });
        
        
    } failure:^(NSError *error) {
        MYLog(@"套餐失败：%@",error.localizedDescription);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_refreshGifHeader endRefreshing];
            [_refreshFooter endRefreshing];
            //            _refreshFooter.hidden = NO;
            
        });
        
    }];
    
    
}
#pragma mark -  
#pragma mark - -- 底部无数据提示
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
#pragma mark  刷新控件动画组
- (NSMutableArray *)animationImagesWithName:(NSString *)name count:(int)count {
    NSMutableArray *imgArr = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 1; i <= count; i ++) {
        NSString *imgName = [NSString stringWithFormat:@"%@_%d",name,i];
        
        UIImage *img = [UIImage imageNamed:imgName];
        
        [imgArr addObject:img];
    }
    return imgArr;
}

@end
