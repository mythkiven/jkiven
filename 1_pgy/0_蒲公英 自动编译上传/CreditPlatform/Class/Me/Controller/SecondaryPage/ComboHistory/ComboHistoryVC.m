//
//  ComboHistory.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ComboHistoryVC.h"
#import "ComboHistoryCell.h"

#import "DatePickerManager.h"
#import "PurchaseHistoryTopNavView.h"
#import "PurchaseHistoryTopPullType.h"
#import "PurchaseHistoryTopPullTypeModel.h"
#import "PurchaseHistoryTopPullTime.h"
 
#import "YJComboPurchaseHisModel.h"
#import "YJTopMenuToolBar.h"
#import "YJStatisticsLabel.h"
#import "YJComboPurchaseDetailsVC.h"
@interface ComboHistoryVC ()<UITableViewDelegate,UITableViewDataSource>
{

    // 下拉刷新
    YJRefreshGifHeader *_refreshGifHeader;
    
    MJRefreshFooter *_refreshFooter;
    
    YJComboPurchaseHisModel *_comboModel;//本页数据的model
    
    NSString *_startDate;//开始时间
    NSString *_endDate;//结束时间
    NSString *_packageId;//选择套餐的类型
    
    int _currentPage;
    int _totalPages;
    BOOL _isMore;
    
}

@property (nonatomic, strong) NSMutableArray *dataSource;

@property(strong,nonatomic) YJNODataView * NODataView;

@property(strong,nonatomic) UITableView * tableView;

@property(strong,nonatomic) YJTopMenuToolBar *topMenuToolBar;



@property(strong,nonatomic) YJStatisticsLabel * bottomLB;

@end

@implementation ComboHistoryVC
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
 下拉菜单
 */
- (YJTopMenuToolBar *)topMenuToolBar {
    if (!_topMenuToolBar) {
        _topMenuToolBar = [[YJTopMenuToolBar alloc] init];
        _topMenuToolBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTopMenuToolBarH);
        _topMenuToolBar.menuType = YJMenuTypeComboPurchase;
        _topMenuToolBar.isHasToday = NO;
        [self.view bringSubviewToFront:_topMenuToolBar];
        _topMenuToolBar.contentView = self.view;
    }
    return _topMenuToolBar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40 - 50-64) style:(UITableViewStylePlain)];
        _tableView.showsVerticalScrollIndicator = YES;
//            _tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
        _tableView.rowHeight = 75;
        //    _tableView.sectionHeaderHeight = 10;
        //    _tableView.sectionFooterHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
    self.title = @"套餐消费";
    self.view.backgroundColor = RGB_pageBackground;
    
    _currentPage = 1;
    _packageId = @"";
    _startDate = [self dateStrWithMonthSinceNow:-3];
    _endDate = [self dateStrWith:[NSDate date]];
    
    // tableview
    [self.view addSubview:self.tableView];

    
    // 下拉菜单
    [self.view addSubview:self.topMenuToolBar];
    

    // 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(apiTypeDidChange:) name:YJApiTypeDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateDidChange:) name:YJDateDidChangeNotification object:nil];
    
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

#pragma mark--监听到类型改变
- (void)apiTypeDidChange:(NSNotification *)noti {
    
    _packageId = noti.userInfo[@"packageId"];
    [_refreshGifHeader beginRefreshing];
    
}
#pragma mark--监听到时间改变
- (void)dateDidChange:(NSNotification *)noti {
    _startDate = noti.userInfo[@"startDate"];
    _endDate = noti.userInfo[@"endDate"];
    [_refreshGifHeader beginRefreshing];
    
    
}



#pragma mark - Table view Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ComboHistoryCell *cell = [ComboHistoryCell comboHistoryCellWithTableView:tableView];
    
    cell.comboPurchaseList = self.dataSource[indexPath.row];
    if (indexPath.row == self.dataSource.count-1) {
        cell.bottomLine.hidden = NO;
    } else {
        cell.bottomLine.hidden = YES;
    }
    
    return cell;
    
    
    
}
#pragma mark - Table view Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    YJComboPurchaseDetailsVC *comboPurcjhaseDetailsVC = [[YJComboPurchaseDetailsVC alloc] init];
    YJComboPurchaseList *listModel = self.dataSource[indexPath.row];
    if ([listModel.servicePackageType integerValue] == 2) {//打包价
        comboPurcjhaseDetailsVC.comboPurchaseType =  ComboPurchaseTA;
    } else if ([listModel.servicePackageType integerValue] == 3) {//梯度价
        comboPurcjhaseDetailsVC.comboPurchaseType =  ComboPurchaseTB;
    }
    comboPurcjhaseDetailsVC.packConsuId = listModel.id;
    
    [self.navigationController pushViewController:comboPurcjhaseDetailsVC animated:YES];
    
    
    
    
}




