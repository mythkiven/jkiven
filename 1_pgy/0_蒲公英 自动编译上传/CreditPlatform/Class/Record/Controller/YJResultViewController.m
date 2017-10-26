//
//  YJResultViewController.m
//  CreditPlatform
//
//  Created by yj on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJResultViewController.h"
#import "YJReportHouseFundCell.h"
#import "YJSearchConditionModel.h"
#import "YJReportHoseFundDetailsVC.h"
#import "YJReportSocialSecurityDetailsVC.h"
#import "OperatorsReportMainVC.h"
#import "ECommerceReportMainVC.h"
#import "YJReportCentralBankDetailsVC.h"
#import "YJReportEducationDetailsVC.h"
#import "ReportFirstCommonModel.h"
#import "YJReportCentralBankCell.h"
#import "YJReportTaoBaoDetailsVC.h"
#import "ReportLinkedinDetailsVC.h"
#import "YJReportCarInsurancTypeVC.h"
#import "YJReportNetbankBillTypeVC.h"

#import "YJReportCarInsuranceCell.h"

#import "ListHookVC.h"
#import "YJReportDishonestyDetailsVC.h"
#import "YJReportEBankBillCell.h"

#import "ResultWebViewController.h"
@interface YJResultViewController ()<UISearchBarDelegate,UITextFieldDelegate>
{
    __block UISearchBar *_searchBar;
    __block UITextField *_searchTF;
   

}

@property (nonatomic, weak)  UILabel *searchTipLB;

@property (nonatomic, weak) YJNODataView *noDataView;


@end

@implementation YJResultViewController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (YJNODataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [YJNODataView NODataView];
    }
    return _noDataView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    self.view.backgroundColor = RGB_pageBackground;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 140.0 + 10;

    if([self.searchType isEqualToString:kBizType_bill]||
       [self.searchType isEqualToString:kBizType_housefund]||
       [self.searchType isEqualToString:kBizType_socialsecurity]||
       [self.searchType isEqualToString:kBizType_linkedin]){
        self.tableView.rowHeight = 110.0 + 10;
    } else if ([self.searchType isEqualToString:kBizType_autoinsurance]) {
        self.tableView.rowHeight = 170.0 + 10;
    } else if ([self.searchType isEqualToString:kBizType_diditaxi]) {
        self.tableView.rowHeight = 80.0 + 10;
    }else{
        self.tableView.rowHeight = 140.0 + 10;
    }
    
//    if ([self.searchType isEqualToString:kBizType_mobile] ||
//        [self.searchType isEqualToString:kBizType_education] ||
//        [self.searchType isEqualToString:kBizType_jd] ||
//        [self.searchType isEqualToString:kBizType_taobao]||
//        [self.searchType isEqualToString:kBizType_shixin]||
//        [self.searchType isEqualToString:kBizType_bill]) {
//        self.tableView.rowHeight = 110.0 + 10;
//    }
//    if ([self.searchType isEqualToString:kBizType_autoinsurance]) {
//        self.tableView.rowHeight = 170.0 + 10;
//    }

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[RGB(239, 239, 244) colorWithAlphaComponent:1]] forBarMetrics:UIBarMetricsDefault];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self setupSearchBar];
    
    [self setupSearchTipView];
  
}

- (void)setupSearchBar {
    
//    _searchTF = [[UITextField alloc] init];
//    _searchTF.frame = CGRectMake(0, 0, 200, 44);
//    _searchTF.layer.borderColor = RGB_pageBackground.CGColor;
//    _searchTF.layer.borderWidth = 1;
//    _searchTF.tintColor = RGB_navBar;
//    //    _searchBar.barTintColor = RGB(239, 239, 244);
//    _searchTF.delegate = self;
//    _searchTF.placeholder = @"搜索";
//    _searchTF.returnKeyType = UIReturnKeySearch;
//    self.navigationItem.titleView = _searchTF;

    //搜索框
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.frame = CGRectMake(0, 0, 0, 44);
    _searchBar.tintColor = RGB_navBar;
    _searchBar.barTintColor = RGB(239, 239, 244);
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索";
    _searchBar.showsCancelButton = NO;
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    UIImageView *view = [[[_searchBar.subviews objectAtIndex:0] subviews] firstObject];
    view.layer.borderColor = RGB(239, 239, 244).CGColor;
    view.layer.borderWidth = 1;
    
    self.navigationItem.titleView = _searchBar;
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    cancelBtn.bounds= CGRectMake(0, 0, 44, 44);
    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancelBtn setTitleColor:RGB_navBar forState:(UIControlStateNormal)];
    [cancelBtn setTitleColor:RGB_navBar forState:(UIControlStateHighlighted)];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]] ;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn] ;
    
    
}


