//
//  ECommerceReportMainVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJHouseFundLoanInfoVC.h"
#import "YJHousfundPayDetailsVC.h"
#import "YJMeCell.h"
#import "YJTextItem.h"
#import "JDReportModel.h"
#import "ECommerceReportSecondPage.h"
#import "ECommerceReportMainVC.h"
#import "ECommerceReportMainTopCell.h"
//#import "ECommerceDataTool.h"

#import "SingleHorizontalBarChartViewController.h"

@interface ECommerceReportMainVC ()
{
    CommonSearchDataTool *_commonSearchDataTool;
//    ECommerceDataTool *_commonSearchDataTool;
}
@property (nonatomic, strong) JDReportModel *jdReportModel;

@property(strong,nonatomic) NSMutableArray *groupDataArray;
@property(strong,nonatomic) NSMutableArray *detailDataArray;
@end

@implementation ECommerceReportMainVC




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"京东报告";

    
    switch (self.searchConditionModel.type) {
        case YJGoToSearchResultTypeFromHome:
            
            [self laodJDData];
            break;
        case YJGoToSearchResultTypeFromRecord:
            [self checkJDReport];
            break;
            
        default:
            break;
    }
    
    
  
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_commonSearchDataTool removeTimer];
}
#pragma mark - 网络
#pragma mark 网络 报告页面查询
-(void)checkJDReport {
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    NSDictionary *dicParams =@{@"method" : urlJK_recordDetailProcess,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"reportId":self.searchConditionModel.ID,
                               @"appVersion": VERSION_APP_1_3_0};
    MYLog(@"电商输入参数%@",dicParams);
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_recordDetailProcess] params:dicParams success:^(id responseObj) {
        [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
        
        MYLog(@")))) 电商%@",responseObj);
        
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            sself.jdReportModel = [JDReportModel mj_objectWithKeyValues:responseObj[@"data"][@"jdRespVo"][@"data"]];
            sself.jdReportModel.jdorderStatisticsModel = [[JDorderStatisticsModel alloc]init];
            sself.jdReportModel.jdorderCostBarChartModel = [[JDorderCostBarChartModel alloc]init];
            
            sself.jdReportModel.jdorderStatisticsModel.addSpend3Year = responseObj[@"data"][@"addSpend3Year"];
            sself.jdReportModel.jdorderStatisticsModel.totalOrderCount = responseObj[@"data"][@"totalOrderCount"];
            sself.jdReportModel.jdorderStatisticsModel.avgSpend = responseObj[@"data"][@"avgSpend"];
            sself.jdReportModel.jdorderStatisticsModel.totalGoodsCount = responseObj[@"data"][@"totalGoodsCount"];
            sself.jdReportModel.jdorderStatisticsModel.singleHightSpend = responseObj[@"data"][@"singleHightSpend"];
            
            sself.jdReportModel.jdorderCostBarChartModel.spendOrder0To50Count = responseObj[@"data"][@"spendOrder0To50Count"];
            sself.jdReportModel.jdorderCostBarChartModel.spendOrder50To100Count = responseObj[@"data"][@"spendOrder50To100Count"];
            sself.jdReportModel.jdorderCostBarChartModel.spendOrder100To200Count = responseObj[@"data"][@"spendOrder100To200Count"];
            sself.jdReportModel.jdorderCostBarChartModel.spendOrder200To500Count = responseObj[@"data"][@"spendOrder200To500Count"];
            sself.jdReportModel.jdorderCostBarChartModel.spendOrder500To1000Count = responseObj[@"data"][@"spendOrder500To1000Count"];
            sself.jdReportModel.jdorderCostBarChartModel.spendOrder1000To3000Count = responseObj[@"data"][@"spendOrder1000To3000Count"];
            sself.jdReportModel.jdorderCostBarChartModel.spendOrder3000To5000Count = responseObj[@"data"][@"spendOrder3000To5000Count"];
            sself.jdReportModel.jdorderCostBarChartModel.spendOrder5000UpCount = responseObj[@"data"][@"spendOrder5000UpCount"];
            dispatch_async(dispatch_get_main_queue(), ^{
                sself.tableView.hidden = NO;
                [sself creatUI];
                [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
            });

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

#pragma mark 网络  首页进来的查询
-(void) laodJDData {
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    
    _commonSearchDataTool = [[CommonSearchDataTool alloc] init];
    _commonSearchDataTool.searchConditionModel = self.searchConditionModel;
    
    _commonSearchDataTool.searchType =self.searchType;
    _commonSearchDataTool.method = urlJK_queryJd;
    _commonSearchDataTool.version = VERSION_APP_1_3_0;
    
    _commonSearchDataTool.searchFailure = ^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
            NSString *errorStr = nil;
            if (error.domain) {
                errorStr = error.domain;
            } else {
                errorStr = errorInfo;
            }
            [sself.view makeToast:errorStr];
            [sself jOutSelf];
        });
        
    };
    
    [_commonSearchDataTool searchDataSuccesssuccess:^(id responseObj) {
        MYLog(@"----%@",responseObj);
        [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
        NSString * status = responseObj[@"data"][@"jdRespVo"][@"code"];
        if ([status isEqualToString:@"0000"]) {//成功
            if (responseObj[@"data"]) {
                if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                    sself.jdReportModel = [JDReportModel mj_objectWithKeyValues:responseObj[@"data"][@"jdRespVo"][@"data"]];
                    sself.jdReportModel.jdorderStatisticsModel = [[JDorderStatisticsModel alloc]init];
                    sself.jdReportModel.jdorderCostBarChartModel = [[JDorderCostBarChartModel alloc]init];
                    
                    sself.jdReportModel.jdorderStatisticsModel.addSpend3Year = responseObj[@"data"][@"addSpend3Year"];
                    sself.jdReportModel.jdorderStatisticsModel.totalOrderCount = responseObj[@"data"][@"totalOrderCount"];
                    sself.jdReportModel.jdorderStatisticsModel.avgSpend = responseObj[@"data"][@"avgSpend"];
                    sself.jdReportModel.jdorderStatisticsModel.totalGoodsCount = responseObj[@"data"][@"totalGoodsCount"];
                    sself.jdReportModel.jdorderStatisticsModel.singleHightSpend = responseObj[@"data"][@"singleHightSpend"];
                    
                    sself.jdReportModel.jdorderCostBarChartModel.spendOrder0To50Count = responseObj[@"data"][@"spendOrder0To50Count"];
                    sself.jdReportModel.jdorderCostBarChartModel.spendOrder50To100Count = responseObj[@"data"][@"spendOrder50To100Count"];
                    sself.jdReportModel.jdorderCostBarChartModel.spendOrder100To200Count = responseObj[@"data"][@"spendOrder100To200Count"];
                    sself.jdReportModel.jdorderCostBarChartModel.spendOrder200To500Count = responseObj[@"data"][@"spendOrder200To500Count"];
                    sself.jdReportModel.jdorderCostBarChartModel.spendOrder500To1000Count = responseObj[@"data"][@"spendOrder500To1000Count"];
                    sself.jdReportModel.jdorderCostBarChartModel.spendOrder1000To3000Count = responseObj[@"data"][@"spendOrder1000To3000Count"];
                    sself.jdReportModel.jdorderCostBarChartModel.spendOrder3000To5000Count = responseObj[@"data"][@"spendOrder3000To5000Count"];
                    sself.jdReportModel.jdorderCostBarChartModel.spendOrder5000UpCount = responseObj[@"data"][@"spendOrder5000UpCount"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        sself.tableView.hidden = NO;
                        [sself creatUI];
                        [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
                    });
                    
                    
                }
            }
            
        } else{//异常情况
            dispatch_async(dispatch_get_main_queue(), ^{
                [sself.view makeToast:responseObj[@"data"][@"msg"]];
            });
            [sself jOutSelf];
        }
        
        MYLog(@"第三步获取公积金数据-------%@",responseObj[@"data"][@"data"]);
    } failure:^(NSError * error) {
       
    }];
}

