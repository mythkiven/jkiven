//
//  YJPodfileViewController.m
//  CreditPlatform
//
//  Created by yj on 16/7/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJPodfileViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AssertMacros.h>
#import <ImageIO/ImageIO.h>

//#import "YJResetPasswordViewController.h"
#import "AccountSetting.h"

#import "YJHTTPTool.h"
#import "LoginVC.h"
#import "SettingTopView.h"
#import "ImagePickerVC.h"
#import "YJCycleModel.h"
#import "SettingCell.h"
#import "CompanyDetailModel.h"
#import "YJShortLoadingView.h"
#import "YJIdeaVC.h"
#import "YJMeCell.h"

#import "ComboHistoryVC.h"
#import "JKeychainHelper.h"

#import "RechargeHistoryVC.h"
#import "YJCompanyDetailManager.h"
#import "YJPurchaseHistoryVC.h"
#import "YJFreeUseView.h"
#import "YJWalletView.h"
#import "YJBalanceVC.h"
#import "YJRedPacketVc.h"
#import "YJoverdraftView.h"
#import "YJChildAccountManagerVC.h"
#import "YJAuthorizationViewController.h"
#import "YJAuthTipModalView.h"
#import "YJCompanyDetailViewController.h"
#import "YJAboutVC.h"
#define ImageMaxSize 1024*(1024-24)
@interface YJPodfileViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource>

{
    NSString *_icon;
    NSMutableArray *_containerArray;
//    YJLoginHeaderView *_loginHeaderView;
//    YJAccountHeaderView *_headerView;
    SettingTopView *_topView;
    UIView *_headerBgView;
    UIView *_autoMarginViewsContainer;
    NSData *imgdata_;
    NSString *type_;
    CGFloat _topViewH;
    __block BOOL _isGetData;
    
    UITableView *_tableView;
    
    YJWalletView * _walletView;
    MJRefreshGifHeader *_refreshGifHeader;

    YJoverdraftView *_overdraftView;
    
}
@property (strong, nonatomic) UIScrollView *scrollView;

@property (nonatomic, strong) CompanyDetailModel *companyDetailModel;
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  试用期-剩余天数
 */
@property (copy, nonatomic) NSString *surplus;
/**
 *  试用期-截止日期
 */
@property (copy, nonatomic) NSString *endDate;

/**
 *  金额-余额
 */
@property (copy, nonatomic) NSString *balance;
/**
 *  金额-红包
 */
@property (copy, nonatomic) NSString *redPacket;

@property (nonatomic, strong) YJAuthTipModalView *authTipModalView;

@end

@implementation YJPodfileViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
    
}