//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated
//     ]
//    
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[RGB(239, 239, 244) colorWithAlphaComponent:1]] forBarMetrics:UIBarMetricsDefault];

    self.navigationController.navigationBar.shadowImage =[UIImage imageWithColor:[[UIColor cyanColor] colorWithAlphaComponent:0]];
    
    
    for (UIView *sonV in _searchBar.subviews) {
        if (sonV.subviews.count) {
            for (UIView *vv in sonV.subviews) {
                if ([vv isKindOfClass:[UIButton class]]) {
                    UIButton *cancleBtn = (UIButton *)vv;
                    [cancleBtn setTitleColor:RGB_navBar forState:(UIControlStateNormal)];
                } else if ([vv isKindOfClass:[UITextField class]]) {
                    UITextField *tf = (UITextField *)vv;
                    tf.layer.borderWidth = 0.5;
                    tf.layer.borderColor = RGB(221, 221, 221).CGColor;
                    tf.layer.cornerRadius = 3;
                    tf.clipsToBounds = YES;
                }
            }
        }
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    
    if ([kUserManagerTool isLogin]) {
        
    } else {
        LoginVC *ll = [[LoginVC alloc]init];
        YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:ll];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_searchBar resignFirstResponder];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //引入新NAV已解决问题
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
    
//    self.navigationController.navigationBar.shadowImage =[UIImage imageWithColor:RGB(115, 115, 115)];
    
    if(iPhoneX){
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_inputSrearchBar object:@"YES"];
    }
    
    
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)cancelBtnClick {
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark ---UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (!kUserManagerTool.isLogin) {
        
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    MYLog(@"-------%@,%@,%@,%@",kUserManagerTool.mobile,kUserManagerTool.userPwd,self.searchType,searchBar.text);
    NSDictionary *dict = @{ @"method": @"recordListProcess",
                            @"mobile": kUserManagerTool.mobile,
                            @"userPwd": kUserManagerTool.userPwd,
                            @"bizType": self.searchType,
                            @"condition":searchBar.text,
                            @"appVersion":  VERSION_APP_1_4_4,
                            @"pageSize":  @"200",
                            @"pageNum": @"1",
                            };
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:@"recordListProcess"] params:dict success:^(id responseObj) {
        
        
        MYLog(@"我的结果-------结果列表：%@",responseObj);

        dispatch_async(dispatch_get_main_queue(), ^{
            if (responseObj[@"data"]) {
                if (responseObj[@"data"][@"list"]) {
                    ReportFirstCommonMainModel *model = [ReportFirstCommonMainModel mj_objectWithKeyValues:responseObj[@"data"]];

                    weakSelf.searchDataArray = model.list;
                    [weakSelf.searchTipLB removeFromSuperview];
                    [weakSelf setupSearchResultLB];
                    [weakSelf setupFooterNODataView];
                    [weakSelf.tableView reloadData];
                    [_searchBar resignFirstResponder];
//                _searchBar.text = nil;
                }
            }
            
            
        });
        
    } failure:^(NSError *error) {
        MYLog(@"-------结果列表失败");
        [weakSelf.view makeToast:errorInfo];
        
    }];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.searchDataArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *celll = nil;
    
    
    
    if ([self.searchType isEqualToString:@"housefund"]) {
        
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:3];
        cell.account  = @"账号：";
        cell.model = self.searchDataArray[indexPath.row];
        
        return cell;
        
    } else if ([self.searchType isEqualToString:@"socialsecurity"]) {
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:3];
        cell.account  = @"账号：";
        cell.model = self.searchDataArray[indexPath.row];
        
        return cell;
        
    } else if ( [self.searchType isEqualToString:@"maimai"]
               || [self.searchType isEqualToString:@"linkedin"]) {
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:3];
        cell.account  = @"账号：";
        cell.position  = @"职位：";
        cell.model = self.searchDataArray[indexPath.row];
        
        return cell;
        
    } else if ([self.searchType isEqualToString:@"mobile"]) {
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:2];
        cell.account  = @"手机号：";
        cell.model = self.searchDataArray[indexPath.row];
        
        
        return cell;  
        
    } else if ([self.searchType isEqualToString:@"jd"]
               || [self.searchType isEqualToString:@"taobao"]
               ) {
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:2];
        cell.model = self.searchDataArray[indexPath.row];
        cell.account  = @"账号：";
       
        
        return cell;
        
    } else if ([self.searchType isEqualToString:@"education"]) {
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:2];
        cell.model = self.searchDataArray[indexPath.row];
        cell.account  = @"账号：";
        
        return cell;
        
    } else if ([self.searchType isEqualToString:@"credit"]) {
        YJReportCentralBankCell *cell = [YJReportCentralBankCell reportCentralBankCellWithTableView:tableView];
        cell.model = self.searchDataArray[indexPath.row];
        
        return cell;
        
    } else if ([self.searchType isEqualToString:@"bill"]) {//信用卡
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:3];
        cell.model = self.searchDataArray[indexPath.row];
        cell.account  = @"账号：";
        
        return cell;
        
    } else if ([self.searchType isEqualToString:@"shixin"]) {//失信
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:2];
        cell.bizType = kBizType_shixin;
        cell.model = self.searchDataArray[indexPath.row];
        cell.account  = @"号码：";
        
        return cell;
        
    } else if ([self.searchType isEqualToString:kBizType_autoinsurance]) {//车险
        
        
        YJReportCarInsuranceCell *cell = [YJReportCarInsuranceCell reportCarInsuranceCellWithTableView:tableView];
        cell.model = self.searchDataArray[indexPath.row];
        
        return cell;
    } else if ( [self.searchType isEqualToString:kBizType_ebank]) {
        YJReportEBankBillCell *cell = [YJReportEBankBillCell reportEBankBillCellWithTableView:tableView];
        //        cell.account  = @"手机号码：";
        //        cell.position  = @"身份证号：";
        cell.model = self.searchDataArray[indexPath.row];
        
        return cell;
        
    }else if ( [self.searchType isEqualToString:kBizType_diditaxi]) { //DD
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:1];
        cell.bizType = kBizType_diditaxi;
        cell.model = self.searchDataArray[indexPath.row];
        cell.account  = @"查询日期：";
        
        return cell;
        
    }else if ( [self.searchType isEqualToString:kBizType_ctrip]) {//CTRIP
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:2];
        cell.bizType = kBizType_ctrip;
        cell.model = self.searchDataArray[indexPath.row];
        cell.account  = @"用户名：";
        
        return cell;
        
    }
    
