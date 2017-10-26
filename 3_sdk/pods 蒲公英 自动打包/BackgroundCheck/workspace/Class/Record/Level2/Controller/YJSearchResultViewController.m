//
//  YJSearchResultViewController.m
//  BackgroundCheck
//
//  Created by yj on 2017/9/19.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "YJSearchResultViewController.h"

@interface YJSearchResultViewController ()<UISearchBarDelegate,UITextFieldDelegate>
{
    __block UISearchBar *_searchBar;
    __block UITextField *_searchTF;
    
    
}

@property (nonatomic, weak)  UILabel *searchTipLB;

@property (nonatomic, weak) YJNODataView *noDataView;



@end

@implementation YJSearchResultViewController
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
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[RGB(239, 239, 244) colorWithAlphaComponent:1]] forBarMetrics:UIBarMetricsDefault];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self setupSearchBar];
    
    [self setupSearchTipView];
    
}

- (void)setupSearchBar {
    
    
    //搜索框
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.showsCancelButton = YES;
//    _searchBar.frame = CGRectMake(0, 0, 200, 44);
    _searchBar.tintColor = RGB_navBar;
//    _searchBar.barTintColor = RGB(239, 239, 244);
    _searchBar.barTintColor = RGB_navBar;
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索";
    _searchBar.returnKeyType = UIReturnKeySearch;
    

    
    UIImageView *view = [[[_searchBar.subviews objectAtIndex:0] subviews] firstObject];
    view.layer.borderColor = RGB(239, 239, 244).CGColor;
    view.layer.borderWidth = 1;
    
    self.navigationItem.titleView = _searchBar;
////    [self.navigationController.navigationBar addSubview:_searchBar];
//    //取消按钮
//    UIButton *cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    cancelBtn.bounds= CGRectMake(0, 0, 36, 44);
//    cancelBtn.backgroundColor = RGBA(199, 199, 199, 0.5);
//    cancelBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 0, 0);
//    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
//    [cancelBtn setTitleColor:RGB_navBar forState:(UIControlStateNormal)];
//    [cancelBtn setTitleColor:RGB_navBar forState:(UIControlStateHighlighted)];
//    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]] ;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn] ;

    
    
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[RGB(239, 239, 244) colorWithAlphaComponent:1]] forBarMetrics:UIBarMetricsDefault];

    self.navigationController.navigationBar.shadowImage =[UIImage imageWithColor:[[UIColor cyanColor] colorWithAlphaComponent:0]];
    
    
    for (UIView *sonV in _searchBar.subviews) {
        if (sonV.subviews.count) {
            for (UIView *vv in sonV.subviews) {
                if ([vv isKindOfClass:[UIButton class]]) {
                    UIButton *cancleBtn = (UIButton *)vv;
                    [cancleBtn setTitle:@"取消" forState:(UIControlStateHighlighted)];
                    [cancleBtn setTitle:@"取消" forState:(UIControlStateNormal)];
                    

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
    
    
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]
          setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      RGB_navBar,
      NSForegroundColorAttributeName,nil]
     forState:UIControlStateNormal];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]
     setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      RGB_navBar,
      NSForegroundColorAttributeName,nil]
     forState:UIControlStateHighlighted];
    
    if ([kUserManagerTool isLogin]) {
        
    } else {
        LoginVC *ll = [[LoginVC alloc]init];
        JENavigationController *nav = [[JENavigationController alloc] initWithRootViewController:ll];
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
//            if (responseObj[@"data"]) {
//                if (responseObj[@"data"][@"list"]) {
//                    ReportFirstCommonMainModel *model = [ReportFirstCommonMainModel mj_objectWithKeyValues:responseObj[@"data"]];
//                    
//                    weakSelf.searchDataArray = model.list;
//                    [weakSelf.searchTipLB removeFromSuperview];
//                    [weakSelf setupSearchResultLB];
//                    [weakSelf setupFooterNODataView];
//                    [weakSelf.tableView reloadData];
//                    [_searchBar resignFirstResponder];
//                    //                _searchBar.text = nil;
//                }
//            }
            
            
        });
        
    } failure:^(NSError *error) {
        MYLog(@"-------结果列表失败");
        [weakSelf.view makeToast:errorInfo];
        
    }];
    
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchDataArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
//        YJReportEBankBillCell *cell = [YJReportEBankBillCell reportEBankBillCellWithTableView:tableView];
//        //        cell.account  = @"手机号码：";
//        //        cell.position  = @"身份证号：";
//        cell.model = self.searchDataArray[indexPath.row];
//        
        return cell;

    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

        //H5
//        ReportFirstCommonModel * mm = self.searchDataArray[indexPath.row];
//        ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
//        resultVc.token = mm.token;
//        resultVc.biztype = kBizType_ebank;
//        resultVc.getResult = @"0";
//        resultVc.url = result_web_url_;
//        [self.navigationController pushViewController:resultVc animated:YES];
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.searchDataArray.count) {
        [_searchBar resignFirstResponder];
        
    }
}


#pragma mark----搜索提示控件
- (NSString *)searchTip {
    return @"搜索姓名/手机号";
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
