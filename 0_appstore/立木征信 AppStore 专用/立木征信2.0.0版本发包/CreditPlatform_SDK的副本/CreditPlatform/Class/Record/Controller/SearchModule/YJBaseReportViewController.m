//
//  YJBaseReportViewController.m
//  CreditPlatform
//
//  Created by yj on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJBaseReportViewController.h"
#import "YJReportHouseFundVC.h"
#import "YJResultViewController.h"
#import "ReportFirstCommonModel.h"

#import "YJReportHouseFundCell.h"
#import "ReportFirstCommonModel.h"
#import "CommonSearchVC.h"
#import "LoginVC.h"
#import "YJReportCentralBankCell.h"
#import "YJReportCarInsuranceCell.h"
#import "YJReportEBankBillCell.h"

#import "JHousingFundSocialSecurityVC.h"
#import "CarInsurancSearchVC.h"
#import "YJRecordModel.h"
#import <CommonCrypto/CommonDigest.h>
#import "YJReportHoseFundDetailsVC.h"
#import "ResultWebViewController.h"
#import "YJReportSocialSecurityDetailsVC.h"
#import "YJAuthorizationViewController.h"
#import "YJAuthTipModalView.h"

@interface YJBaseReportViewController ()<UIViewControllerPreviewingDelegate>
{
    UISearchBar *_searchBar;
    UIButton *_searchBarBtn;
    UIView *_startSearchView;
    YJRefreshGifHeader *_refreshGifHeader;
    MJRefreshFooter *_refreshFooter;
    
    int _currentPage;
    BOOL _isMore;
    LMZXSDK * _lmzxSDK;
    YJRecordModel *_recordModel;
}
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) YJAuthTipModalView *authTipModalView;


//@property (nonatomic, strong) NSArray *sectionTitlesArray;
@end

@implementation YJBaseReportViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (YJAuthTipModalView *)authTipModalView {
    if (_authTipModalView == nil) {
        _authTipModalView = [[YJAuthTipModalView alloc] init];
    }
    return _authTipModalView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.backgroundColor = RGB_pageBackground;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    

    if([self.searchType isEqualToString:kBizType_housefund]||
       [self.searchType isEqualToString:kBizType_ebank]||
       [self.searchType isEqualToString:kBizType_socialsecurity]||
       [self.searchType isEqualToString:kBizType_linkedin]){ // 3行 公积金
        self.tableView.rowHeight = 140.0 + 10;
    } else if ([self.searchType isEqualToString:kBizType_autoinsurance]) { // 车险 4行
        self.tableView.rowHeight = 170.0 + 10;
    } else if ([self.searchType isEqualToString:kBizType_diditaxi]) { // 滴滴1行
        self.tableView.rowHeight = 80.0 + 10;
    }else{ // 运营商 JD 等2行
       self.tableView.rowHeight = 110.0 + 10;
    }
    
    [self setupRefreshControl];
    [_refreshGifHeader beginRefreshing];
    [self setupNODataSearchView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showView) name:YJNotificationUserLogout object:nil];
    
    

}
#pragma mark---监听到退出登录调用
-(void)showView{
    self.dataArray = nil;
    [_searchBarBtn removeFromSuperview];
    _searchBarBtn = nil;
    self.tableView.tableFooterView= nil;
    _searchBar = nil;
    [self setupNODataSearchView];

    [_refreshGifHeader beginRefreshing];
    [self.tableView reloadData];
    
}
#pragma mark--当有记录时创建
- (void)creatUI {
    [_startSearchView removeFromSuperview];
    [self setupSearchBar];
//    [self setupFooterNODataView];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
   

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}