//    /**
//     *  搜索类型
//     *  公积金  --->housefund
//     *  社保    --->socialsecurity
//     *  运营商  --->mobile
//     *  京东    --->jd
//     *  学信    --->education
//     *  央行    --->credit
//     *
//     */
//    if ([self.searchType isEqualToString:kBizType_housefund]) {
//        
//        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:NO];
//        cell.account  = @"账号：";
//        cell.model = self.searchDataArray[indexPath.row];
//        return cell;
//        
//    } else if ([self.searchType isEqualToString:kBizType_socialsecurity]) {
//        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:NO];
//       cell.account  = @"账号：";
//        cell.model = self.searchDataArray[indexPath.row];
//        return cell;
//        
//    } else if ([self.searchType isEqualToString:kBizType_mobile]) {
//        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:YES];
//        cell.account  = @"手机号：";
//        cell.model = self.searchDataArray[indexPath.row];
//        return cell;
//        
//    } else if ([self.searchType isEqualToString:kBizType_jd] ||
//               [self.searchType isEqualToString:kBizType_taobao]) {
//        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:YES];
//        cell.account  = @"账号：";
//        cell.model = self.searchDataArray[indexPath.row];
//        return cell;
//        
//    } else if ([self.searchType isEqualToString:kBizType_education]) {
//        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:YES];
//        cell.account  = @"账号：";
//        cell.model = self.searchDataArray[indexPath.row];
//        return cell;
//        
//    } else if ([self.searchType isEqualToString:kBizType_credit]) {
//        YJReportCentralBankCell *cell = [YJReportCentralBankCell reportCentralBankCellWithTableView:tableView];
//        cell.model = self.searchDataArray[indexPath.row];
//        return cell;
//        
//    } else if ([self.searchType isEqualToString:kBizType_maimai]
//               || [self.searchType isEqualToString:kBizType_linkedin]) { // 脉脉
//        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:NO];
//        cell.account  = @"账号：";
//        cell.position  = @"职位：";
//        cell.model = self.searchDataArray[indexPath.row];
//        
//
//        return cell;
//        
//    } else if ([self.searchType isEqualToString:kBizType_shixin]) {//失信
//        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:YES];
//        cell.bizType = kBizType_shixin;
//        cell.model = self.searchDataArray[indexPath.row];
//        cell.account  = @"号码：";
//        
//        return cell;
//        
//    } else if ([self.searchType isEqualToString:kBizType_bill]) {//信用卡
//        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:YES];
//        cell.model = self.searchDataArray[indexPath.row];
//        cell.account  = @"账号：";
//        return cell;
//        
//    } else if ([self.searchType isEqualToString:kBizType_autoinsurance]) {//车险
//        
//        YJReportCarInsuranceCell *cell = [YJReportCarInsuranceCell reportCarInsuranceCellWithTableView:tableView];
//        cell.model = self.searchDataArray[indexPath.row];
//        
//        return cell;
//        
//    } else if ( [self.searchType isEqualToString:kBizType_ebank]) {
//        YJReportEBankBillCell *cell = [YJReportEBankBillCell reportEBankBillCellWithTableView:tableView];
//
//        cell.model = self.searchDataArray[indexPath.row];
//        
//        return cell;
//        
//    }

    return nil;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.searchType isEqualToString:kBizType_housefund]) {
        
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        
        YJReportHoseFundDetailsVC *vc = [[YJReportHoseFundDetailsVC alloc] init];
        vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
        vc.searchConditionModel.type = 12;
        vc.searchConditionModel.ID = mm.id;
        
        [self.navigationController pushViewController:vc animated:YES];

        
    } else if ([self.searchType isEqualToString:kBizType_socialsecurity]) {
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];

        YJReportSocialSecurityDetailsVC *vc = [[YJReportSocialSecurityDetailsVC alloc] init];
        vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
        vc.searchConditionModel.type = 12;
        vc.searchConditionModel.ID = mm.id;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([self.searchType isEqualToString:kBizType_mobile]) {
        
        //H5
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
        resultVc.token = mm.token;
        resultVc.biztype = kBizType_mobile;
        resultVc.getResult = @"0";
        resultVc.url = result_web_url_;
        [self.navigationController pushViewController:resultVc animated:YES];
        
        // 原生:
//        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
//        OperatorsReportMainVC *vc = [[OperatorsReportMainVC alloc] init];
//        vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//        vc.searchConditionModel.type = 12;
//        vc.searchConditionModel.ID = mm.id;
//        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([self.searchType isEqualToString:kBizType_jd]) {
        
        //H5
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
        resultVc.token = mm.token;
        resultVc.biztype = kBizType_jd;
        resultVc.getResult = @"0";
        resultVc.url = result_web_url_;
        [self.navigationController pushViewController:resultVc animated:YES];
        
        // 原生:
//        
//        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
//        ECommerceReportMainVC *vc = [[ECommerceReportMainVC alloc] init];
//        vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//        vc.searchConditionModel.type = 12;
//        vc.searchConditionModel.ID = mm.id;
//        [self.navigationController pushViewController:vc animated:YES];

        
    } else if ([self.searchType isEqualToString:kBizType_credit]) {
        //H5
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
        resultVc.token = mm.token;
        resultVc.biztype = kBizType_credit;
        resultVc.getResult = @"0";
        resultVc.url = result_web_url_;
        [self.navigationController pushViewController:resultVc animated:YES];
        
        // 原生:
//        
//        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
//        YJReportCentralBankDetailsVC *vc = [[YJReportCentralBankDetailsVC alloc] init];
//        vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//        vc.searchConditionModel.type = 12;
//        vc.searchConditionModel.ID = mm.id;
//        [self.navigationController pushViewController:vc animated:YES];
    } else if ([self.searchType isEqualToString:kBizType_education]) {
        //H5
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
        resultVc.token = mm.token;
        resultVc.biztype = kBizType_education;
        resultVc.getResult = @"0";
        resultVc.url = result_web_url_;
        [self.navigationController pushViewController:resultVc animated:YES];
        
        // 原生:
//        
//        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
//        YJReportEducationDetailsVC *vc = [[YJReportEducationDetailsVC alloc] init];
//        vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//        vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
//        vc.searchConditionModel.ID = mm.id;
//        [self.navigationController pushViewController:vc animated:YES];
    } else if ([self.searchType isEqualToString:kBizType_taobao]) {
        //H5
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
        resultVc.token = mm.token;
        resultVc.biztype = kBizType_taobao;
        resultVc.getResult = @"0";
        resultVc.url = result_web_url_;
        [self.navigationController pushViewController:resultVc animated:YES];
        
        // 原生:
//        
//        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
//        YJReportTaoBaoDetailsVC *vc = [[YJReportTaoBaoDetailsVC alloc] init];
//        vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//        vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
//        vc.searchConditionModel.ID = mm.id;
//        [self.navigationController pushViewController:vc animated:YES];

        
    } else if ([self.searchType isEqualToString:kBizType_maimai]) {
        //H5
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
        resultVc.token = mm.token;
        resultVc.biztype = kBizType_maimai;
        resultVc.getResult = @"0";
        resultVc.url = result_web_url_;
        [self.navigationController pushViewController:resultVc animated:YES];
        
        // 原生:
//        
//        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
//
//        ReportLinkedinDetailsVC *vc = [[ReportLinkedinDetailsVC alloc] init];
//        vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//        vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
//        vc.recodeType = self.searchType;
//        vc.searchConditionModel.ID = mm.id;
//        [self.navigationController pushViewController:vc animated:YES];
    } else if ([self.searchType isEqualToString:kBizType_linkedin]) {
        //H5
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
        resultVc.token = mm.token;
        resultVc.biztype = kBizType_linkedin;
        resultVc.getResult = @"0";
        resultVc.url = result_web_url_;
        [self.navigationController pushViewController:resultVc animated:YES];
        
        // 原生:
//        
//        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
//        ReportLinkedinDetailsVC *vc = [[ReportLinkedinDetailsVC alloc] init];
//        vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//        vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
//        vc.recodeType = self.searchType;
//        vc.searchConditionModel.ID = mm.id;
//        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.searchType isEqualToString:kBizType_shixin]) {//失信
        //H5
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
        resultVc.token = mm.token;
        resultVc.biztype = kBizType_shixin;
        resultVc.getResult = @"0";
        resultVc.url = result_web_url_;
        [self.navigationController pushViewController:resultVc animated:YES];
        
        // 原生:
//        
//        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
//        YJReportDishonestyDetailsVC *vc = [[YJReportDishonestyDetailsVC alloc] init];
//        vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//        vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
//        vc.recodeType = self.searchType;
//        vc.searchConditionModel.ID = mm.id;
//        [self.navigationController pushViewController:vc animated:YES];
    } else if ([self.searchType isEqualToString:kBizType_bill]) {//信用卡
        //H5
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
        resultVc.token = mm.token;
        resultVc.biztype = kBizType_bill;
        resultVc.getResult = @"0";
        resultVc.url = result_web_url_;
        [self.navigationController pushViewController:resultVc animated:YES];
        
        // 原生:
//        
//        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
//        ListHookVC *vc = [[ListHookVC alloc] init];
//        vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//        vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
//        vc.recodeType = self.searchType;
//        // vc.searchItemType = SearchItemTypeCreditCardBill;
//        vc.searchConditionModel.ID = mm.id;
//        [self.navigationController pushViewController:vc animated:YES];
    } else if ([self.searchType isEqualToString:kBizType_autoinsurance]) {//车险
        //H5
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
        resultVc.token = mm.token;
        resultVc.biztype = kBizType_autoinsurance;
        resultVc.getResult = @"0";
        resultVc.url = result_web_url_;
        [self.navigationController pushViewController:resultVc animated:YES];
        
        // 原生:
//        
//        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
//        YJReportCarInsurancTypeVC *vc = [[YJReportCarInsurancTypeVC alloc] init];
//        vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//        vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
//        vc.recodeType = self.searchType;
//        // vc.searchItemType = SearchItemTypeCreditCardBill;
//        vc.searchConditionModel.ID = mm.id;
//        [self.navigationController pushViewController:vc animated:YES];
    } else if ([self.searchType isEqualToString:kBizType_ebank]) {//网银
        //H5
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
        resultVc.token = mm.token;
        resultVc.biztype = kBizType_ebank;
        resultVc.getResult = @"0";
        resultVc.url = result_web_url_;
        [self.navigationController pushViewController:resultVc animated:YES];
        
        // 原生:
//        
//        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
//        YJReportNetbankBillTypeVC *vc = [[YJReportNetbankBillTypeVC alloc] init];
//        vc.searchConditionModel = [[YJSearchConditionModel alloc]init];
//        vc.searchConditionModel.type = YJGoToSearchResultTypeFromRecord;
//        vc.recodeType = self.searchType;
//        vc.searchConditionModel.ID = mm.id;
//        [self.navigationController pushViewController:vc animated:YES];
    } else if ([self.searchType isEqualToString:kBizType_diditaxi]) {//dd
        //H5
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
        resultVc.token = mm.token;
        resultVc.biztype = kBizType_diditaxi;
        resultVc.getResult = @"0";
        resultVc.url = result_web_url_;
        [self.navigationController pushViewController:resultVc animated:YES];
        
        // 原生:
    } else if ([self.searchType isEqualToString:kBizType_ctrip]) {//xc
        //H5
        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
        resultVc.token = mm.token;
        resultVc.biztype = kBizType_ctrip;
        resultVc.getResult = @"0";
        resultVc.url = result_web_url_;
        [self.navigationController pushViewController:resultVc animated:YES];
        
        // 原生:
    }

    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.searchDataArray.count) {
        [_searchBar resignFirstResponder];

    }
}


