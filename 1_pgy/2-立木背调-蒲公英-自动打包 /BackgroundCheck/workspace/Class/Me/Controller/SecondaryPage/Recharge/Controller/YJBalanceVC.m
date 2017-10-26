//
//  YJBalanceVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJBalanceVC.h"
#import "YJPayWayCell.h"
#import "YJHomeItemModel.h"
#import "YJOnlineRechargeAmountVC.h"
#import "YJOfflineTransferTipVC.h"
@interface YJBalanceVC ()
{
    UILabel *_balcanceLB;
    MJRefreshGifHeader *_refreshGifHeader;

}

@property (nonatomic, strong) NSArray *payWayArray;

@end

@implementation YJBalanceVC
- (NSArray *)payWayArray {
    if (_payWayArray == nil) {
        _payWayArray = [NSArray array];
        
        _payWayArray = [YJHomeItemModel mj_objectArrayWithFilename:@"payWay.plist"];
    }
    return _payWayArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额";
    self.tableView.rowHeight = 75;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
//    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
    self.tableView.backgroundColor = RGB_pageBackground;
    
    UIView *separateLine = [[UIView alloc] init];
    separateLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    separateLine.backgroundColor = RGB_grayLine;
    self.tableView.tableFooterView = separateLine;
    
    [self setupTableViewHeader];
    
    

}

/**
 *  设置刷新控件
 */
- (void)setupRefreshControl {
    __weak typeof(self) weakSelf = self;
    
    //
    NSMutableArray *pullImgs = [NSMutableArray arrayWithObject:[UIImage imageNamed:@"icon_shake_animation_22"]];//[self animationImagesWithName:@"icon_shake_animation" count:40];
    
    NSMutableArray *shakeImgs = [self animationImagesWithName:@"icon_shake_animation" count:40];
    
    // 下拉刷新
    _refreshGifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        //
        [weakSelf getRechargeInfo];
        
    }];
    
    _refreshGifHeader.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    _refreshGifHeader.stateLabel.hidden = YES;
    
    [_refreshGifHeader setImages:pullImgs forState:(MJRefreshStatePulling)];
    [_refreshGifHeader setImages:shakeImgs forState:(MJRefreshStateRefreshing)];
    self.tableView.mj_header = _refreshGifHeader;
    
}

/**
 *  刷新控件动画组
 *
 */
- (NSMutableArray *)animationImagesWithName:(NSString *)name count:(int)count {
    NSMutableArray *imgArr = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 1; i <= count; i ++) {
        NSString *imgName = [NSString stringWithFormat:@"%@_%d",name,i];
        
        UIImage *img = [UIImage imageNamed:imgName];
        
        [imgArr addObject:img];
    }
    return imgArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self getRechargeInfo];

//    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];

    
//    [navigationBar setShadowImage:[UIImage new]];
    
//     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
    
}

- (UIView *)setupTableViewHeader {
    
    
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = RGB_pageBackground;
    
    CGFloat balanceViewH = 156;
    UIImageView *balanceView = [[UIImageView alloc] init];
    balanceView.frame = CGRectMake(0, 0, SCREEN_WIDTH, balanceViewH);
    balanceView.image = [UIImage imageNamed:@"navbarBg"];

//    [balanceView.layer addSublayer:[UIColor setGradualChangingColor:balanceView fromColor:[UIColor colorWithHexString:@"#3071f2"] toColor:[UIColor colorWithHexString:@"#31b2f2"]]];
    
    [bg addSubview:balanceView];
    
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = @"余额（元）";
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.backgroundColor = [UIColor clearColor];
    titleLB.frame = CGRectMake(15, 35, SCREEN_WIDTH-30, 20);
    titleLB.font = Font13;
    titleLB.textColor = RGB_white;
    [balanceView addSubview:titleLB];
    
    UILabel *balcanceLB = [[UILabel alloc] init];
    _balcanceLB= balcanceLB;
    balcanceLB.text = @"0.00";
    balcanceLB.textAlignment = NSTextAlignmentLeft;
    balcanceLB.backgroundColor = [UIColor clearColor];
    balcanceLB.frame = CGRectMake(15, CGRectGetMaxY(titleLB.frame)+5, SCREEN_WIDTH-30, 45);
    balcanceLB.font = [UIFont systemFontOfSize:40];
    balcanceLB.textColor = RGB_white;

    [balanceView addSubview:balcanceLB];
    

    
    bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(balanceView.frame)+10);
    self.tableView.tableHeaderView = bg;
    return bg;
    
}

#pragma mark---充值账户信息
- (void)getRechargeInfo {
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        
        // 提交企业认证后，企业详情接口
        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_rechargeInfo,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd,
                               @"appVersion":ConnectPortVersion_1_0_0
                               };
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_rechargeInfo] params:dict success:^(id responseObj) {
            
            MYLog(@"充值账户信息---%@",responseObj[@"data"]);
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.balance = responseObj[@"data"][@"balance"];
                    _balcanceLB.text = [NSString stringWithFormat:@"%@",self.balance];
           
                    [weakSelf.tableView reloadData];
                    
                    [_refreshGifHeader endRefreshing];
                });
                
            }
        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_refreshGifHeader endRefreshing];
            });
            MYLog(@"充值账户信息失败---%@",error);
            
        }];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.payWayArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJPayWayCell *cell = [YJPayWayCell payWayCellWithTableView:tableView];
    
    cell.homeItemModel = self.payWayArray[indexPath.row];
//    
//    if (indexPath.row == 0) {
//        UIView *separateLine = [[UIView alloc] init];
//        separateLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
//        separateLine.backgroundColor = RGB_grayLine;
//        [cell.contentView addSubview:separateLine];
//        
//    }
    
    return cell;
}


#pragma mark--UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YJHomeItemModel *model = self.payWayArray[indexPath.row];
    
    if ([model.type isEqualToString:@"online"]) {
        YJOnlineRechargeAmountVC *onlineRechargeAmountVC = [[YJOnlineRechargeAmountVC alloc] init];
        
        [self.navigationController pushViewController:onlineRechargeAmountVC animated:YES];
        
    } else if ([model.type isEqualToString:@"offline"]) {
        
        YJOfflineTransferTipVC *onlineRechargeAmountVC = [[YJOfflineTransferTipVC alloc] init];
        
        [self.navigationController pushViewController:onlineRechargeAmountVC animated:YES];
    }
    
}


- (void)dealloc {
    MYLog(@"---------%@销毁了",self);
}


@end