- (void)setupSearchBar {
    if (_searchBarBtn == nil) {
        _searchBarBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _searchBarBtn.backgroundColor = RGB_pageBackground;
        _searchBarBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        
        [_searchBarBtn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"搜索";
        _searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        _searchBar.barTintColor = RGB_pageBackground;
        _searchBar.userInteractionEnabled = NO;
        UIImageView *view = [[[_searchBar.subviews objectAtIndex:0] subviews] firstObject];
        view.layer.borderColor = RGB_pageBackground.CGColor;
        view.layer.borderWidth = 1;
        
        for (UIView *sonV in _searchBar.subviews) {
            if (sonV.subviews.count) {
                for (UIView *vv in sonV.subviews) {
                    if ([vv isKindOfClass:[UITextField class]]) {
                        UITextField *tf = (UITextField *)vv;
                        tf.layer.borderWidth = 0.5;
                        tf.layer.borderColor = RGB(221, 221, 221).CGColor;
                        tf.layer.cornerRadius = 3;
                        tf.clipsToBounds = YES;
                        break;
                    }
                }
            }
        }
        [_searchBarBtn addSubview:_searchBar];
    }

    
    self.tableView.tableHeaderView = _searchBarBtn;
}
/**
 *  设置刷新控件
 */
- (void)setupRefreshControl {

    __weak typeof(self) sself = self;

    // 下拉刷新
    _refreshGifHeader = [YJRefreshGifHeader yj_headerWithRefreshingBlock:^{
        
        // 加载数据
        _isMore = NO;
        [sself sendNetWorking];
        
    }];
    

    self.tableView.mj_header = _refreshGifHeader;
    
    
    _refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _isMore = YES;
        [sself sendNetWorking];
    }];
    _refreshFooter.hidden = YES;
    self.tableView.mj_footer = _refreshFooter;
    
}

/**
 *  底部无数据提示
 */
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

#pragma mark---跳转控制器
- (void)click {
    
    YJResultViewController *resultVC = [[YJResultViewController alloc] init];
    resultVC.searchType = self.searchType;
    
    [self.parentViewController.navigationController pushViewController:resultVC animated:YES];
    
    
}

#pragma mark---数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *celll = nil;
    if ([self.searchType isEqualToString:@"housefund"]) {
        
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:3];
        cell.account  = @"账号：";
        cell.model = self.dataArray[indexPath.row];
        
        [self isForceTouchCapabilityAvailableWithSourceView:cell];

        
        
        return cell;
        
    } else if ([self.searchType isEqualToString:@"socialsecurity"]) {
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:3];
        cell.account  = @"账号：";
        cell.model = self.dataArray[indexPath.row];
        [self isForceTouchCapabilityAvailableWithSourceView:cell];



        return cell;
        
    } else if ( [self.searchType isEqualToString:@"maimai"]
               || [self.searchType isEqualToString:@"linkedin"]) {
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:3];
        cell.account  = @"账号：";
        cell.position  = @"职位：";
        cell.model = self.dataArray[indexPath.row];
        [self isForceTouchCapabilityAvailableWithSourceView:cell];



        return cell;
        
    } else if ([self.searchType isEqualToString:@"mobile"]) {
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:2];
        cell.account  = @"手机号：";
        cell.model = self.dataArray[indexPath.row];
        [self isForceTouchCapabilityAvailableWithSourceView:cell];



        return cell;
        
    } else if ([self.searchType isEqualToString:@"jd"]
               || [self.searchType isEqualToString:@"taobao"]
               ) {
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:2];
        cell.model = self.dataArray[indexPath.row];
        cell.account  = @"账号：";
        [self isForceTouchCapabilityAvailableWithSourceView:cell];



        return cell;
        
    } else if ([self.searchType isEqualToString:@"education"]) {
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:2];
        cell.model = self.dataArray[indexPath.row];
        cell.account  = @"账号：";
        [self isForceTouchCapabilityAvailableWithSourceView:cell];


        return cell;
        
    } else if ([self.searchType isEqualToString:@"credit"]) {
        YJReportCentralBankCell *cell = [YJReportCentralBankCell reportCentralBankCellWithTableView:tableView];
        cell.model = self.dataArray[indexPath.row];

        [self isForceTouchCapabilityAvailableWithSourceView:cell];

        return cell;
        
    } else if ([self.searchType isEqualToString:@"bill"]) {//信用卡
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:2];
        cell.model = self.dataArray[indexPath.row];
        cell.account  = @"账号：";
        [self isForceTouchCapabilityAvailableWithSourceView:cell];
        
        return cell;
        
    } else if ([self.searchType isEqualToString:@"shixin"]) {//失信
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:2];
        cell.bizType = kBizType_shixin;
        cell.model = self.dataArray[indexPath.row];
        cell.account  = @"号码：";
        
        [self isForceTouchCapabilityAvailableWithSourceView:cell];
        
        return cell;
        
    } else if ([self.searchType isEqualToString:kBizType_autoinsurance]) {//车险
        
        
        YJReportCarInsuranceCell *cell = [YJReportCarInsuranceCell reportCarInsuranceCellWithTableView:tableView];
        cell.model = self.dataArray[indexPath.row];

        [self isForceTouchCapabilityAvailableWithSourceView:cell];
        
        return cell;
    } else if ( [self.searchType isEqualToString:kBizType_ebank]) {
        YJReportEBankBillCell *cell = [YJReportEBankBillCell reportEBankBillCellWithTableView:tableView];
//        cell.account  = @"手机号码：";
//        cell.position  = @"身份证号：";
        cell.model = self.dataArray[indexPath.row];
        [self isForceTouchCapabilityAvailableWithSourceView:cell];
        
        return cell;
        
    }else if ( [self.searchType isEqualToString:kBizType_diditaxi]) { //DD
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:1];
        cell.bizType = kBizType_diditaxi;
        cell.model = self.dataArray[indexPath.row];
        cell.account  = @"查询日期：";
        [self isForceTouchCapabilityAvailableWithSourceView:cell];
        
        return cell;
        
    }else if ( [self.searchType isEqualToString:kBizType_ctrip]) {//CTRIP
        YJReportHouseFundCell *cell = [YJReportHouseFundCell reportHouseFundCellWithTableView:tableView  isShow:2];
        cell.bizType = kBizType_ctrip;
        cell.model = self.dataArray[indexPath.row];
        cell.account  = @"用户名：";
        [self isForceTouchCapabilityAvailableWithSourceView:cell];
        return cell;
        
    }

    

    
    return celll;
}