#pragma mark----搜索提示控件
- (NSString *)searchTip {
    if ([self.searchType isEqualToString:kBizType_housefund]) {
        return @"搜索账号/真实姓名";
    } else if ([self.searchType isEqualToString:kBizType_socialsecurity]) {
        return @"搜索账号/真实姓名";
    } else if ([self.searchType isEqualToString:kBizType_mobile]) {
        return @"搜索手机号";
    } else if ([self.searchType isEqualToString:kBizType_jd]) {
        return @"搜索账号/真实姓名";
    } else if ([self.searchType isEqualToString:kBizType_credit]) {
        return @"搜索登录名/真实姓名";
    } else if ([self.searchType isEqualToString:kBizType_education]) {
        return @"搜索账号/证件号/真实姓名";
    } else if ([self.searchType isEqualToString:kBizType_taobao]) {
        return @"搜索账号/真实姓名";
        
    } else if ([self.searchType isEqualToString:kBizType_linkedin] || [self.searchType isEqualToString:kBizType_maimai]) {
        return @"搜索账号/职位/真实姓名";
        
    } else if ([self.searchType isEqualToString:kBizType_bill]) {
        return @"搜索账号/真实姓名";
        
    } else if ([self.searchType isEqualToString:kBizType_shixin]) {
        return @"搜索姓名/身份证号/组织机构代码";
        
    } else if ([self.searchType isEqualToString:kBizType_autoinsurance]) {
        return @"搜索车牌/投保人姓名/投保人证件号";
        
    } else if ([self.searchType isEqualToString:kBizType_ebank]) {
        return @"搜索真实姓名/账号/手机号";
        
    } else if ([self.searchType isEqualToString:kBizType_diditaxi]) {
        return @"搜索用户名";
        
    } else if ([self.searchType isEqualToString:kBizType_ctrip]) {
        return @"搜索真实姓名/用户名/手机号";
        
    }
    
    return nil;
}

