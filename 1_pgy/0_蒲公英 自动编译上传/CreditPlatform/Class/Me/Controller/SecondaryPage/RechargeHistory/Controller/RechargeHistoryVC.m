//
//  YJPurchaseHistoryVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "RechargeHistoryVC.h"
#import "RechargeHistoryNormalCell.h"
#import "RechargeHistoryPayCell.h"
#import "RechargeNavTypeModel.h"
#import "RechargeNavTypeCell.h"
#import "DatePickerManager.h"
#import "PurchaseHistoryTopNavView.h"
#import "PurchaseHistoryTopPullTime.h"

#import "RechargeHistoryModel.h"
#import "YJAlipayOrder.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YJAlipayManager.h"
#import "YJTopMenuToolBar.h"

#import "WeChatPayManager.h"
#import "YJStatisticsLabel.h"
#import "YJRechargeHistoryModel.h"
static void * ChangeStatusType = &ChangeStatusType;

@interface RechargeHistoryVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    YJRefreshGifHeader *_refreshGifHeader;
    MJRefreshFooter *_refreshFooter;
    
    int _currentPage;
    BOOL _isMore;
    
    YJRechargeHistoryModel *_rechargeHistoryModel;
    
    
    NSMutableArray *navTypeData;//网络请求的类型数据
    NSMutableArray *RecodeData;//网络请求的记录数据
    
    
    
    UILabel *_bottomLabel;//底部label
    UIView *_line;
    
    NSString *_startDate;//开始时间
    NSString *_endDate;//结束时间
    NSString *_statusType;//选择的类型
    
}
@property(strong,nonatomic) UITableView * tableView;

@property(strong,nonatomic) UITableView * navTableView;

@property(copy,nonatomic) NSString *StatusType;
@property(strong,nonatomic) RechargeHistoryOutModel*outModel;//外侧的model
@property(strong,nonatomic) YJNODataView * NODataView;


@property(strong,nonatomic) YJTopMenuToolBar *topMenuToolBar;


@property(strong,nonatomic) YJStatisticsLabel * bottomLB;
@end

@implementation RechargeHistoryVC


#pragma mark 预处理

-(void)dealloc {
    [self.outModel removeObserver:self forKeyPath:@"allCost"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (YJNODataView *)NODataView {
    if (_NODataView == nil) {
        _NODataView = [YJNODataView NODataView:(NODataTypeRecharge)];
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
        _topMenuToolBar.menuType = YJMenuTypeRecharge;
        _topMenuToolBar.isHasToday = YES;
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
    self.title = @"充值记录";
    self.view.backgroundColor = RGB_pageBackground;
    
    _statusType = @"";
    _startDate = [self dateStrWithMonthSinceNow:-3];
    _endDate = [self dateStrWith:[NSDate date]];
    RecodeData = [NSMutableArray arrayWithCapacity:0];
    
    // tableview
    [self.view addSubview:self.tableView];
    
    
    // 下拉菜单
    [self.view addSubview:self.topMenuToolBar];
    
    
    //中途取消
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveAppWillResignActiveJ:) name:appWillResignActiveJ object:nil];
    //阿里无app
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay:"]]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccesS) name:YJNotificationPaySuccessALi object:nil];
    }
    
    //ok
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:YJNotificationPaySuccess object:nil];


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


#pragma mark 支付成功
-(void)paySuccess {
    [YJShortLoadingView yj_hideToastActivityInView:self.view];
    self.tableView.userInteractionEnabled = YES;
    [_refreshGifHeader beginRefreshing];
    MYLog(@"--------------支付成功刷新");
}
-(void)paySuccesS{
    [YJShortLoadingView yj_hideToastActivityInView:self.view];
    self.tableView.userInteractionEnabled = YES;
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"支付成功" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [_refreshGifHeader beginRefreshing];
    }];
    [alertVc addAction:action];
    [self presentViewController:alertVc animated:YES completion:nil];
    
    //    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)receiveAppWillResignActiveJ:(NSNotification*)noti{
    [YJShortLoadingView yj_hideToastActivityInView:self.view];
    self.tableView.userInteractionEnabled = YES;
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

