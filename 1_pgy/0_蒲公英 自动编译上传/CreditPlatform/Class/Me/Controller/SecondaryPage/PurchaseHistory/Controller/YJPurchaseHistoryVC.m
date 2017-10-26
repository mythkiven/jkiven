//
//  YJPurchaseHistoryVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJPurchaseHistoryVC.h"
#import "YJPurchaseHistoryCell.h"

#import "DatePickerManager.h"
#import "PurchaseHistoryTopNavView.h"
#import "PurchaseHistoryTopPullType.h"
#import "PurchaseHistoryTopPullTypeModel.h"
#import "PurchaseHistoryTopPullTime.h"

#import "PurchaseHistoryModel.h"
#import "YJTopMenuToolBar.h"
#import "YJStatisticsLabel.h"
#import "YJRefreshGifHeader.h"
#import "YJPurchaseHistoryModel.h"

@interface YJPurchaseHistoryVC ()<UITableViewDelegate,UITableViewDataSource>
{
  
    // 下拉刷新
//    MJRefreshGifHeader *_refreshGifHeader;
    YJRefreshGifHeader *_refreshGifHeader;
    MJRefreshFooter *_refreshFooter;
    
    int _currentPage;
    BOOL _isMore;

    PurchaseHistoryOutModel *_listModel;//本页数据的model

    NSMutableArray *navTypeData;//网络请求的类型数据
    NSMutableArray *RecodeData;//本页数据model源
    

    UILabel *_bottomLabel;//底部label
    UIView *_line;//底部label
    
    NSString *_startDate;//开始时间
    NSString *_endDate;//结束时间
    NSString *_apiType;//选择的类型
    NSString *_userOperatorName;// 子账号的名称
    //    UITableView * _tableView;
    
    YJTopMenuToolBar *_topMenuToolBar;
    
    YJPurchaseHistoryModel *_purchaseHistoryModel;
    
    
}
@property(strong,nonatomic) UITableView * tableView;

@property(strong,nonatomic) UITableView * navTableView;//顶部type视图

@property(strong,nonatomic) PurchaseHistoryTopNavView * pnavView;//顶部导航视图

@property(strong,nonatomic) YJNODataView * NODataView;


@property(strong,nonatomic) YJTopMenuToolBar *topMenuToolBar;


@property(strong,nonatomic) YJStatisticsLabel * bottomLB;

@end

@implementation YJPurchaseHistoryVC
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/**
 统计消费详情
 */
- (YJStatisticsLabel *)bottomLB {
    if (!_bottomLB) {
        _bottomLB = [[YJStatisticsLabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-64, SCREEN_WIDTH, 50)];
        _bottomLB.contentView = self.view;
    }
    return _bottomLB;
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
/**
 下拉菜单
 */
- (YJTopMenuToolBar *)topMenuToolBar {
    if (!_topMenuToolBar) {
        _topMenuToolBar = [[YJTopMenuToolBar alloc] init];
        _topMenuToolBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTopMenuToolBarH);
        _topMenuToolBar.menuType = YJMenuTypePurchase;
        _topMenuToolBar.isHasToday = YES;
        _topMenuToolBar.isHasChildAccount = ([kUserManagerTool.masterStatus intValue] == 3);
        [self.view bringSubviewToFront:_topMenuToolBar];
        _topMenuToolBar.contentView = self.view;
    }
    return _topMenuToolBar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40 -64) style:(UITableViewStylePlain)];
        _tableView.showsVerticalScrollIndicator = YES;
        //    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
        _tableView.rowHeight = 75;
        //    _tableView.sectionHeaderHeight = 10;
        //    _tableView.sectionFooterHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        self.view.backgroundColor = RGB_pageBackground;
        _tableView.backgroundColor = RGB_pageBackground;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标准消费";
    self.view.backgroundColor = RGB_pageBackground;

    _apiType = @"";
    _userOperatorName = @"";
    _startDate = [self dateStrWithMonthSinceNow:-3];
    _endDate = [self dateStrWith:[NSDate date]];

    RecodeData = [NSMutableArray arrayWithCapacity:0];
    // tableview
    [self.view addSubview:self.tableView];
    
    
    // 下拉菜单
    [self.view addSubview:self.topMenuToolBar];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(apiTypeDidChange:) name:YJApiTypeDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateDidChange:) name:YJDateDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userOperatorIdDidChange:) name:YJUserOperatorIdDidChangeNotification object:nil];
    
    //刷新控件
    [self setupRefreshControl];
    [_refreshGifHeader beginRefreshing];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_topMenuToolBar.dateMenu hide];
}



/**
 *
 *  时间转字符串：yyyy-MM-dd
 */
- (NSString *)dateStrWithMonthSinceNow:(NSInteger)month {
    
    NSDate *now = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:now options:0];
    
    return [self dateStrWith:mDate];
}

/**
 *
 *  时间转字符串：yyyy-MM-dd
 */
- (NSString *)dateStrWith:(NSDate *)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [df stringFromDate:date];
    return dateStr;
}


/**
 类型变化
 */
- (void)apiTypeDidChange:(NSNotification *)noti {
    
    _apiType = noti.userInfo[@"apiType"];
    
    [_refreshGifHeader beginRefreshing];
    
}
/**
 时间变化
 */
