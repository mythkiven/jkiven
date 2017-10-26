//
//  YJRedPacketVc.m
//  CreditPlatform
//
//  Created by yj on 16/9/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJRedPacketVc.h"
#import "YJRechargeHistoryModel.h"
#import "YJRedPacketModel.h"
#import "YJRedPacketHeaderView.h"
#import "YJRedPacketCell.h"
@interface YJRedPacketVc ()
{
    YJRefreshGifHeader *_refreshGifHeader;
    MJRefreshFooter *_refreshFooter;
    
    int _currentPage;
    BOOL _isMore;
    
    YJRechargeHistoryModel *_rechargeHistoryModel;
    
    UIView *_bg;
}



@property (nonatomic, strong) NSMutableArray *redPacketArr;

@property (nonatomic, copy) NSString *rechargeAllAmt;

@property (nonatomic, copy) NSString *rechargeCount;

@property (nonatomic, copy) NSString *rechargeRedEndDate;

@property (nonatomic, strong) YJRedPacketHeaderView *headerView;

@end

@implementation YJRedPacketVc
static NSString *cellID = @"YJRedPacketCellID";
- (NSMutableArray *)redPacketArr {
    if (_redPacketArr == nil) {
        _redPacketArr = [NSMutableArray array];
    }
    return _redPacketArr;
}

- (YJRedPacketHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [YJRedPacketHeaderView redPacketHeaderView];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
    }
    return _headerView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"红包";
    self.view.backgroundColor = RGB_pageBackground;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.rowHeight = 75;
    [self.tableView registerNib:[UINib nibWithNibName:@"YJRedPacketCell" bundle:nil] forCellReuseIdentifier:cellID];
    
    
    
//    if (self.redPacketArr.count) {
//        [self creatUI];
//    } else {
//        [self.view addSubview:[YJNODataView NODataView:NODataTypeRedPacket]];
//
//    }
    
    
    
    [self setupRefreshControl];
    
}



/**
 *  设置刷新控件
 */
- (void)setupRefreshControl {
    __weak typeof(self) weakSelf = self;
    
    // 下拉刷新
    _refreshGifHeader = [YJRefreshGifHeader yj_headerWithRefreshingBlock:^{
        
        //
        _isMore = NO;
        [weakSelf getRedPacketRechargeHistory];
        
    }];
    self.tableView.mj_header = _refreshGifHeader;
    [_refreshGifHeader beginRefreshing];
    
    
    _refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _isMore = YES;
        [weakSelf getRedPacketRechargeHistory];
    }];
    _refreshFooter.hidden = YES;
    self.tableView.mj_footer = _refreshFooter;
    
    
}



#pragma mark--红包充值记录
- (void)getRedPacketRechargeHistory {
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        
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
        
        
        // 提交企业认证后，企业详情接口
        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_rechargeRecord,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd,
                               @"appVersion":ConnectPortVersion_1_0_0,
                               @"rechargeType" : @"01",
                               @"statusType":@"",
                               @"startDate":@"",
                               @"endDate ":@"",
                               @"pageSize":    @"20",
                               @"pageNum":   currentPageStr
                               };
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_rechargeRecord] params:dict success:^(id responseObj) {
            
            MYLog(@"红包信息---%@",responseObj);
            
            if (_currentPage == 1) {
                [weakSelf.redPacketArr removeAllObjects];
            }
            
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                
                _rechargeHistoryModel = [YJRechargeHistoryModel mj_objectWithKeyValues:responseObj[@"data"]];
                
                
                [weakSelf.redPacketArr addObjectsFromArray:_rechargeHistoryModel.pageModel.list];
                
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [_refreshGifHeader endRefreshing];
                    [_refreshFooter endRefreshing];
                    
                    if (weakSelf.redPacketArr.count == 0) {
                        [self.view addSubview:[YJNODataView NODataView:NODataTypeRedPacket]];
                    } else {
                        
                        if ([_rechargeHistoryModel.pageModel.isLastPage isEqualToString:@"1"]) {
                            [_refreshFooter endRefreshingWithNoMoreData];
                        }
                        
                        _refreshFooter.hidden = NO;
                        [weakSelf creatUI];
                        
                    }
                    
                  [weakSelf.tableView reloadData];
                    
                    
                });

                
                
                
//                weakSelf.rechargeAllAmt = [NSString stringWithFormat:@"%@",responseObj[@"data"][@"rechargeAllAmt"]];
//               weakSelf.rechargeCount =  [NSString stringWithFormat:@"%@",responseObj[@"data"][@"rechargeCount"]];
//                weakSelf.rechargeRedEndDate =  [NSString stringWithFormat:@"%@",responseObj[@"data"][@"rechargeRedEndDate"]];

            }
            
            
//            if (![responseObj[@"list"] isKindOfClass:[NSNull class]]) {
//                weakSelf.redPacketArr = [YJRedPacketModel mj_objectArrayWithKeyValuesArray:responseObj[@"list"]];
//                
//                            }
            

        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_refreshGifHeader endRefreshing];
                [_refreshFooter endRefreshing];
            });
            MYLog(@"红包信息失败---%@",error);
            
        }];
    }
    
    
}

- (void)creatUI {
    
    if (!_bg) {
        // 分割线
        UIView *bg1 = [[UIView alloc] init];
        bg1.frame = CGRectMake(0, 0, SCREEN_WIDTH, .5);
        bg1.backgroundColor = RGB_pageBackground;
        UIView *separateLineBottom = [self separateLine];
        separateLineBottom.frame= CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
        [bg1 addSubview:separateLineBottom];
        self.tableView.tableFooterView = bg1;
        
        
        UIView *bg = [[UIView alloc] init];
        bg.backgroundColor = RGB_pageBackground;
        bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
//        YJRedPacketHeaderView *headerView = [YJRedPacketHeaderView redPacketHeaderView];
//        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 190);

        _bg = bg;
        [bg addSubview:self.headerView];
        

        self.tableView.tableHeaderView = bg;
    }
    
//    [self.headerView setRechargeAllAmt:self.rechargeAllAmt rechargeRedEndDate:self.rechargeRedEndDate];
     [self.headerView setRechargeAllAmt:_rechargeHistoryModel.rechargeAllAmt rechargeRedEndDate:@""];
    
}

- (NSMutableAttributedString *)getRedPacketNum{
    NSString *redPacketNumStr = [NSString stringWithFormat:@"收到红包%@个，共",_rechargeHistoryModel.rechargeCount];
    NSRange range = [redPacketNumStr rangeOfString:_rechargeHistoryModel.rechargeCount];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:redPacketNumStr];

    [attStr addAttributes:@{
                            NSForegroundColorAttributeName : RGB_redText} range:range];
    return attStr;
}

- (NSMutableAttributedString *)redPacketAmount:(NSString *)amount {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:amount];
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} range:NSMakeRange(amount.length-1, 1)];
    return attStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.redPacketArr.count;
//    return self.redPacketArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *ID = @"redPacketCell";
    YJRedPacketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.redPacketArr[indexPath.row];
    
    return cell;
}

- (UIView *)separateLine {
    UIView *separateLine = [[UIView alloc] init];
    separateLine.backgroundColor = RGB_grayLine;
    return separateLine;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