- (YJAuthTipModalView *)authTipModalView {
    if (_authTipModalView == nil) {
        _authTipModalView = [[YJAuthTipModalView alloc] init];
    }
    return _authTipModalView;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - --生命周期函数
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.title = @"";
//    self.navigationItem.title = @"";
   self.view.backgroundColor = RGB_pageBackground;
    
    self.balance = @"0.00";
    self.redPacket = @"0.00";
    // 头部--登录
    [self creatHeaderView];
    
    // 初始化tableview
    [self setupTableView];
    
    // 设置tableview的头部样式
    [self refreshUI];

    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI) name:YJNotificationUserLogout object:nil];
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor cyanColor] colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];

    // 刷新企业认证的信息
    [self getCompanyAuthStatus];

    // 充值账户信息
    [self getRechargeInfo];
    
    YJUserModel *user = kUserManagerTool;
    
    if (user.isLogin) {
        _topView.icon = user.iconImage;
        _topView.status = [[YJCompanyDetailManager companyInfo] status];
        _topView.phone = user.mobile;
    }else{
        _topView.icon = [UIImage imageNamed:@"me_head_icon"];
        _topView.status = @"";
        _topView.phone = @"";
        _tableView.tableHeaderView = [self walletView];
        
        
//        _walletView.balance = @"0.00元";
//        _walletView.redPackets = @"0.00元";
    }
    
    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage =[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]];
    
    if ([kUserManagerTool isLogin]) {
        
    } else {
        LoginVC *ll = [[LoginVC alloc]init];
        JENavigationController *nav = [[JENavigationController alloc] initWithRootViewController:ll];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [YJShortLoadingView yj_hideToastActivityInView:self.view];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - 创建View
#pragma mark  退出登录刷新UI
-(void)refreshUI {
    
    self.balance = @"0.00";
    self.redPacket = @"0.00";
    [self setupOverdraftView];
    
}

#pragma mark  创建View头部控件
- (void)creatHeaderView {
    
    __weak typeof(self) weakSelf = self;
    _topView = [SettingTopView loginHeaderView];
    _topViewH = 264;
    if (iPhone4s) {
        _topViewH = 200;
    }if (iPhone5) {
        _topViewH = 220;
    }
    _topView.frame = CGRectMake(0, -64, SCREEN_WIDTH, _topViewH);
    _topView.changeImgBlock = ^(UIButton *btn) {
        YJUserModel *user = kUserManagerTool;
        if (!user.isLogin) {//没有登录
            LoginVC *ll = [[LoginVC alloc]init];
            //            ll.isFrom = 103;
            JENavigationController *nav = [[JENavigationController alloc] initWithRootViewController:ll];
            [weakSelf presentViewController:nav animated:YES completion:nil];
            
        }else{//已经登录，设置头像
            [weakSelf alertSheet];
        }
    };
    
    [self.view addSubview:_topView];
    
}
#pragma mark  创建是否透支View
- (void)setupOverdraftView {
    __weak typeof(self) weakSelf = self;
    
    // 判断是否透支
    BOOL isOverdraft = [self.balance hasPrefix:@"-"];
    
    if (isOverdraft) { // 透支
        // 创建充值
        if (!_overdraftView) {
            _overdraftView = [[YJoverdraftView alloc] init];
            _overdraftView.rechargeBlock = ^() {
                [weakSelf rechargeBtnClcik];
            };
            CGFloat overdraftViewH = 50;
            _overdraftView.frame = CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREEN_WIDTH, overdraftViewH);
            [self.view insertSubview:_overdraftView belowSubview:_topView];
            
            _overdraftView.transform = CGAffineTransformTranslate(_overdraftView.transform, 0, -overdraftViewH);
            
            [UIView animateWithDuration:0.4 animations:^{
                _tableView.transform = CGAffineTransformTranslate(_tableView.transform, 0,overdraftViewH);
                
            } completion:^(BOOL finished) {
                _tableView.frame = CGRectMake(0, CGRectGetMaxY(_overdraftView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-_topView.height-overdraftViewH-44);
                
            }];
            
            [UIView animateWithDuration:.8 animations:^{
                _overdraftView.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                
            }];
            
        }
    } else {
        
        if (_overdraftView) {
            
            [UIView animateWithDuration:1 animations:^{
                _overdraftView.transform = CGAffineTransformTranslate(_overdraftView.transform, 0, -50);
                
                _tableView.transform = CGAffineTransformTranslate(_tableView.transform, 0, -50);
                
            } completion:^(BOOL finished) {
                _tableView.frame = CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-_topView.height-44);
                
                [_overdraftView removeFromSuperview];
                _overdraftView = nil;
            }];
            
        }
    }
}