- (void)dateDidChange:(NSNotification *)noti {
    _startDate = noti.userInfo[@"startDate"];
    _endDate = noti.userInfo[@"endDate"];

    [_refreshGifHeader beginRefreshing];
    
}

/**
 子账号变化
 */
- (void)userOperatorIdDidChange:(NSNotification *)noti {
    
    _userOperatorName = noti.userInfo[@"userOperatorName"];
    
    [_refreshGifHeader beginRefreshing];
    
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return RecodeData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJPurchaseHistoryCell *cell = [YJPurchaseHistoryCell purchaseHistoryCellWithTableView:tableView];
    cell.listModel = RecodeData[indexPath.row];
    if (indexPath.row == 0) {
        UIView *separateLine = [[UIView alloc] init];
        separateLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
        separateLine.backgroundColor = RGB_grayLine;
        [cell.contentView addSubview:separateLine];
    }
    return cell;
    
}







#pragma mark  -
#pragma mark  - 设置刷新控件
- (void)setupRefreshControl {

    __block typeof(self) sself = self;
    // 下拉刷新
    _refreshGifHeader = [YJRefreshGifHeader yj_headerWithRefreshingBlock:^{
        // 加载数据
//        [sself beginMatchCostListWithDict:oldDic showInd:NO];
        _isMore = NO;
        [sself loadData];
        
    }];
    _tableView.mj_header = _refreshGifHeader;
    
    
    _refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _isMore = YES;
        [sself loadData];
    }];
    _refreshFooter.hidden = YES;
    self.tableView.mj_footer = _refreshFooter;
    
    
    
    
}



#pragma mark  加载数据
- (void)loadData {
    if (_isMore) {
        _currentPage++;
        if (_currentPage > [_purchaseHistoryModel.pageModel.pages intValue]) {
            
            [_refreshFooter endRefreshingWithNoMoreData];
            return ;
        }
        
    } else{
        _currentPage = 1;
    }
    
    NSString *currentPageStr = [NSString stringWithFormat:@"%d",_currentPage];
    
    // 获取是否有空数据
    NSDictionary *dict = @{@"method" :      urlJK_spendRecord,
                           @"mobile" :      kUserManagerTool.mobile,
                           @"userPwd" :     kUserManagerTool.userPwd,
                           @"appVersion":   VERSION_APP_1_4_4,
                           @"apiType":      _apiType,
                           @"userOperatorName": _userOperatorName,
                           @"startDate":    _startDate,
                           @"endDate":      _endDate,
                           @"pageSize":    @"20",
                           @"pageNum":      currentPageStr
                           };
    
    __weak typeof(self) weakSelf = self;
    [self.NODataView removeFromSuperview];
    
    [self.bottomLB hide:^{
        [UIView animateWithDuration:.2 animations:^{
            weakSelf.tableView.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40-64);
        }];
        
    }];
    
    
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_spendRecord] params:dict success:^(id obj) {
        MYLog(@"标准消费%@",obj);
        
        if (_currentPage == 1) {
            [RecodeData removeAllObjects];
            
        }

        if (![obj[@"data"] isKindOfClass:[NSNull class]]) {
            
            _purchaseHistoryModel = [YJPurchaseHistoryModel mj_objectWithKeyValues:obj[@"data"]];
            
            [RecodeData addObjectsFromArray:_purchaseHistoryModel.pageModel.list];
//            RecodeData = [NSMutableArray arrayWithArray:_purchaseHistoryModel.pageModel.list];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_refreshGifHeader endRefreshing];
            [_refreshFooter endRefreshing];
            
            if (RecodeData.count == 0) {
                [weakSelf.tableView addSubview:weakSelf.NODataView];
//                weakSelf.tableView.tableFooterView = [[UIView alloc] init];
                _refreshFooter.hidden = YES;
            } else {
            
                if ([_purchaseHistoryModel.pageModel.isLastPage isEqualToString:@"1"]){
                    [_refreshFooter endRefreshingWithNoMoreData];
                }
                
                _refreshFooter.hidden = NO;
                [weakSelf.bottomLB setStatisticsType:@"消费" Count:_purchaseHistoryModel.consuCount amt:_purchaseHistoryModel.consuAllAmt];
                
                [weakSelf.bottomLB show:^{
                    [UIView animateWithDuration:.2 animations:^{
                        weakSelf.tableView.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40-50-64);
                    }];
                    MYLog(@"--------滚出来。。。。");
                }];
//                [weakSelf setupFooterNODataView];
                
            }
            
            [weakSelf.tableView reloadData];
            
            

        });
        

    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_refreshGifHeader endRefreshing];
            [_refreshFooter endRefreshing];
        });

    }];
    
}

#pragma mark  底部无数据提示
- (void)setupFooterNODataView {
    
    UILabel *noDataLB = [[UILabel alloc] init];
    noDataLB.text = @"没有更多数据了";
    noDataLB.textAlignment = NSTextAlignmentCenter;
    noDataLB.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    noDataLB.font = Font15;
    noDataLB.textColor = RGB_grayPlaceHoldText;
    UIView *bgView = [[UIView alloc] init];
    [bgView addSubview:noDataLB];
    _tableView.tableFooterView = bgView;
}


@end
