//
//  CitySelectVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "ListHookVC.h"
#import "ListHookCell.h"

#import "ListHookModel.h"

#import "YJRepoortCreditEmailBillDetailsVC.h"
#import "reportCreditBillModel.h"


@interface ListHookVC ()
{
    ListHookModel *_cityModel;
    BOOL normalSelectCity;//是否默认
    
    // 信用卡的model
    NSMutableArray *_dataSource;
    reportCreditBillModel *_reportCreditBillModel;
    CommonSearchDataTool *commonSearchDataTool_;
}



@end



@implementation ListHookVC

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    [appearance setBarTintColor:RGB_navBar];
    [appearance setBackgroundImage:[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
    appearance.shadowImage =[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]];
    
    self.navigationController.navigationBar.tintColor = RGB_navBar;
    self.navigationController.navigationBar.barTintColor = RGB_navBar;
    
//    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:1]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage =[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:1]];
    
}
-(void)viewDidAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = RGB_pageBackground;
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);

    
    _listData = [NSMutableArray arrayWithCapacity:0];
    _dataSource = [NSMutableArray arrayWithCapacity:0];
    
    
    
    switch (self.searchItemType) {
        case SearchItemTypeCreditCardBill:{//信用卡
            
            self.title = @"信用卡账单报告";
            normalSelectCity =YES;
            
            switch (self.searchConditionModel.type) {
                case YJGoToSearchResultTypeFromHome:
                    [self laodHouseFundData];
                    break;
                case YJGoToSearchResultTypeFromRecord:
                    if ([self.recodeType isEqualToString:kBizType_bill]) {
                        self.searchItemType = SearchItemTypeCreditCardBill;
                    }
                    [self checkDetailReport];
                    break;
                    
                default:
                    break;
            }
            break;
            
        }case SearchItemTypeCarSafe:{//车险
            self.title = @"汽车保险查询";
            if (!_listData.count) {
                [self checkCompany];
            }else{
                [self creatCriteView:_listData];
            }
            
            
            break;
            
        }case SearchItemTypeNetBankBill:{//网银
            self.title = @"网银流水查询";
            if (!_listData.count) {
                [self checkBankList];
            }else{
                [self creatCriteView:_listData];
            }
            break;
            
        }default:
            break;
    }

    
    
}