#pragma mark - 获取企业认证状态刷新
- (void)getCompanyAuthStatus {
    //
    if (!kUserManagerTool.isLogin) {
        return;
    }
    
    [self getCompanyInfoFromNet];
    
}
#pragma mark 获取认证状态 存储用户信息
- (void)getCompanyInfoFromNet {
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        // 提交企业认证后，企业详情接口
//        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_queryMember,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd
                               };
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryMember] params:dict success:^(id responseObj) {
            
            //"status": "00" // 00-待审核 20-审核成功 99-审核失败
            MYLog(@"企业认证成功---%@",responseObj[@"data"]);
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
        
#warning - 认证所需
                
#if (TARGET_IPHONE_SIMULATOR) //模拟器
#else
                if ([responseObj[@"data"][@"status"] isEqualToString:@"20"]) {
                    NSString *key = [kUserManagerTool.mobile stringByAppendingString:@"TalkingDataQYRZ"];
                    if ([[JKeychainHelper load:key] isEqualToString:@"00"]) {
                    }else{
                        [JKeychainHelper save:key data:@"00"];
                        #ifdef DEBUG
                            [TalkingData trackEvent:@"认证成功"  label:TalkingDataLabel parameters:@{@"V1":[[UIDevice currentDevice] systemVersion],@"V2":[[UIDevice currentDevice] name],@"V3":[[UIDevice currentDevice] systemName],@"V4":[[UIDevice currentDevice] model]}];
                        #else//生产环境
                            [TalkingData trackEvent:@"认证成功"  label:TalkingDataLabel];
                        #endif
                    }
                }
#endif
                
                CompanyDetailModel *companyDetailModel = [CompanyDetailModel mj_objectWithKeyValues:responseObj[@"data"]];
                
                [YJCompanyDetailManager saveCompanyInfo:companyDetailModel];
                dispatch_async(dispatch_get_main_queue(), ^{
                    _topView.status = [[YJCompanyDetailManager companyInfo] status];
                });
                
                YJUserModel *user = [YJUserManagerTool user];
                user.authStatus = companyDetailModel.status;
                user.companyName = companyDetailModel.companyName;
                [YJUserManagerTool saveUser:user];
                
            }
        } failure:^(NSError *error) {
            
            MYLog(@"企业认证失败---%@",error);
            
        }];
    }
    
}
#pragma mark -
#pragma mark - 试用期、充值、红包 模块
#pragma mark -
#pragma mark 获取试用期信息
- (void)getFreeUseInfoFromNet {
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        
        // 提交企业认证后，企业详情接口
        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_queryFreeRule,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd,
                               @"appVersion" : ConnectPortVersion_1_0_0
                               };
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryFreeRule] params:dict success:^(id responseObj) {
            
            MYLog(@"是否试用---%@",responseObj);
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                
                weakSelf.surplus = responseObj[@"data"][@"surplus"];
                weakSelf.endDate = responseObj[@"data"][@"endDate"];
                
                if ([weakSelf.surplus intValue] > 0) { // 使用期
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _tableView.tableHeaderView = [self freeUseView];
                    });
                }
                
                
            }
        } failure:^(NSError *error) {
            MYLog(@"是否试用失败---%@",error);
            
        }];
    }
}
#pragma mark 充值账户信息
- (void)getRechargeInfo {
    if (kUserManagerTool.mobile && kUserManagerTool.userPwd) {
        
        // 提交企业认证后，企业详情接口
        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_rechargeInfo,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd,
                               @"appVersion" : ConnectPortVersion_1_0_0
                               };
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_rechargeInfo] params:dict success:^(id responseObj) {
            
            MYLog(@"充值账户信息---%@",responseObj[@"data"]);
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.balance = responseObj[@"data"][@"balance"];
                    weakSelf.redPacket = responseObj[@"data"][@"redPacket"];

//                    _tableView.tableHeaderView = [self walletView];

                    
                    _walletView.balance = [NSString stringWithFormat:@"%.2f元",[weakSelf.balance floatValue]];
                    _walletView.redPackets = [NSString stringWithFormat:@"%.2f元",[weakSelf.redPacket floatValue]];
                    
                    [weakSelf setupOverdraftView];
                    [_tableView reloadData];
                    
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
#pragma mark  3. 4.余额处于 正常状态（透支overdraft）
- (UIView *)walletView {
    
    CGFloat walletViewY = 0;
    UIView *bg = [[UIView alloc] init];
    CGFloat walletViewH = 75;
    bg.backgroundColor = RGB_pageBackground;
    
    bg.frame = CGRectMake(0, 0, SCREEN_WIDTH,  walletViewH + 10);
    YJWalletView * walletView = [YJWalletView walletView];
    _walletView = walletView;
    walletView.frame = CGRectMake(0, walletViewY, SCREEN_WIDTH, walletViewH);
    
    walletView.balance = [NSString stringWithFormat:@"%.2f元",[self.balance floatValue]];
    walletView.redPackets = [NSString stringWithFormat:@"%.2f元",[self.redPacket floatValue]];
   
    [bg addSubview:walletView];
    
    __weak typeof(self)weakSelf = self;
    walletView.packetOption = ^(int index) {
        switch (index) {
            case 1: // 余额
                [weakSelf rechargeBtnClcik];
                break;
            case 2: // 红包
                [weakSelf redPacketBtnClcik];
                break;
            default:
                break;
        }
    };
    
    return bg;
}
#pragma mark 创建充值btn
- (UIButton *)rechargeButton {
    UIButton *rechargeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    rechargeBtn.frame =CGRectMake(kMargin_15, tipLBH+(headerH - tipLBH - rechargeBtnH)*.5, SCREEN_WIDTH - kMargin_15*2,rechargeBtnH);
    [rechargeBtn setTitle:@"充值" forState:(UIControlStateNormal)];
    rechargeBtn.titleLabel.font = Font18;
    rechargeBtn.layer.cornerRadius = 2;
    rechargeBtn.layer.masksToBounds = YES;
    [rechargeBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
    [rechargeBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    [rechargeBtn setTitleColor:RGB_white forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:RGB_white forState:UIControlStateHighlighted];
    [rechargeBtn addTarget:self action:@selector(rechargeBtnClcik) forControlEvents:(UIControlEventTouchUpInside)];
    
    return rechargeBtn;
}

#pragma mark  1.免费试用期
- (UIView *)freeUseView {
    
    CGFloat freeUseViewH = 75;
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = RGB_pageBackground;
    YJFreeUseView * freeUseView = [YJFreeUseView freeUseView];
    freeUseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, freeUseViewH);
    freeUseView.remainingDays = [NSString stringWithFormat:@"%@天",self.surplus];
    
    //    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [df dateFromString:self.endDate];
    df.dateFormat = @"yyyy年MM月dd日";
    MYLog(@"%@-111--%@",date,[df stringFromDate:date]);
    
    freeUseView.limitDate =[df stringFromDate:date];
    
    CGFloat rechargeBtnH = 45;
    UIButton *rechargeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rechargeBtn.frame =CGRectMake(kMargin_15, CGRectGetMaxY(freeUseView.frame)+10, SCREEN_WIDTH - kMargin_15*2,rechargeBtnH);
    [rechargeBtn setTitle:@"充值" forState:(UIControlStateNormal)];
    rechargeBtn.titleLabel.font = Font18;
    rechargeBtn.layer.cornerRadius = 2;
    rechargeBtn.layer.masksToBounds = YES;
    rechargeBtn.layer.borderColor = RGB_grayLine.CGColor;
    rechargeBtn.layer.borderWidth = .5;
    [rechargeBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_white] forState:(UIControlStateNormal)];
    [rechargeBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_white] forState:(UIControlStateHighlighted)];
    [rechargeBtn setTitleColor:RGB_navBar forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:RGB_navBar forState:UIControlStateHighlighted];
    [rechargeBtn addTarget:self action:@selector(rechargeBtnClcik) forControlEvents:(UIControlEventTouchUpInside)];
    [bg addSubview:rechargeBtn];
    
    bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(rechargeBtn.frame)+10);
    
    
    [bg addSubview:freeUseView];
    return bg;
}