- (void)apiTypeDidChange:(NSNotification *)noti {
    
    _statusType = noti.userInfo[@"statusType"];
    
    [_refreshGifHeader beginRefreshing];
    
}

- (void)dateDidChange:(NSNotification *)noti {
    _startDate = noti.userInfo[@"startDate"];
    _endDate = noti.userInfo[@"endDate"];
    
    [_refreshGifHeader beginRefreshing];
    
    
}






#pragma mark  - 网络
#pragma mark   加载数据
- (void)loadData {
    if (_isMore) {
        _currentPage++;
        if (_currentPage > [_rechargeHistoryModel.pageModel.pages intValue]) {
            
            [_refreshFooter endRefreshingWithNoMoreData];
            return ;
        }
        
    } else{
        _currentPage = 1;
    }
    
    NSString *currentPageStr = [NSString stringWithFormat:@"%d",_currentPage];
    
    
    // 获取是否有空数据
    NSDictionary *dict = @{@"method" :      urlJK_rechargeRecord,
                           @"mobile" :      kUserManagerTool.mobile,
                           @"userPwd" :     kUserManagerTool.userPwd,
                           @"appVersion":   VERSION_APP_1_4_4,
                           @"rechargeType": @"00",
                           @"statusType":  _statusType,
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

    
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_rechargeRecord] params:dict success:^(id obj) {
        MYLog(@"充值记录%@",obj);
        
        if (_currentPage == 1) {
            [RecodeData removeAllObjects];
        }
        
        
        
        if (![obj[@"data"] isKindOfClass:[NSNull class]]) {
            //设置数据
            
            _rechargeHistoryModel = [YJRechargeHistoryModel mj_objectWithKeyValues:obj[@"data"]];
            
            [RecodeData addObjectsFromArray:_rechargeHistoryModel.pageModel.list];
            
//            weakSelf.outModel= [RechargeHistoryOutModel mj_objectWithKeyValues:obj];
//            RecodeData= [NSMutableArray arrayWithArray: weakSelf.outModel.list];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_refreshGifHeader endRefreshing];
            [_refreshFooter endRefreshing];
            
            if (RecodeData.count == 0) {
                
                [weakSelf.tableView addSubview:weakSelf.NODataView];
//                weakSelf.tableView.tableFooterView = [[UIView alloc] init];
                _refreshFooter.hidden = YES;
            } else {
                
                if ([_rechargeHistoryModel.pageModel.isLastPage isEqualToString:@"1"]) {
                    [_refreshFooter endRefreshingWithNoMoreData];
                }
                
                _refreshFooter.hidden = NO;
                
                if ([_statusType isEqualToString:@""]||[_statusType isEqualToString:@"2"]) {
                    [self.bottomLB show:^{
                        self.tableView.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40 - 50-64);
                    }];
                }
                
                
                
                
                [weakSelf.bottomLB setStatisticsType:@"充值成功" Count:_rechargeHistoryModel.rechargeCount amt:_rechargeHistoryModel.rechargeAllAmt];
                
//                [weakSelf setupFooterNODataView];
            }
            
            
            [weakSelf.tableView reloadData];
            
            
        });
        
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_refreshGifHeader endRefreshing];
            
        });
        
    }];
    
}




#pragma mark 取消充值
-(void)beginCancelPayWithDict:(NSDictionary*)dict {
    __weak typeof(self) sself = self;
//    [self.view makeToast:@"取消支付的网络请求"];
    MYLog(@"取消支付dictionary：%@",dict);
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_rechargeCancel] params:dict success:^(id obj) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        
        MYLog(@"消费记录结果：%@",obj);
        //刷新数据
