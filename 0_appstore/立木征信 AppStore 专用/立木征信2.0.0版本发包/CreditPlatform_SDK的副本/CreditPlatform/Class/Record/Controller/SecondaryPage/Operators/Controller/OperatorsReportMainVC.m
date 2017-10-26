//
//  OperatorsReportMainVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
//#import "YJReportHoseFundViewController.h"
#import "OperatorsReportMainTopCell.h"
#import "YJHouseFundLoanInfoVC.h"
#import "YJHousfundPayDetailsVC.h"
#import "OperatorsReportMainVC.h"

#import "OperatorsDataTool.h"
#import "YJMeCell.h"
#import "YJTextItem.h"
#import "CommonSendMsgVC.h"
#import "OperatorsReportSecondPageVC.h"

#import "OperationModel.h"

#import "JLoadingReportBaseVC.h"

#import "OperationNewModel.h"



@interface OperatorsReportMainVC ()

{
//    OperatorsDataTool *_operatorsDataTool;
    OperationMainModel *_operationMainModel;
    // 新的数据
    OperationNewModel *_operationNewModel;
    BOOL _NOData;
    BOOL _setting;
}

@property (strong,nonatomic) NSString      *yzm;
//本页model
@property (nonatomic, strong) OperationModel *operationModel;
//分组
@property(strong,nonatomic) NSMutableArray *groupDataArray;
//标题
@property(strong,nonatomic) NSMutableArray *titleDataArray;

//分组
@property(strong,nonatomic) NSMutableArray *DATA;

@end

@implementation OperatorsReportMainVC
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运营商报告";
    _NOData = YES;
    
    
    if (self.obj) {
        NSDictionary *dicc = (NSDictionary *)self.obj;
        _DATA = [NSMutableArray arrayWithCapacity:0];
        
        
        NSArray *arr = dicc[@"list"];
        if(arr && [arr isKindOfClass:[NSArray class]]){
            // 创建新数据 运营商报告改变了
            if (arr.count) {
                [self creatNewData:arr[0]];
            }
        }
        
        if (dicc[@"data"][@"data"]) {
            NSDictionary *dic = dicc[@"data"][@"data"];
            [self creatGroupDataArray:dic];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tableView.hidden = NO;
                [self creatUI];
            });
        } else {
            [self.view makeToast:@"暂无数据"];
            [self jOutSelf];
        }
        
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    switch (self.searchConditionModel.type) {
        case YJGoToSearchResultTypeFromHome://首页
            self.view.backgroundColor = RGB_navBar;
            self.tableView.backgroundColor =RGB_navBar;
            break;
        case YJGoToSearchResultTypeFromRecord://报告页面
            
            [self checkDetailReport];
            break;
            
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pop:) name:@"zhuanyongde#test" object:nil];
    
}

-(void)pop:(NSNotification*)noti{
    JLoadingReportBaseVC *vc = [self.childViewControllers lastObject];
    id obj = noti.object;
    if (obj) {
        self.obj = obj;
    }
    
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    
    if (self.obj) {
        
        self.view.backgroundColor =RGB_pageBackground;
        self.tableView.backgroundColor =RGB_pageBackground;
        self.tableView.frame =CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        NSDictionary *dicc = (NSDictionary *)self.obj;
        _DATA = [NSMutableArray arrayWithCapacity:0];
        
        NSArray *arr = dicc[@"list"];
        if(arr && [arr isKindOfClass:[NSArray class]]){
            // 创建新数据 运营商报告改变了
            if (arr.count) {
                [self creatNewData:arr[0]];
            }
        }
        
        if (dicc[@"data"][@"data"]) {
            NSDictionary *dic = dicc[@"data"][@"data"];
            [self creatGroupDataArray:dic];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tableView.hidden = NO;
                [self creatUI];
            });
        } else {
            [self.view makeToast:@"暂无数据"];
            [self jOutSelf];
        }
        
    }
    self.tableView.scrollEnabled =YES;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 子VC
    JLoadingReportBaseVC *vc = [self.childViewControllers lastObject];
    if (vc) {
        [self.view addSubview:vc.view];
        [vc didMoveToParentViewController:self];
        vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _setting =YES;
        self.tableView.scrollEnabled =NO;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        self.title = @"运营商查询";
        
    }else{
        self.title = @"运营商报告";
//        self.edgesForExtendedLayout = UIRectEdgeAll;
//        self.navigationController.navigationBar.translucent = NO;
//        UINavigationBar *appearance = [UINavigationBar appearance];
//        [appearance setBarTintColor:RGB_navBar];
//        [appearance setBackgroundImage:[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
//        appearance.shadowImage =[UIImage imageWithColor:[RGB_white colorWithAlphaComponent:0]];   
//        self.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
//        self.view.backgroundColor =RGB_navBar;
//        self.tableView.backgroundColor =RGB_pageBackground;
//        self.tableView.frame =CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    }
    
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_yzm.length) {
        _yzm = nil;
    }
    
