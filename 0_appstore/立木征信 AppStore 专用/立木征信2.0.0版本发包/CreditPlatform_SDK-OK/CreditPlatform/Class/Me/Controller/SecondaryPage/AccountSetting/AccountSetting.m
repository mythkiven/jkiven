//
//  LoseLoginOne.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/20.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountSetting.h"
#import "ChangePassword.h"
#import "ChangePhoneNum.h"
#import "YJArrowItem.h"
#import "ChangePassword.h"
#import "ChangePhoneNum.h"
#import "YJTabBarController.h"

#import "YJTabBar.h"
#import "YJButton.h"
#import "YJMeCell.h"
#import "YJCompanyDetailManager.h"
#import "YJChildAccountManagerVC.h"
#import "YJAboutVC.h"

#import "YJCompanyDetailViewController.h"
#import "YJAuthorizationViewController.h"

@interface AccountSetting ()
{
    UIButton *_logoutBtn;
}

@end

@implementation AccountSetting

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号设置";
    self.view.backgroundColor = RGB_pageBackground;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:YJNotificationUserLogin object:nil];
    
    [self setupUI];
}

- (void)setupUI {
    [self creatgroup0];
    [self creatgroup1];
    [self setupLogoutBtn];
}

- (void)login {
    self.tableView.tableFooterView = nil;
    [self.dataSource removeAllObjects];
    
    [self setupUI];
    [self.tableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
    
}

//#pragma mark -
//#pragma mark - 公司认证模块逻辑
//- (void)gotoCompany {
//    CompanyDetailModel *compayInfo = [YJCompanyDetailManager companyInfo];
//    if (!compayInfo) {
//        __weak typeof(self) weakSelf = self;
//        NSDictionary *dict = @{@"method" : urlJK_queryMember,
//                               @"mobile" : kUserManagerTool.mobile,
//                               @"userPwd" : kUserManagerTool.userPwd
//                               };
//        [YJShortLoadingView yj_makeToastActivityInView:self.view];
//        [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryMember] params:dict success:^(id responseObj) {
//            
//            //"status": "00" // 00-待审核 20-审核成功 99-审核失败
//            MYLog(@"企业认证成功---%@",responseObj[@"data"]);
//            if (![responseObj[@"data"] isKindOfClass:[NSNull class]]) {
//                
//                CompanyDetailModel *companyDetailModel = [CompanyDetailModel mj_objectWithKeyValues:responseObj[@"data"]];
//                [YJCompanyDetailManager saveCompanyInfo:companyDetailModel];
//                dispatch_async(dispatch_get_main_queue(), ^{
////                    _topView.status = [[YJCompanyDetailManager companyInfo] status];
//                    [weakSelf showCompayDetailVc];
//                    [YJShortLoadingView yj_hideToastActivityInView:self.view];
//                    
//                });
//                
//                YJUserModel *user = [YJUserManagerTool user];
//                user.authStatus = companyDetailModel.status;
//                [YJUserManagerTool saveUser:user];
//                
//            } else {
//                //                        [self showCompayDetailVc];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [YJShortLoadingView yj_hideToastActivityInView:self.view];
//                    
//                    YJAuthorizationViewController * ss = [[YJAuthorizationViewController alloc]init];
//                    [self.navigationController pushViewController:ss animated:YES];
//                });
//                
//            }
//        } failure:^(NSError *error) {
//            
//            MYLog(@"企业认证失败---%@",error);
//            [YJShortLoadingView yj_hideToastActivityInView:self.view];
//            
//        }];
//    } else {
//        [self showCompayDetailVc];
//    }
//}

//- (void)showCompayDetailVc {
//    
//    CompanyDetailModel *compayInfo = [YJCompanyDetailManager companyInfo];
//    
//    if ([compayInfo.status isEqualToString:@"00"] || [compayInfo.status isEqualToString:@"20"]){// 认证中、认证成功
//        
//        YJCompanyDetailViewController *cc = [[YJCompanyDetailViewController alloc] init];
//        [self.navigationController pushViewController:cc animated:YES];
//        
//    } else { // 未认证  或  审核未通过
//        YJAuthorizationViewController * ss = [[YJAuthorizationViewController alloc]init];
//        [self.navigationController pushViewController:ss animated:YES];
//    }
//}

#pragma mark -
#pragma mark - tableview模块
- (void)creatgroup0 {
    YJUserModel *user = kUserManagerTool;
    NSString *str;
    if (user.mobile.length) {
        str =  [user.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    } else {
       str =  @"尚未设置手机号";
    }
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:@"手机号" subTitle:str destVc:[ChangePhoneNum class]];
    YJArrowItem *item1 = [YJArrowItem itemWithTitle:@"重置密码" subTitle:nil destVc:[ChangePassword class]];
    YJItemGroup *group = [[YJItemGroup alloc] init];
    group.groups = @[item0,item1];
    
    [self.dataSource addObject:group];
}

- (void)creatgroup1 {
    __block typeof(self) sself = self;
//     YJArrowItem *item0 = [YJArrowItem itemWithIcon:@"" Title:@"资质认证" destVc:nil];
//    item0.option = ^(NSIndexPath *indexPath) {
//        [sself gotoCompany];
//    };
    
    
    
    
    YJArrowItem *item2 = [YJArrowItem itemWithTitle:@"关于" subTitle:nil destVc:[YJAboutVC class]];
    
    YJItemGroup *group = [[YJItemGroup alloc] init];
    
    if ([kUserManagerTool.masterStatus intValue] == 3) {
        YJArrowItem *item1 = [YJArrowItem itemWithTitle:@"子帐号管理" subTitle:nil destVc:[YJChildAccountManagerVC class]];
        group.groups = @[/**item0,*/item1,item2];
        
    } else {
        
        group.groups = @[/**item0,*/item2];

    }
    
    [self.dataSource addObject:group];
    
}
#pragma mark  cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJMeCell *cell = [YJMeCell meCell:tableView];
    cell.accessoryArrowBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [cell.accessoryArrowBtn setTitleColor:RGB_grayNormalText forState:(UIControlStateDisabled)];
    
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


#pragma mark -
#pragma mark - 退出登录模块
- (UIButton *)setupLogoutBtn {
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = RGB_pageBackground;
//    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45+20);
    CGFloat bgViewH = 85;
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, bgViewH);
    if (_logoutBtn == nil) {
        UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutBtn = logoutBtn;
        [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [logoutBtn setBackgroundColor:[UIColor whiteColor]];
        [logoutBtn setTitleColor:RGB_navBar forState:UIControlStateNormal];
        [logoutBtn setTitleColor:RGB_navBar forState:UIControlStateHighlighted];
        
        [logoutBtn addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        logoutBtn.userInteractionEnabled = YES;
        logoutBtn.enabled = YES;
        logoutBtn.layer.borderWidth = 0.5;
        logoutBtn.layer.borderColor = RGB_grayLine.CGColor;
        logoutBtn.layer.cornerRadius = 2;
        logoutBtn.layer.masksToBounds = YES;
        
        logoutBtn.frame = CGRectMake(15, 20, SCREEN_WIDTH-30, 45);
    }

    [bgView addSubview:_logoutBtn];
    self.tableView.tableFooterView = bgView;
    return _logoutBtn;
}

- (void)logoutBtnClick:(UIButton*)send {

    // 删除cookie
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    //删除cookie
    for (NSHTTPCookie *tempCookie in cookies) {
        [cookieStorage deleteCookie:tempCookie];
    }
    [Tool removeObjectForKey: cookie_session_login_lmzx];
    
    
    
    //  退出登录
    NSDictionary *dicParams =@{@"method" : urlJK_loginOut};
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_loginOut] params:dicParams success:^(id responseObj) {
        // 退出登录
    } failure:^(NSError *error) {
        // 退出登录
    }];
    
    
    //移除用户所有信息
    if ([YJUserManagerTool clearUserInfo]) {
        [self.view makeToast:@"已退出登录"];
    }

    [self performSelector:@selector(outself) withObject:nil afterDelay:0.6];
    
}


-(void)outself{
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
    LoginVC *ll = [[LoginVC alloc]init];
    YJNavigationController *nav = [[YJNavigationController alloc] initWithRootViewController:ll];
    [self presentViewController:nav animated:YES completion:nil];
    

    
}


@end