#warning 统一处理点击事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 不
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
//    
//    
////     [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    
//    // getResult=1&token=892441055a7b440daa21d247fd879e68&bizType=jd
//    //    if (code == 0 &&token.length>0&functionType.length>0 ) {
//    ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
//    resultVc.token = @"17f28718ff9f4a0190f6e1d56ff4a36d";
//    resultVc.biztype = @"housefund";
//    resultVc.getResult = @"0";
//    //        resultVc.url = @"http://192.168.117.239:8185/data/query";
//    YJNavigationController *navResultVC = [[YJNavigationController alloc]
//                                           initWithRootViewController:resultVc];
//    
//    [self presentViewController:navResultVC
//                       animated:YES
//                     completion:nil];
//    
//    
//}




/**
 判断3DTouch是否可用
 */
- (void)isForceTouchCapabilityAvailableWithSourceView:(UIView *)view {
    if (iOS9_OR_LATER) {
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [self registerForPreviewingWithDelegate:self sourceView:view];
            
        }
    }
}



#pragma mark - 网络
- (void)sendNetWorking {
    
    if (!kUserManagerTool.isLogin) {
        [_refreshGifHeader endRefreshing];
        return;
    }
    
//#warning 调试过滤----页面加入后，删除
//    if ([self.searchType isEqualToString:@"taobao"] || [self.searchType isEqualToString:@"linkedin"] || [self.searchType isEqualToString:@"maimai"]) {
//        
//        [_refreshGifHeader endRefreshing];
//
//        return;
//    }
    if (_isMore) {
        _currentPage++;
        if (_currentPage > [_recordModel.pages intValue]) {
            
            [_refreshFooter endRefreshingWithNoMoreData];
            return ;
        }
        
    } else{
        _currentPage = 1;
    }
    
    NSString *currentPageStr = [NSString stringWithFormat:@"%d",_currentPage];
    
    __weak typeof(self) weakSelf = self;
    NSDictionary *dicParams =@{@"method" : urlJK_recordListProcess,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"bizType":self.searchType,
                               @"appVersion":   VERSION_APP_1_4_4,
                               @"condition":@"",
                               @"pageSize":    @"20",
                               @"pageNum":      currentPageStr};

    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_recordListProcess] params:dicParams success:^(id responseObj) {
        MYLog(@"记录结果11111------%@",responseObj);
        if (_currentPage == 1) {
            [weakSelf.dataArray removeAllObjects];
        }
        if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            _recordModel = [YJRecordModel mj_objectWithKeyValues:responseObj[@"data"]];
            
            [weakSelf.dataArray addObjectsFromArray:_recordModel.list];
        }
        
    
       