#pragma mark - 创建页面
-(void)creatCriteView:(NSArray*)arr{
    [_dataSource removeAllObjects];
    if (!arr.count) {
        return;
    }
    
    
    NSString*title;
    switch (self.searchItemType) {
        case SearchItemTypeCreditCardBill:{//信用卡
            for (NSDictionary *cc in arr) {
                reportCreditBillMainModel * model = [reportCreditBillMainModel mj_objectWithKeyValues:cc];
                [_dataSource addObject:model];
            }
            for (reportCreditBillMainModel *mm  in _dataSource) {
                if (mm.cardInfo.bankCode) {
                    ListHookModel *model = [[ListHookModel alloc]init];
                    model.credit = mm;
                    [_listData addObject:model];
                }
            }
            title = @"银行/卡号";
            break;
            
        }case SearchItemTypeCarSafe:{//车险
            
            [_listData removeAllObjects];
            if ([[arr[0] class] isKindOfClass:[NSString class]]) {
                for (NSString *dic in arr) {
                    [_listData addObject:dic];
                }
            }else{
                for (NSDictionary *dic in arr) {
                    ListHookModel *model = [[ListHookModel alloc] init];
                    model.companyCarInsuranc = [CompanyCarInsurancModel mj_objectWithKeyValues:dic];
                    [_listData addObject:model];
                } 
            }
           
            
            title = @"公司";
            
            break;
            
        }case  SearchItemTypeNetBankBill:{//网银
            
            [_listData removeAllObjects];
            for (NSDictionary *dic in arr) {
                    ListHookModel *model = [[ListHookModel alloc] init];
                    model.eBankListModel = [EBankListModel mj_objectWithKeyValues:dic];
                    [_listData addObject:model];
               
            }
            
            
            title = @"";
            
            
            break;
            
        }default:
            break;
    }
    
    
    UIView *header =[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 45)];
    header.backgroundColor =RGB_white;
    UIView *line = [JFactoryView JLineWithSuper:header];
    line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    UILabel *label = [JFactoryView JlabelWith:CGRectMake(15, 0.5, SCREEN_WIDTH, 44.5) Super:header Color:RGB_black Font:17 Alignment:0 Text:title];
    label.backgroundColor = RGB_white;
    
    if (title.length<1) {
        
    }else
        self.tableView.tableHeaderView = header;
    self.tableView.sectionHeaderHeight = 45;
    
    [self.tableView reloadData];
    
}
#pragma mark - 车险 查询公司
-(void)checkCompany{
    __weak typeof(self) sself = self;
    [YJShortLoadingView yj_makeToastActivityInView:self.view  ];
    
    NSDictionary *dicParams =@{@"method" : urlJK_queryInsuranceCompany,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"loginType":self.loginType,
                               @"appVersion": VERSION_APP_1_4_1};
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_queryInsuranceCompany] params:dicParams success:^(id obj) {
        
        if ([obj[@"code"] isEqualToString:@"0000"]) {
            if (obj[@"data"]) {
                NSArray *arr = (NSArray*)obj[@"data"];
                if (arr.count) {
                    
                      dispatch_async(dispatch_get_main_queue(), ^{
                            [YJShortLoadingView yj_hideToastActivityInView:self.view ];
                            [sself creatCriteView:arr];
                        });
                        return ;
                    
                }
            }
            [YJShortLoadingView yj_hideToastActivityInView:self.view ];
            [self.view addSubview:[YJNODataView NODataView]];
        }else {
            [sself.view makeToast:@"查询失败"];
            [sself jOutSelf];
        }
        
    } failure:^(NSError *error) {
        //统一展示，
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJShortLoadingView yj_hideToastActivityInView:self.view ];
            [sself.view makeToast:errorInfo];
            [sself jOutSelf];
        });
        
    }];
}
#pragma mark - 网银 查询银行
-(void)checkBankList{
    __weak typeof(self) sself = self;
    [YJShortLoadingView yj_makeToastActivityInView:self.view  ];
    
    NSDictionary *dicParams =@{@"method" : urlJK_appBankInfo,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"appVersion": VERSION_APP_1_4_2};
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_appBankInfo] params:dicParams success:^(id obj) {
        
        if ([obj[@"code"] isEqualToString:@"0000"]) {
            if (obj[@"list"]) {
                NSArray *arr = (NSArray*)obj[@"list"];
                if (arr.count) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [YJShortLoadingView yj_hideToastActivityInView:self.view ];
                        [sself creatCriteView:arr];
                    });
                    return ;
                    
                }
            }
            [YJShortLoadingView yj_hideToastActivityInView:self.view ];
            [self.view addSubview:[YJNODataView NODataView]];
        }else {
            [sself.view makeToast:@"查询失败"];
            [sself jOutSelf];
        }
        
    } failure:^(NSError *error) {
        //统一展示，
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJShortLoadingView yj_hideToastActivityInView:self.view ];
            [sself.view makeToast:errorInfo];
            [sself jOutSelf];
        });
        
    }];
}