#pragma mark 2.试用期结束，请充值
- (UIView *)freeUseWasOverPleaseRechargeView {
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = RGB_pageBackground;
    
    CGFloat tipLBH = 45;
    UILabel *tipLB = [[UILabel alloc] init];
    tipLB.text = @"您的免费试用期限已到，如需续用请充值。";
    tipLB.textAlignment = NSTextAlignmentCenter;
    tipLB.backgroundColor = RGB(255, 243, 184);
    tipLB.frame = CGRectMake(-5, 0.5, SCREEN_WIDTH+10, tipLBH);
    tipLB.font = Font13;
    tipLB.textColor = RGB(242,65,48);
    tipLB.layer.borderColor = RGB_grayLine.CGColor;
    tipLB.layer.borderWidth = 0.5;
    [bg addSubview:tipLB];
    
    CGFloat rechargeBtnH = 45;
    UIButton *rechargeBtn = [self rechargeButton];
    rechargeBtn.frame =CGRectMake(kMargin_15, CGRectGetMaxY(tipLB.frame)+10, SCREEN_WIDTH - kMargin_15*2,rechargeBtnH);
    
    bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(rechargeBtn.frame)+10);
    [bg addSubview:rechargeBtn];
    return bg;
    
}

#pragma mark -- 充值跳转
- (void)rechargeBtnClcik {
    
    if (![self checkUserIsLogin]) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    if ([kUserManagerTool.authStatus intValue] != 20){
        [self.authTipModalView showInRect:self.view.frame];
        
        self.authTipModalView.authBlock = ^(){
            YJAuthorizationViewController  *VC = [[YJAuthorizationViewController alloc] init];
            
            [weakSelf.navigationController pushViewController:VC animated:YES];
        };
        
        return;
        
    }
    
    
    YJBalanceVC *vc = [[YJBalanceVC alloc] init];
    vc.balance = self.balance;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -- 红包跳转
- (void)redPacketBtnClcik {
    if (![self checkUserIsLogin]) {
        return;
    }
    YJRedPacketVc *vc = [[YJRedPacketVc alloc] init];
    vc.redPacket = @"500000000.00";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 监测用户是否登录
- (BOOL)checkUserIsLogin {
    
    YJUserModel *user = kUserManagerTool;
    if (!user.isLogin) {//没有登录
        LoginVC *ll = [[LoginVC alloc]init];
        //        ll.isFrom = 103;
        JENavigationController *nav = [[JENavigationController alloc] initWithRootViewController:ll];
        [self presentViewController:nav animated:YES completion:nil];
        return NO;
    }
    
    return YES;
}





#pragma mark -
#pragma mark - tableview模块
#pragma mark -
#pragma mark 初始化TableView
- (void)setupTableView {
    CGFloat tableViewY = CGRectGetMaxY(_topView.frame);
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableViewY, SCREEN_WIDTH, SCREEN_HEIGHT-_topView.height-44) style:(UITableViewStyleGrouped)];
    //_tableView.frame = CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-_topView.height-44);
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.contentInset = UIEdgeInsetsMake(0, 0, 5, 0);
    _tableView.rowHeight = 45;
    _tableView.sectionHeaderHeight = 10;
    _tableView.sectionFooterHeight = 0;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.view.backgroundColor = RGB_pageBackground;
    _tableView.backgroundColor = RGB_pageBackground;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.tableHeaderView = [self walletView];
    [self creatgroup0];
    [self creatgroup1];
    //[_tableView reloadData];
}
#pragma mark 设置TableView的头部样式（4种样式）
- (void)setupTableViewHeader {
    // 根据钱包状态 调整头部样式
    //    _tableView.tableHeaderView = [self freeUseView];
    //    _tableView.tableHeaderView = [self freeUseWasOverPleaseRechargeView];
    
    _tableView.tableHeaderView = [self walletView];
    
    [_tableView reloadData];
    
}
#pragma mark 填充cell数据源
- (void)creatgroup0 {
    __block typeof(self) sself =self;
    YJArrowItem *item0 = [YJArrowItem itemWithIcon:@"me_icon_purchaseHistory" Title:@"消费记录" destVc:[YJPurchaseHistoryVC class]];
    
//    YJArrowItem *item1 = [YJArrowItem itemWithIcon:@"me_icon_ComboHistory" Title:@"套餐消费" destVc:[ComboHistoryVC class]];
    
    YJArrowItem *item2 = [YJArrowItem itemWithIcon:@"me_icon_rechargeHistory" Title:@"充值记录" destVc:[RechargeHistoryVC class]];
    
 
    
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item0,item2];
    
    [self.dataSource addObject:group];
    
}
- (void)creatgroup1 {
    __weak typeof(self) weakSelf = self;
    // 公司认证新增:
    YJArrowItem *item1 = [YJArrowItem itemWithIcon:@"me_icon_zizhirenzhen" Title:@"资质认证" destVc:nil];
    item1.option = ^(NSIndexPath *indexPath) {
        [weakSelf gotoCompany];
    };
    
    YJArrowItem *item2 = [YJArrowItem itemWithIcon:@"me_icon_setting" Title:@"设置" destVc:[AccountSetting class]];
    
    YJArrowItem *item3 = [YJArrowItem itemWithIcon:@"me_icon_about" Title:@"关于" destVc:[YJAboutVC class]];
    
    YJArrowItem *item4 = [YJArrowItem itemWithIcon:@"me_icon_ideas" Title:@"意见反馈" destVc:[YJIdeaVC class]];
    
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    group.groups = @[item1,item2,item3,item4];
    
    [self.dataSource addObject:group];
    
} // 13631557027