//        ReportFirstCommonMainModel *model = [ReportFirstCommonMainModel mj_objectWithKeyValues:responseObj];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
            [_refreshGifHeader endRefreshing];
            [_refreshFooter endRefreshing];
            
            if (weakSelf.dataArray.count == 0) {
                [_refreshFooter setHidden:YES];
                [weakSelf setupNODataSearchView];
            } else {
                
                if ([_recordModel.isLastPage isEqualToString:@"1"]) {
                    [_refreshFooter endRefreshingWithNoMoreData];
                    
                }
                _refreshFooter.hidden = NO;
                [weakSelf creatUI];
                [weakSelf.tableView reloadData];
                
            }
            
//            if (model.list) {
//                if (model.list.count) {
//                    weakSelf.dataArray = model.list;
//                    [weakSelf creatUI];
//                    [weakSelf.tableView reloadData];
//                } else {
//                    [weakSelf setupNODataSearchView];
//                }
//            }
//            [_refreshGifHeader endRefreshing];
        });


    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.view makeToast:errorInfo];
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
            [_refreshGifHeader endRefreshing];
            [_refreshFooter endRefreshing];
        });


    }];
    
}






- (void)setupNODataSearchView {
    if (_startSearchView == nil) {
        _startSearchView = [[UIView alloc] init];
        _startSearchView.backgroundColor = RGB_pageBackground;
        _startSearchView.frame = CGRectMake((SCREEN_WIDTH-200)*0.5, 77, 200, 100);
        
        UILabel *lb = [[UILabel alloc] init];
        lb.font = Font17;
        lb.frame = CGRectMake(0, 5, 200, 30);
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = RGB_grayNormalText;
        lb.backgroundColor = [UIColor clearColor];
        lb.text = @"您还没有相关查询报告";
        [_startSearchView addSubview:lb];
        
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame =CGRectMake(0, 100-50, 200, 45);
        [btn setTitle:@"开始查询" forState:(UIControlStateNormal)];
        btn.layer.cornerRadius = 2;
        btn.layer.masksToBounds = YES;
        [btn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
        [btn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
        [btn setTitleColor:RGB_white forState:UIControlStateNormal];
        [btn setTitleColor:RGB_white forState:UIControlStateHighlighted];
        [_startSearchView addSubview:btn];
        [btn addTarget:self action:@selector(startSearchBtnClcik) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    [self.view addSubview:_startSearchView];

    
}

/**
 *  开始查询
 */
- (void)startSearchBtnClcik {
    MYLog(@"开始查询%@",self.searchType);
    
    
    if (!kUserManagerTool.isLogin) {
        
        LoginVC *vv =[[LoginVC alloc] init];
//        vv.isFrom = 103;
        YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:vv];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    if ([kUserManagerTool.authStatus intValue] != 20){// 资质认证
        [self.authTipModalView showInRect:self.view.frame];
        
        self.authTipModalView.authBlock = ^(){
            YJAuthorizationViewController  *VC = [[YJAuthorizationViewController alloc] init];
            
            [weakSelf.navigationController pushViewController:VC animated:YES];
        };
        
        return;
        
    }
    
    LMZXSDKFunction sdkFunction=-1;
    
    if ([self.searchType isEqualToString:kBizType_housefund]) {
        sdkFunction = LMZXSDKFunctionHousingFund;
    } else if ([self.searchType isEqualToString:kBizType_socialsecurity]) {
        sdkFunction = LMZXSDKFunctionSocialSecurity;
    } else if ([self.searchType isEqualToString:kBizType_mobile]) {
        sdkFunction = LMZXSDKFunctionMobileCarrie;
    } else if ([self.searchType isEqualToString:kBizType_jd]) {
        sdkFunction = LMZXSDKFunctionJD;
    } else if ([self.searchType isEqualToString:kBizType_credit]) {
        sdkFunction = LMZXSDKFunctionCentralBank;
    } else if ([self.searchType isEqualToString:kBizType_education]) {
        sdkFunction = LMZXSDKFunctionEducation;
    } else if ([self.searchType isEqualToString:kBizType_taobao]) {
        sdkFunction = LMZXSDKFunctionTaoBao;
    } else if ([self.searchType isEqualToString:kBizType_linkedin]) {
        sdkFunction = LMZXSDKFunctionLinkedin;
    } else if ([self.searchType isEqualToString:kBizType_maimai]) {
        sdkFunction = LMZXSDKFunctionMaimai;
    } else if ([self.searchType isEqualToString:kBizType_bill]) {
        sdkFunction = LMZXSDKFunctionCreditCardBill;
    } else if ([self.searchType isEqualToString:kBizType_shixin]) { // 失信
       
        CommonSearchVC *commonSearchVc = [[CommonSearchVC alloc] init];
        commonSearchVc.searchItemType = SearchItemTypeLostCredit;
        [self.navigationController pushViewController:commonSearchVc animated:YES];
        return;
        
    } else if ([self.searchType isEqualToString:kBizType_autoinsurance]) {
        sdkFunction = LMZXSDKFunctionAutoinsurance;
    } else if ([self.searchType isEqualToString:kBizType_ebank]) {
        sdkFunction = LMZXSDKFunctionEBankBill;
    }else if ([self.searchType isEqualToString:kBizType_ctrip]) {// 携程
        sdkFunction = LMZXSDKFunctionCtrip;
    }else if ([self.searchType isEqualToString:kBizType_diditaxi]) {//滴滴
        sdkFunction = LMZXSDKFunctionDiDiTaxi;
    }
    
    __block typeof(self) wself = self;
    

    [self initSDK];
    _lmzxSDK.channel = kChannelSDK;
    [_lmzxSDK startFunction:sdkFunction authCallBack:^(NSString *authInfo) {
        [wself sign:authInfo];
        //                [[LMZXSDK shared] sendReqWithSign:singString];
        
        
    }];

    // 结果回调
    [self handleResult:self.searchType];
    
    

    
}




#pragma mark -  初始化SDK
- (void)initSDK {
    
    
    
    // 特殊处理, 可以配置测试环境
    [LMZXSDK shared].lmzxTestURL = lm_url;
    
    if (kUserManagerTool.apiKey  ) {
        lm_APIKEY = kUserManagerTool.apiKey;
        //        lm_APIKEY = @"8240517622587971";
    }
    //    if (kUserManagerTool.aesKey  ) {
    //        lm_APISECRET =  kUserManagerTool.aesKey;
    ////        lm_APISECRET =  @"7310r3sn1t1REt68rRcZWFOW7Ly5rx7y" ;
    //    }
    if (kUserManagerTool.username ) {
        lm_UID =kUserManagerTool.username;
    }else if (kUserManagerTool.mobile ) {
        lm_UID =kUserManagerTool.mobile;
    }else {
        lm_UID = @"lm_UID";
    }
    
    
    MYLog(@"lm_APIKEY====%@",lm_APIKEY);
    if(!_lmzxSDK){
        _lmzxSDK = [LMZXSDK lmzxSDKWithApikey:lm_APIKEY uid:lm_UID callBackUrl:lm_CALLBACKURL];
    }
    // 切换了用户
    if(![_lmzxSDK.lmzxApiKey isEqualToString:kUserManagerTool.apiKey]){
        _lmzxSDK.lmzxApiKey = kUserManagerTool.apiKey;
        _lmzxSDK.lmzxUid = lm_UID;
    }
    
    // 导航条颜色
    _lmzxSDK.lmzxThemeColor =  RGB(48, 113, 242);
    // 返回按钮文字\图片颜色,标题颜色
    _lmzxSDK.lmzxTitleColor = [UIColor whiteColor];
    // 查询页面协议文字颜色,和查询动画页面的动画颜色,文字颜色相同
    _lmzxSDK.lmzxProtocolTextColor = RGB(48, 113, 242) ;
    // 提交按钮颜色
    _lmzxSDK.lmzxSubmitBtnColor = RGB(57, 179, 27);
    // 页面背景颜色
    _lmzxSDK.lmzxPageBackgroundColor = RGB(245, 245, 245);

//    _lmzxSDK.channel = kChannelSDK; delegate中统一配置了

    
}
#pragma mark SDK结果回调
- (void)handleResult:(NSString *)functionType {
    
    __block typeof(self) weakSelf = self;
    
    _lmzxSDK.lmzxResultBlock = ^(NSInteger code, LMZXSDKFunction function, id obj, NSString * token){
        NSLog(@"SDK结果回调:%ld,%d,%@,%@",(long)code,function,obj,token);
        
        if (code == 0 &&token.length>0&functionType.length>0 ) {
            
            if (function == 0) { // 公积金 ===> 原生
                YJReportHoseFundDetailsVC *reportHoseFundVC = [[YJReportHoseFundDetailsVC alloc] init];
                reportHoseFundVC.sdkEnter = YES;
                reportHoseFundVC.sdktoken = token;
                YJNavigationController *navResultVC = [[YJNavigationController alloc]
                                                       initWithRootViewController:reportHoseFundVC];
                [weakSelf presentViewController:navResultVC
                                       animated:YES
                                     completion:nil];
                
            } else if (function == 5) {//社保  ===> 原生
                YJReportSocialSecurityDetailsVC *socialSecurityVC = [[YJReportSocialSecurityDetailsVC alloc] init];
                socialSecurityVC.sdktoken = token;
                socialSecurityVC.sdkEnter =YES;
                YJNavigationController *navResultVC = [[YJNavigationController alloc]
                                                       initWithRootViewController:socialSecurityVC];
                [weakSelf presentViewController:navResultVC
                                       animated:YES
                                     completion:nil];
            }else {
                ResultWebViewController  *resultVc = [[ResultWebViewController  alloc] init];
                resultVc.token = token;
                resultVc.biztype = functionType;
                resultVc.getResult = @"1";
                resultVc.url = result_web_url_;
                YJNavigationController *navResultVC = [[YJNavigationController alloc]
                                                       initWithRootViewController:resultVc];
                
                [weakSelf presentViewController:navResultVC
                                       animated:YES
                                     completion:nil];
            }
            
            
            
            
        } else {
            
            
            
            
        }
        
    };
}




#pragma mark SDK签名
- (void)sign:(NSString*)string {
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:@"sign"] params:@{@"param":string} success:^(id responseObj) {
        NSString * ss = responseObj[@"data"];
        if (ss.length) {
            [[LMZXSDK shared] sendReqWithSign:ss];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"--%@",error);
    }];
    
    // param=xxxx
    
    //    NSString *sign = [string stringByAppendingString:lm_APISECRET];
    //    NSMutableString *mString = [NSMutableString stringWithString:sign];
    //    NSString *newsign ;
    //    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    //    NSData *stringBytes = [mString dataUsingEncoding: NSUTF8StringEncoding];
    //
    //    if (CC_SHA1([stringBytes bytes], (unsigned int)[stringBytes length], digest)) {
    //        NSMutableString *digestString = [NSMutableString stringWithCapacity:
    //                                         CC_SHA1_DIGEST_LENGTH];
    //        for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
    //            unsigned char aChar = digest[i];
    //            [digestString appendFormat:@"%02X", aChar];
    //        }
    //        newsign =[digestString lowercaseString];
    //        
    //    }
    //    NSLog(@"%@",newsign);
    //     [[LMZXSDK shared] sendReqWithSign:newsign];
}




@end