#pragma mark - 记录查询
-(void)checkDetailReport{
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    
    NSDictionary *dicParams =@{@"method" : urlJK_recordDetailProcess,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"reportId":self.searchConditionModel.ID,
                               @"appVersion": VERSION_APP_1_4_0};
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_recordDetailProcess] params:dicParams success:^(id obj) {
        
        if ([obj[@"data"][@"code"] isEqualToString:@"0000"]) {
            if (obj[@"data"][@"cardList"]) {
                NSArray *arr = (NSArray*)obj[@"data"][@"cardList"];
                if (arr.count) {
                    NSDictionary *crd = [arr firstObject];
                    if (crd[@"cardInfo"][@"bills"]) {
                        
                        [_dataSource removeAllObjects];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
                            [sself creatCriteView:arr];
                        });
                        return ;
                    }
                }
            }
            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
             [self.view addSubview:[YJNODataView NODataView]];
        }else {
            [sself.view makeToast:@"查询失败"];
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


#pragma mark - 首页查询
- (void)laodHouseFundData {
    NSString *JVersion,*JMethod;
    switch (self.searchItemType) {
        case SearchItemTypeCreditCardBill:{//信用卡
            JVersion= VERSION_APP_1_4_0;
            JMethod = urlJK_queryCreditcardbill;
            break;
            
        }case SearchItemTypeCarSafe:{//车险
            JVersion= VERSION_APP_1_4_1;
            JMethod = urlJK_queryCreditcardbill;
            break;
            
        }case  SearchItemTypeNetBankBill:{//网银
            
            break;
            
        }default:
            break;
    }
    
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    
    commonSearchDataTool_ = [[CommonSearchDataTool alloc] init];
    commonSearchDataTool_.method =  JMethod;
    
    commonSearchDataTool_.searchConditionModel = self.searchConditionModel;
    commonSearchDataTool_.searchType = self.searchItemType;
    commonSearchDataTool_.version = JVersion;
    commonSearchDataTool_.searchFailure = ^(NSError *error) {
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
    [commonSearchDataTool_ searchDataSuccesssuccess:^(id obj){
        
        if ([obj[@"data"][@"code"] isEqualToString:@"0000"]) {
            if (obj[@"data"][@"cardList"]) {
                NSArray *arr = (NSArray*)obj[@"data"][@"cardList"];
                if (arr.count) {
                    NSDictionary *crd = [arr firstObject];
                    if (crd[@"cardInfo"][@"bills"]) {
                        [_dataSource removeAllObjects];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
                            [sself creatCriteView:arr];
                            
                        });
                        return ;
                    }
                }
            }
            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
            [self.view addSubview:[YJNODataView NODataView]];
        }else {
            [sself.view makeToast:@"查询失败"];
            [sself jOutSelf];
        }
        
        MYLog(@"第三步获取数据-------%@",obj[@"data"][@"data"]);
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
            NSString *errorStr = nil;
            if (error.domain) {
                errorStr = error.domain;
            } else {
                errorStr =errorInfo;
            }
            [sself.view makeToast:errorStr];
            [sself jOutSelf];
        });
        
    }];
}