#pragma mark -
#pragma mark - 公司认证模块逻辑
- (void)gotoCompany {
    CompanyDetailModel *compayInfo = [YJCompanyDetailManager companyInfo];
    if (!compayInfo) {
        __weak typeof(self) weakSelf = self;
        NSDictionary *dict = @{@"method" : urlJK_queryMember,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd" : kUserManagerTool.userPwd
                               };
        [YJShortLoadingView yj_makeToastActivityInView:self.view];
        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryMember] params:dict success:^(id responseObj) {
            
            //"status": "00" // 00-待审核 20-审核成功 99-审核失败
            MYLog(@"企业认证成功---%@",responseObj[@"data"]);
            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
                
                CompanyDetailModel *companyDetailModel = [CompanyDetailModel mj_objectWithKeyValues:responseObj[@"data"]];
                [YJCompanyDetailManager saveCompanyInfo:companyDetailModel];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                    _topView.status = [[YJCompanyDetailManager companyInfo] status];
                    [weakSelf showCompayDetailVc];
                    [YJShortLoadingView yj_hideToastActivityInView:self.view];
                    
                });
                
                YJUserModel *user = [YJUserManagerTool user];
                user.authStatus = companyDetailModel.status;
                user.companyName = companyDetailModel.companyName;
                [YJUserManagerTool saveUser:user];
                
            } else {
                //                        [self showCompayDetailVc];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [YJShortLoadingView yj_hideToastActivityInView:self.view];
                    YJUserModel *user = [YJUserManagerTool user];
                    user.authStatus = @"0";
                    [YJUserManagerTool saveUser:user];
                    
                    YJAuthorizationViewController * ss = [[YJAuthorizationViewController alloc]init];
                    [self.navigationController pushViewController:ss animated:YES];
                });
                
            }
        } failure:^(NSError *error) {
            
            MYLog(@"企业认证失败---%@",error);
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
            
        }];
    } else {
        [self showCompayDetailVc];
    }
}
- (void)showCompayDetailVc {
    
    CompanyDetailModel *compayInfo = [YJCompanyDetailManager companyInfo];
    
    if ([compayInfo.status isEqualToString:@"00"] || [compayInfo.status isEqualToString:@"20"]){// 认证中、认证成功
        
        YJCompanyDetailViewController *cc = [[YJCompanyDetailViewController alloc] init];
        [self.navigationController pushViewController:cc animated:YES];
        
    } else { // 未认证  或  审核未通过
        YJAuthorizationViewController * ss = [[YJAuthorizationViewController alloc]init];
        [self.navigationController pushViewController:ss animated:YES];
    }
}