//    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
//    
//    MYLog(@"%@",navigationArray);
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    JLoadingReportBaseVC *vc = [self.childViewControllers lastObject];
    if (_setting&&!vc) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.navigationController.navigationBar.translucent = NO;
        
        UINavigationBar *appearance = [UINavigationBar appearance];
        
        [appearance setBarTintColor:RGB_navBar];
        [appearance setBackgroundImage:[UIImage imageWithColor:[RGB_navBar colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
        appearance.shadowImage =[UIImage imageWithColor:[RGB_white colorWithAlphaComponent:0]];
        
        self.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        self.view.backgroundColor =RGB_navBar;
        self.tableView.backgroundColor =RGB_pageBackground;
        self.tableView.contentInset = UIEdgeInsetsMake(64+10, 0, 0, 0);
        _setting =NO;
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [YJCreditWaitingView yj_hideWaitingViewForView:self.view animated:YES];
//    [_operatorsDataTool removeTimer];
    
}
- (void)creatUI{
    [self setupHeaderView];
    [YJCreditWaitingView yj_hideWaitingViewForView:self.view animated:YES];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.tableView reloadData];
//    [self creatGroupDataArray];
}


#pragma mark - 网络 报告

-(void)checkDetailReport{
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    NSDictionary *dicParams =@{@"method" : urlJK_recordDetailProcess,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"reportId":self.searchConditionModel.ID,
                               @"appVersion": VERSION_APP_1_4_3};
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_recordDetailProcess] params:dicParams success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
        
        NSArray *arr = responseObj[@"list"];
        if(arr && [arr isKindOfClass:[NSArray class]]){
            // 创建新数据 运营商报告改变了
            if (arr.count) {
                [self creatNewData:arr[0]];
            }
        }
        
        if (responseObj[@"data"] && [responseObj[@"data"] isKindOfClass:[NSDictionary class]]) {
            [sself creatGroupDataArray:responseObj[@"data"][@"data"]];
            
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

#pragma mark - 创建model
-(void)creatNewData:(NSDictionary *)dic {
    _operationNewModel = [OperationNewModel mj_objectWithKeyValues:dic];
}
-(void)creatGroupDataArray:(NSDictionary *)dic {
    
    _operationMainModel = [OperationMainModel mj_objectWithKeyValues:dic];
    
    //1、基本信息
    _operationModel = [OperationModel mj_objectWithKeyValues:dic[@"basicInfo"]];
    
    if ([_operationModel isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if (_titleDataArray.count) {
        [_titleDataArray removeAllObjects];
    }else{
        _titleDataArray = [NSMutableArray arrayWithCapacity:0];
    }

        [_titleDataArray addObject:@"近6个月前10通话记录"];
        [_titleDataArray addObject:@"近6个月通话详单记录"];
    
        [_titleDataArray addObject:@"近6个月账单信息"];
        [_titleDataArray addObject:@"近6个月办理业务"];
//        [_titleDataArray addObject:@"近6个月上网数据"];
    
        [_titleDataArray addObject:@"近6个月短信记录"];
    
    for (int i=0 ; i<_titleDataArray.count; i++) {
        [self creatCellTitle:_titleDataArray[i] index:i];
       
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark - creatView
#pragma mark 头部
- (void)setupHeaderView {
    
    OperatorsReportMainTopCell *headerView = [OperatorsReportMainTopCell houseFundView];
    headerView.model = _operationModel;
    headerView.modelNew = _operationNewModel;
    //    _headerView = headerView;
    
    CGFloat headerH = 0;
    if (!_operationModel.address || [_operationModel.address isEqualToString:@""]) { // 空地址
        headerH = 416;
    } else {
        CGFloat maxWidth = SCREEN_WIDTH - 90 - 15 - 10;
       CGFloat h = [NSString calculateTextSize:CGSizeMake(maxWidth, MAXFLOAT) Content:_operationModel.address font:Font15].height;
        
        MYLog(@"-----%f",h);
        
        headerH = 416+h-20;
    }
    
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, headerH);
    
    UIView *v = [[UIView alloc] init];
    v.frame = CGRectMake(0, 0, SCREEN_WIDTH, headerH);
    [v addSubview:headerView];
    v.backgroundColor = RGB(245, 245, 245);
    self.tableView.tableHeaderView = v;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
//    if (_setting) {
//        self.tableView.contentInset = UIEdgeInsetsMake(64+10, 0, 0, 0);
//    }
}



- (void)creatCellTitle:(NSString *)str index:(int)index {
    
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:str destVc:nil];
    __block typeof(self)  sself = self;
    switch (index) {
        case 0:{
            item0.option = ^(NSIndexPath *indexPath){
                OperatorsReportSecondPageVC *vc = [[OperatorsReportSecondPageVC alloc]init];
                vc.itemType = OperatorsReportDetailTypeTenMostCall;//前十
                if (_operationNewModel) {
                    vc.data = _operationNewModel.recordInfo10List;
                }else{
                    vc.data = nil;
                }
                
                
                [sself.navigationController pushViewController:vc animated:YES];
                
            };
            break;
        }case 1:{
            item0.option = ^(NSIndexPath *indexPath){
                OperatorsReportSecondPageVC *vc = [[OperatorsReportSecondPageVC alloc]init];
                vc.itemType = OperatorsReportDetailTypeCallList;//详单 通话
                vc.data = _operationMainModel.callRecordInfo;
                
                
                [sself.navigationController pushViewController:vc animated:YES];
                
            };
            break;
        } case 2:{
            item0.option = ^(NSIndexPath *indexPath){
                OperatorsReportSecondPageVC *vc = [[OperatorsReportSecondPageVC alloc]init];
                vc.itemType = OperatorsReportDetailTypeBill;//账单
                vc.data =  _operationMainModel.bill;
                
                
                
                [sself.navigationController pushViewController:vc animated:YES];
                
            };
            break;
        }case 3:{
            item0.option = ^(NSIndexPath *indexPath){
                OperatorsReportSecondPageVC *vc = [[OperatorsReportSecondPageVC alloc]init];
                vc.itemType = OperatorsReportDetailTypeOperation;//办理业务
                vc.data = _operationMainModel.businessInfo;
                
                
                [sself.navigationController pushViewController:vc animated:YES];
                
            };
            break;
        }
//        case 4:{
//            item0.option = ^(NSIndexPath *indexPath){
//                OperatorsReportSecondPageVC *vc = [[OperatorsReportSecondPageVC alloc]init];
//                vc.itemType = OperatorsReportDetailTypeNetwork;//上网数据
//                vc.data = _operationMainModel.netInfo;
//                
//                [sself.navigationController pushViewController:vc animated:YES];
//                
//            };
//            break;
//        }
        case 4:{
            item0.option = ^(NSIndexPath *indexPath){
                OperatorsReportSecondPageVC *vc = [[OperatorsReportSecondPageVC alloc]init];
                vc.itemType = OperatorsReportDetailTypeMessage;//短信
                vc.data = _operationMainModel.smsInfo;
                [sself.navigationController pushViewController:vc animated:YES];
                
            };
            break;}
        case 5:{
//            item0.option = ^(NSIndexPath *indexPath){
//                OperatorsReportSecondPageVC *vc = [[OperatorsReportSecondPageVC alloc]init];
//                vc.itemType = OperatorsReportDetailTypeMore;
//                [sself.navigationController pushViewController:vc animated:YES];
//                
//            };
            break;
        }default:
            break;
    }
    
    YJItemGroup *group = [[YJItemGroup alloc] init];
    group.groups = @[item0];
    [self.dataSource addObject:group];
   
    
}
#pragma mark-重写父类方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJMeCell *cell = [YJMeCell meCell:tableView];
//    cell.accessoryArrowBtn.titleLabel.textAlignment = NSTextAlignmentRight;
//    if (iPhone5) {

    YJItemGroup *group = self.dataSource[indexPath.section];
    YJBaseItem *item = group.groups[indexPath.row];
    cell.item = item;
    cell.accessoryView.width = 35;
//    cell.accessoryArrowBtn.backgroundColor = [UIColor redColor];
    if (group.groups.count-1 == indexPath.row) {
        UIView *separateLine1 = [[UIView alloc] init];
        separateLine1.frame = CGRectMake(0, 45.0-0.5, SCREEN_WIDTH, 0.5);
        separateLine1.backgroundColor = RGB_grayLine;
        
        [cell.contentView addSubview:separateLine1];
    }
    
    return cell;
}






#pragma mark -
//#pragma mark -  弃用
//#pragma mark -
//#pragma mark   显示验证码
//-(void)showMeaasga:(NSNotification*)noti{
//    [_operatorsDataTool removeTimer];
//    [YJCreditWaitingView yj_hideWaitingViewForView:self.view animated:YES];
//    
//    __block typeof(self) sself = self;
//    
//    CommonSendMsgVC *ss = [[CommonSendMsgVC alloc]init];
//    ss.msg = self.searchConditionModel.account;
//    if(_isSCALJL){
//        ss.sendMsgType = CommonSendMsgTypeJLDX;
//    }else{
//        ss.sendMsgType = CommonSendMsgTypePhone;
//    }
//    //确认回调
//    ss.Sure=^(id obj){
//        _yzm = (NSString *)obj;
//        [sself fromYZMNetwork];
//        _NOData =NO;
//    };
//    //取消回调
//    ss.Cancel = ^(id obj){
//        [self.navigationController popViewControllerAnimated:YES];
//    };
//    
//    [self presentViewController:[[YJNavigationController alloc] initWithRootViewController:ss] animated:YES completion:nil];
//}
//
//#pragma mark 收到错误信息
//-(void)showErrorE:(NSNotification*)noti {
//    [YJCreditWaitingView yj_hideWaitingViewForView:self.view animated:YES];
//    NSDictionary *dic =noti.userInfo;
//    [self.view makeToast:dic[@"key"]];
//    if ([dic[@"isOut"] integerValue]) {//强制退出
//        [self jOutSelf];
//    }
//}
//
//
//
//#pragma mark  网络 验证码验证
//-(void)fromYZMNetwork{
//    __block typeof(self) sself = self;
//    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
//    //开启新的轮训
//    _operatorsDataTool = [[OperatorsDataTool alloc]init];
//    _operatorsDataTool.info =_yzm;
//    _operatorsDataTool.searchType = self.searchType;
//    [_operatorsDataTool messageInfo:nil OperatorsDataMeaasgasuccess:^(id obj) {
//        [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
//        MYLog(@"有验证码-----OK-------%@",obj);
//        if (obj[@"data"][@"data"]) {
//            NSDictionary *dic = obj[@"data"][@"data"];
//            [sself creatGroupDataArray:dic];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                sself.tableView.hidden = NO;
//                [sself creatUI];
//                [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
//            });
//            
//        }
//        
//        
//    } failure:^(NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
//            NSString *errorStr = nil;
//            if (error.domain) {
//                errorStr = error.domain;
//            } else {
//                errorStr =errorInfo;
//            }
//            [sself.view makeToast:errorStr];
//            [sself jOutSelf];
//        });
//        
//    }];
//}
//#pragma mark  查询---首页
//-(void)sendNetwork{
//    
//    __block typeof(self) sself = self;
//    _operatorsDataTool = [[OperatorsDataTool alloc] init];
//    _operatorsDataTool.searchConditionModel = self.searchConditionModel;
//    _operatorsDataTool.searchType = self.searchType;
//    
//    [_operatorsDataTool searchInfo:nil OperatorsDataSuccesssuccess:^(id obj) {
//        MYLog(@"无验证码-----OK-------%@",obj);
//        [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
//        if (obj[@"data"][@"data"]) {
//            NSDictionary *dic = obj[@"data"][@"data"];
//            [sself creatGroupDataArray:dic];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                sself.tableView.hidden = NO;
//                [sself creatUI];
//            });
//        } else {
//            [sself.view makeToast:@"暂无数据"];
//            [sself jOutSelf];
//        }
//        
//        
//        
//    } failure:^(NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
//            NSString *errorStr = nil;
//            if (error.domain) {
//                errorStr = error.domain;
//            } else {
//                errorStr =errorInfo;
//            }
//            [sself.view makeToast:errorStr];
//            [sself jOutSelf];
//            
//        });
//    }];
//    
//}

//#pragma mark 收到验证码   3 次
////- (void)msgg:(NSNotification*)noti{
////
////    NSDictionary *dic = noti.userInfo;
////   _yzm = dic[@"key"];
////    [self fromYZMNetwork];
////
////}


@end