#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    switch (self.searchItemType) {
        case SearchItemTypeCreditCardBill:{//信用卡
//            return 45;
            break;
            
        }case SearchItemTypeCarSafe:{//车险
            
            break;
            
        }default:
            break;
    }
    
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListHookCell *cell = [ListHookCell subjectCellWithTabelView:tableView];
    cell.listHookModel = self.listData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor =RGB_white;
    cell.backgroundColor =RGB_white;
    __block typeof(self) sself = self;
    cell.tapListHookCell =^(ListHookModel *model){
        BOOL ss = model.selected;
        for (ListHookModel *model in _listData) {
            model.selected = NO;
        }
        model.selected = ss;
        [sself.tableView reloadData];
        if (sself.searchItemType == SearchItemTypeCarSafe | sself.searchItemType == SearchItemTypeNetBankBill) {// 车险 //网银
            if (sself.selectedOneCity) {
                sself.selectedOneCity(model);
            }
            [sself jPopSelfWith:0.3];
            
        }else if (sself.searchItemType == SearchItemTypeCreditCardBill){// 信用卡
            
            YJRepoortCreditEmailBillDetailsVC *vc =[[YJRepoortCreditEmailBillDetailsVC alloc] init];
            vc.mainModel = _dataSource[indexPath.row];
            [self performSelector:@selector(pushCreditEmailBillDetailsVC:) withObject:vc afterDelay:0.3];
            
        }
        
        
        
    };
    
    if (indexPath.row == 0 ) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        view.backgroundColor = RGB_pageBackground;
        UIView *l = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-15, 0.5)];
        l.backgroundColor = RGB_grayLine;
        [cell.contentView addSubview:l];
    }else if ( indexPath.row == _listData.count-1 ) {
        UIView *l = [[UIView alloc]initWithFrame:CGRectMake( 0, cell.bounds.size.height-1.5, SCREEN_WIDTH,0.7 )];
        l.backgroundColor = RGB_grayLine;
        [cell.contentView addSubview:l];
        [cell bringSubviewToFront:l];
    }
    
    return cell;
    
}
-(void)pushCreditEmailBillDetailsVC:(UIViewController*)vc{
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
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

/**
 #pragma mark - 城市页面
 -(void)selectcity {
 
 __weak typeof(self) weakSelf = self;
 [YJShortLoadingView yj_makeToastActivityInView:self.view];
 __block NSString *type = [NSString new];
 if (self.searchItemType == SearchItemTypeHousingFund) {
 type = @"housefund";
 }else if (self.searchItemType == SearchItemTypeSocialSecurity){
 type = @"socialsecurity";
 }
 NSDictionary *dicParams =@{@"method" : urlJK_queryCities,
 @"mobile" : kUserManagerTool.mobile,
 @"userPwd": kUserManagerTool.userPwd,
 @"bizType":type
 };
 
 
 [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_queryCities] params:dicParams success:^(id responseObj) {
 MYLog(@"%@",responseObj);
 
 NSDictionary *list = [responseObj objectForKey:@"list"];
 if (![list isKindOfClass:[NSNull class]]&&([responseObj[@"code"] isEqualToString:@"0000"])) {//有数
 _cityModel = [cityModel mj_objectWithKeyValues:responseObj];
 
 NSArray *arr = [NSArray array];
 arr = _cityModel.list;
 
 
 for (citySearchModel *mm  in arr) {
 CitySelectModel *model = [[CitySelectModel alloc]init];
 model.city = mm;
 model.selectedImg = @"selected.png";
 // if ([mm.areaName isEqualToString:_cityString]) {
 //     model.isSelect = YES;
 // }else
 //    model.isSelect =NO;
 
 [_listData addObject:model];
 }
 
 
 dispatch_async(dispatch_get_main_queue(), ^{
 [YJShortLoadingView yj_hideToastActivityInView:weakSelf.view];
 [weakSelf.tableView reloadData];
 
 });
 
 }else{//无数据
 dispatch_async(dispatch_get_main_queue(), ^{
 [YJShortLoadingView yj_hideToastActivityInView:weakSelf.view];
 [weakSelf.view makeToast:[responseObj objectForKey:@"msg"]];
 
 });
 
 }
 } failure:^(NSError *error) {
 dispatch_async(dispatch_get_main_queue(), ^{
 
 [YJShortLoadingView yj_hideToastActivityInView:weakSelf.view];
 [weakSelf.view makeToast:errorInfo];
 
 });
 
 }];
 }
 */

/*
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
 switch (_CLSType) {
 case CLSTypeCredit:{//信用卡
 
 YJRepoortCreditEmailBillDetailsVC *vc =[[YJRepoortCreditEmailBillDetailsVC alloc] init];
 for (CitySelectModel *model in self.listData) {
 model.isSelect =NO;
 }
 CitySelectModel *model =  self.listData[indexPath.row];
 model.isSelect = YES;
 [self.tableView reloadData];
 
 
 vc.mainModel = _dataSource[indexPath.row];
 [self.navigationController pushViewController:vc animated:YES];
 
 break;
 
 }case CLSTypeCarInsuranc:{//车险
 
 break;
 
 }default:
 break;
 }
 
 //  if ([self.index isEqualToString:@"11"] ) {// 城市
 //     for (CitySelectModel *model in self.listData) {
 //         model.isSelect =NO;
 //     }
 //    CitySelectModel *model =  self.listData[indexPath.row];
 //    model.isSelect = YES;
 //    self.selectedOneCity(model);
 //    [self.tableView reloadData];
 
 //   [self performSelector:@selector(outself) withObject:nil afterDelay:0.3];
 
 // }else if ([self.index isEqualToString:@"12"] &&_dataSource.count ) {// 信用卡
 
 //  }
 
 
 }
 */