#pragma mark --UITableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YJItemGroup *group = self.dataSource[section];
    
    return group.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJMeCell *cell = [YJMeCell meCell:tableView];
    YJItemGroup *group = self.dataSource[indexPath.section];
    YJBaseItem *item = group.groups[indexPath.row];
    cell.item = item;
    
    if (group.groups.count-1 == indexPath.row) {
        UIView *separateLine1 = [[UIView alloc] init];
        separateLine1.frame = CGRectMake(0, 45.0-0.5, SCREEN_WIDTH, 0.5);
        separateLine1.backgroundColor = RGB_grayLine;
        
        [cell.contentView addSubview:separateLine1];
        
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (![self checkUserIsLogin]) {
        return;
    }
    
    YJMeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.item isKindOfClass:[YJArrowItem class]]) {
        YJArrowItem *item = (YJArrowItem *)cell.item;
        if (item.destVC) {
            
            
            UIViewController *vc =[[item.destVC alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
    if (cell.item.option) {
        cell.item.option(indexPath);
    }
    
}




#pragma mark -
#pragma mark - 头像处理模块
#pragma mark -
#pragma mark 设置头像
- (void)alertSheet {
    __weak typeof(self) weakSelf = self;
    //    if ( iOS8) {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf openAlbum];
        
    }];
    
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf openCamera];
        
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [sheet addAction:cameraAction];
    [sheet addAction:albumAction];
    [sheet addAction:cancleAction];
    
    
    [self presentViewController:sheet animated:YES completion:^{
        
    }];
    
}
#pragma mark 打开相机
- (void)openCamera {
    
    if([UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        MYLog(@"支持相机");
    }else{
        [self.view makeToast:@"不支持相机，请修改设置，允许访问相机"];
        return;
    }
    if(iOS11){
        [WTAuthorizationTool requestCameraAuthorization:^(WTAuthorizationStatus status) {
            if(status == WTAuthorizationStatusAuthorized){

                ImagePickerVC * imagePicker = [[ImagePickerVC alloc]init];
                //    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.allowsEditing = YES;
                //    imagePicker.allowsImageEditing=YES;

                [self presentViewController:imagePicker animated:YES completion:nil];
            }else if (status == WTAuthorizationStatusDenied){
//                [self.view makeToast:@"请在系统设置中设置允许访问相机"];
                [self goSettingWithMessage:@"相机"];

                return ;
            }else{
                [self.view makeToast:@"无法访问相机"];
                return ;
            }
        }];
    }
    
}
#pragma mark 打开相册
- (void)openAlbum {
    if([UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        MYLog(@"支持相册");
    }else{
        [self.view makeToast:@"系统不允许查看相册，请修改设置，允许访问相册"];
        return;
    }
    if(iOS11){
        [WTAuthorizationTool requestImagePickerAuthorization:^(WTAuthorizationStatus status) {
            if(status == WTAuthorizationStatusAuthorized){
                ImagePickerVC * imagePicker = [[ImagePickerVC alloc]init];
                //    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.allowsEditing = YES;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }else if (status == WTAuthorizationStatusDenied){
//                [self.view makeToast:@"请在系统设置中设置允许访问相册"];
                [self goSettingWithMessage:@"相册"];
                
                return ;
            }else{
                [self.view makeToast:@"无法访问相册"];
                
                return ;
            }
        }];
    }
    
    
 
}

- (void)goSettingWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"系统拒绝访问%@，请修改设置",message] preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"去设置" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}