#pragma mark - UI
- (void)creatUI {
    [self setupHeaderView];
    
    [self creatGroupDataArray];
}

-(void)creatGroupDataArray {
    if (!_groupDataArray) {
        _groupDataArray = [NSMutableArray arrayWithCapacity:0];
        
    }else{
        [_groupDataArray removeAllObjects];
    }
    
    [_groupDataArray addObject:@"绑定银行卡信息"];
    [_groupDataArray addObject:@"消费统计"];
    [_groupDataArray addObject:@"消费能力柱状图"];
    [_groupDataArray addObject:@"地址信息"];
    [_groupDataArray addObject:@"订单记录"];
    
    for (int i=0 ; i<_groupDataArray.count; i++) {
        [self creatCellTitle:_groupDataArray[i] index:i];
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setupHeaderView {
    
    ECommerceReportMainTopCell *headerView = [ECommerceReportMainTopCell socialSecurityView];
    headerView.model = _jdReportModel.basicInfoS;
    headerView.baitiaoModel = _jdReportModel.baiTiaoInfoS;
//    headerView.baitiaoModel = 
    //    _headerView = headerView;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 563);
    
    UIView *v = [[UIView alloc] init];

    v.frame = CGRectMake(0, 0, SCREEN_WIDTH, 563);

    [v addSubview:headerView];
    v.backgroundColor = RGB(245, 245, 245);
    self.tableView.tableHeaderView = v;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
}


- (void)creatCellTitle:(NSString *)str index:(int)index {
    
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:str destVc:nil];
    __block typeof(self)  sself = self;
    switch (index) {
        case 0:{
            item0.option = ^(NSIndexPath *indexPath){//银行卡
                ECommerceReportSecondPage *vc = [[ECommerceReportSecondPage alloc]init];
                vc.itemType = ECommerceReportDetailTypeCard;
                vc.data = _jdReportModel.bankInfo;
                [sself.navigationController pushViewController:vc animated:YES];
                
            };
            break;
        }case 3:{
            item0.option = ^(NSIndexPath *indexPath){//地址
                ECommerceReportSecondPage *vc = [[ECommerceReportSecondPage alloc]init];
                vc.itemType = ECommerceReportDetailTypeAddress;
                vc.data = _jdReportModel.addressInfo;
                [sself.navigationController pushViewController:vc animated:YES];
                
            };
            break;
        }case 4:{
            item0.option = ^(NSIndexPath *indexPath){//订单
                ECommerceReportSecondPage *vc = [[ECommerceReportSecondPage alloc]init];
                vc.itemType = ECommerceReportDetailTypeOrderList;
                vc.data = _jdReportModel.orderDetail;
                [sself.navigationController pushViewController:vc animated:YES];
                
            };
            break;
        }case 1:{
            item0.option = ^(NSIndexPath *indexPath){//统计
                
                if (!_jdReportModel.jdorderStatisticsModel) {
                    [sself.view.window makeToast:@"暂无数据"];
                }else{
                    ECommerceReportSecondPage *vc = [[ECommerceReportSecondPage alloc]init];
                    vc.itemType = ECommerceReportDetailTypeStatistics;
                    vc.data = @[_jdReportModel.jdorderStatisticsModel];
                    [sself.navigationController pushViewController:vc animated:YES];
                   
                }
            };
            break;
        }case 2:{
            item0.option = ^(NSIndexPath *indexPath){//柱图
                if (!_jdReportModel.jdorderCostBarChartModel) {
                    [sself.view.window makeToast:@"暂无数据"];
                }else{
                    SingleHorizontalBarChartViewController * vc = [[SingleHorizontalBarChartViewController alloc] init];
                    vc.jdReportModel = _jdReportModel.jdorderCostBarChartModel;
                    [sself.navigationController pushViewController:vc animated:YES];
                    
                }
                
                
            };
            break;
        }default:
            break;
    }
    
    YJItemGroup *group = [[YJItemGroup alloc] init];
    group.groups = @[item0];
    [self.dataSource addObject:group];
    [self.tableView reloadData];
    
    
}


@end