- (void)setupSearchTipView {
    UILabel *searchTipLB = [[UILabel alloc] init];
    self.searchTipLB = searchTipLB;
    searchTipLB.text = [self searchTip];
    searchTipLB.textAlignment = NSTextAlignmentCenter;
    searchTipLB.frame = CGRectMake(0, 75, SCREEN_WIDTH, 30);
    searchTipLB.font = Font18;
    searchTipLB.textColor = RGB_grayNormalText;
    [self.view addSubview:searchTipLB];

}

- (void)setupSearchResultLB {
    UILabel *searchTipLB = [[UILabel alloc] init];
    searchTipLB.text = @"搜索结果";
    searchTipLB.textAlignment = NSTextAlignmentLeft;
    searchTipLB.frame = CGRectMake(15, 0, SCREEN_WIDTH-15, 40);
    searchTipLB.font = Font15;
    searchTipLB.textColor = RGB_grayNormalText;
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    [bgView addSubview:searchTipLB];
    self.tableView.tableHeaderView = bgView;
}

- (void)setupFooterNODataView {

    if (self.searchDataArray.count == 0) {
        self.tableView.tableHeaderView = nil;
        self.tableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:self.noDataView];
    
    } else {
        [self.noDataView removeFromSuperview];
        NSString *tip = @"没有更多数据了";
        UILabel *noDataLB = [[UILabel alloc] init];
        noDataLB.backgroundColor = [UIColor clearColor];
        noDataLB.text = tip;
        noDataLB.textAlignment = NSTextAlignmentCenter;
        noDataLB.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        noDataLB.font = Font15;
        noDataLB.textColor = RGB_grayPlaceHoldText;
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = RGB_pageBackground;
        [bgView addSubview:noDataLB];
        self.tableView.tableFooterView = bgView;
    }
    

}
@end