//        [sself getTypeList];
        [sself.tableView reloadData];
        [_refreshGifHeader beginRefreshing];
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        
        //    MYLog(@"消费记录结果：%@",error);
    }];
    
    
}

#pragma mark - tableview


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return RecodeData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _navTableView) {
        RechargeNavTypeCell *cell = [RechargeNavTypeCell subjectCellWithTabelView:tableView];;
        cell.model = navTypeData[indexPath.row];
        cell.delegate = self;
        return cell;
        
    }else{
        YJRechargeHistoryListModel *modelM = RecodeData[indexPath.row];
//        RechargeHistoryModel*modelM =  RecodeData[indexPath.row];
        if ([modelM.rechangeStateStr isEqualToString:@"待支付"] | [modelM.rechangeState  isEqualToString:@"1"]) {//cell 待支付
            RechargeHistoryPayCell *cell = [RechargeHistoryPayCell purchaseHistoryCellWithTableView:tableView];
            cell.model =modelM;
            __block typeof(self) sself = self;
            cell.clickedRechargePayBtn=^(NSString*index,RechargeHistoryModel*model){
                if ([index isEqualToString:@"00"]) {//取消支付
                    
                    NSDictionary *dict = @{@"method" :      urlJK_rechargeCancel,
                                           @"mobile" :      kUserManagerTool.mobile,
                                           @"userPwd" :     kUserManagerTool.userPwd,
                                           @"appVersion":   VERSION_APP_1_3_0,
                                           @"id":modelM.id,
                                           };
                    [sself beginCancelPayWithDict:dict];
                }else if ([index isEqualToString:@"11"]) {//支付
                    
                    
                    if (model.rechangeType.integerValue == 1) {//微信
                            NSInteger gg = [[WeChatPayManager shareWeChatPay] isInstallWeChat];
                            if (gg == 1) {
                                [sself.view makeToast:@"尚未安装微信"];
                                return;
                            }else if (gg == 2) {
                                [sself.view makeToast:@"微信版本过低"];
                                return;
                            }
                        [YJShortLoadingView yj_makeToastActivityInView:self.view];
                        sself.tableView.userInteractionEnabled = NO;
                        
                        [[WeChatPayManager shareWeChatPay] weChatWithTotalAmount:model.rechangeAmt outTradeNo:model.serialNo viewcontroller:sself from:YJAlipayFromRechargeHis];
                    }else if ( model.rechangeType.integerValue == 2){//支付宝
                        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay:"]]) {
                            self.tableView.userInteractionEnabled = NO;
                        }else{
                            [YJShortLoadingView yj_makeToastActivityInView:self.view];
                            self.tableView.userInteractionEnabled = NO;
                        }
                        
                         [YJAlipayManager alipayWithTotalAmount:model.rechangeAmt outTradeNo:model.serialNo viewcontroller:self from:(YJAlipayFromRechargeHis)];
                    }
                   
                    
                    
                }
                
            };
            if (indexPath.row == 0) {
                UIView *separateLine = [[UIView alloc] init];
                separateLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
                separateLine.backgroundColor = RGB_grayLine;
                [cell.contentView addSubview:separateLine];
            }
            return cell;
        }else{//cell 成功或者失败
            RechargeHistoryNormalCell *cell = [RechargeHistoryNormalCell purchaseHistoryCellWithTableView:tableView];
            cell.model =modelM;
            if (indexPath.row == 0) {
                UIView *separateLine = [[UIView alloc] init];
                separateLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
                separateLine.backgroundColor = RGB_grayLine;
                [cell.contentView addSubview:separateLine];
            }
            return cell;
        }
        
    }
    
    
    return nil;
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeHistoryModel*modelM =  RecodeData[indexPath.row];
    if ([modelM.rechangeStateStr isEqualToString:@"待支付"] | [modelM.rechangeState  isEqualToString:@"1"]) {//cell 待支付
        return 125;
    }
    return 75;
    
}


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