#pragma mark  -
#pragma mark  - 设置刷新控件
- (void)setupRefreshControl {

    
    __block typeof(self) sself = self;
    // 下拉刷新
    _refreshGifHeader = [YJRefreshGifHeader yj_headerWithRefreshingBlock:^{
        // 加载数据
        _isMore = NO;
        [sself refreshData];
        
        _refreshFooter.hidden = YES;
        
    }];

    _tableView.mj_header = _refreshGifHeader;
    
    
    // 上拉加载更多
   _refreshFooter = [ MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       _isMore = YES;
        [sself refreshData];
    }];
    _refreshFooter.hidden = YES;
    _tableView.mj_footer = _refreshFooter;

    
}

#pragma mark--刷新数据
- (void)refreshData {
    
    if (_isMore) {
        _currentPage++;
    } else {
        _currentPage = 1;
        
    }
    
    NSString *currentPageStr = [NSString stringWithFormat:@"%d",_currentPage];
    
    NSString *spileTime = @"";
    
    if (_comboModel.comboPurchaseData.spileTime && (_currentPage != 1)) {
        spileTime = _comboModel.comboPurchaseData.spileTime;
    }
    
    // 获取是否有空数据
    NSDictionary *dict = @{@"method" :      urlJK_appPackconsu,
                           @"mobile" :      kUserManagerTool.mobile,
                           @"userPwd" :     kUserManagerTool.userPwd,
                           @"appVersion":   VERSION_APP_1_4_0,
                           @"startDate":    _startDate,
                           @"endDate":      _endDate,
                           @"pageNumber": currentPageStr,
                           @"pageSize":@"20",
                           @"spileTime":spileTime,
                           @"packageId" : _packageId
                           };
    MYLog(@"-------%@",dict);
    
    __weak typeof(self) weakSelf = self;
    if (!_isMore) {
        [self.bottomLB hide:^{
            [UIView animateWithDuration:.2 animations:^{
                weakSelf.tableView.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40-64);
            }];
            
        }];
    }
   
    [self.NODataView removeFromSuperview];
    
//    if (self.dataSource.count != 0 && [_comboModel.comboPurchaseData.consuCount intValue] == self.dataSource.count) {
//        [_refreshFooter endRefreshingWithNoMoreData];
//        [_refreshGifHeader endRefreshing];
//        return;
//    }
    
    
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_appPackconsu] params:dict success:^(id obj) {
        
        if (_currentPage == 1) {
            // 刷新数据，先清空
            [self.dataSource removeAllObjects];
        }
        
        MYLog(@"套餐消费列表-----:%@",obj);
        _comboModel= [YJComboPurchaseHisModel mj_objectWithKeyValues:obj];
        
        
        [weakSelf.dataSource addObjectsFromArray:_comboModel.list];


        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_refreshGifHeader endRefreshing];
            [_refreshFooter endRefreshing];
            
            if (weakSelf.dataSource.count == 0) { // 无数据
                
                [weakSelf.tableView addSubview:weakSelf.NODataView];
                
            } else if (_comboModel.list.count == 0){ // 上拉加载无数据
                [_refreshFooter endRefreshingWithNoMoreData];
                
            }else { // 有数据
                _refreshFooter.hidden = NO;
                
                // 显示底部统计
                [weakSelf.bottomLB show:^{
                    [UIView animateWithDuration:.2 animations:^{
                        weakSelf.tableView.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40-50-64);
                    }];
                }];
                
                [weakSelf.bottomLB setStatisticsType:@"套餐消费" Count:_comboModel.comboPurchaseData.consuCount amt:_comboModel.comboPurchaseData.consuAmt];
                
                if (weakSelf.dataSource.count == [_comboModel.comboPurchaseData.consuCount intValue]) {
                    [_refreshFooter endRefreshingWithNoMoreData];

                }
                
            }
            [weakSelf.tableView reloadData];

            
            
        });
        
        
        
        
    } failure:^(NSError *error) {
        MYLog(@"套餐列表失败：%@",error.localizedDescription);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_refreshGifHeader endRefreshing];
            [_refreshFooter endRefreshing];
//            _refreshFooter.hidden = NO;
            
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