#pragma mark  UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    __block typeof(self) weakSelf = self;
    //获取图片信息
    __block NSString *imageType;
    __block long H = 0;
    __block long W = 0;
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
    

        NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library assetForURL:assetURL
                 resultBlock:^(ALAsset *asset) {
                     
                     //图片size
                     NSDictionary* imageMetadata = [[NSMutableDictionary alloc] initWithDictionary:asset.defaultRepresentation.metadata];
                     
                     H = [[imageMetadata objectForKey:@"PixelHeight"] longValue];
                     W = [[imageMetadata objectForKey:@"PixelWidth"] longValue];
                     
                     //图片类型：
                     NSString *extension = [assetURL pathExtension];
                     CFStringRef imageUTI = (UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,(__bridge CFStringRef)extension , NULL));
                     if (UTTypeConformsTo(imageUTI, kUTTypeJPEG))
                         imageType = @"JPG";
                     else if (UTTypeConformsTo(imageUTI, kUTTypePNG))
                         imageType = @"PNG";
                     else
                         imageType = (__bridge NSString*)imageUTI;
                     
                     if (imageUTI) {
                         CFRelease(imageUTI);
                     }
                     
                 }
                failureBlock:^(NSError *error) {
                    
                }];
        
    } else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        
        H = image.size.height;
        W = image.size.width;
        imageType = @"JPG";
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imageData = [UIImage compressImageWidth:W height:H type:imageType img:image];
        
        [weakSelf changeIcon:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [YJShortLoadingView yj_makeToastActivityInView:self.view];
        });
        
    });
    
    

    _topView.icon =  [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    _icon = info[UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
}

#pragma mark 网络 设置头像
- (void)changeIcon:(NSData *)imageData {
    
    NSString *imgdataStr = [imageData base64EncodedStringWithOptions:0];
    NSDictionary *dicParams =@{@"method" : urlJK_changePicture,
                               @"appVersion" : ConnectPortVersion_1_0_0,
                               @"mobile" :kUserManagerTool.mobile,
                               @"userPwd":kUserManagerTool.userPwd,
                               @"picture":imgdataStr};

    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_changePicture] params:dicParams success:^(id responseObj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([responseObj[@"code"] isEqualToString:@"0000"]) {
                //用户信息本地化
                YJUserModel *user = kUserManagerTool;
                user.picture = imgdataStr;
                [YJUserManagerTool saveUser:user];
                
                _topView.icon = user.iconImage;
                
            }else{//无数据
                [self.view makeToast:[NSString stringWithFormat:@"%@",[responseObj objectForKey:@"msg"]]];
            }
            //错误原因
            if ([responseObj[@"code"] intValue] !=0000) {
                [self.view makeToast: responseObj[@"msg"]  ];
            }
            
        });

    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view makeToast:errorInfo];
    }];
    
}

#pragma mark -
#pragma mark - 其他
#pragma mark   UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            [self openAlbum];
            
            break;
        case 1:
            [self openCamera];
            
            break;
        default:
            break;
    }
    
}



@end
