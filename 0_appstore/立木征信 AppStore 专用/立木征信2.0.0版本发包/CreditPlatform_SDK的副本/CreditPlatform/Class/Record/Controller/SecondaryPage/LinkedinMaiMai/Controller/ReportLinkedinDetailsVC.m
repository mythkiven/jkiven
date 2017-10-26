//
//  YJReportLinkedinDetailsVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ReportLinkedinDetailsVC.h"
//#import "YJHouseFundDataTool.h"
//#import "YJHouseFundModel.h"

#import "LinkMMMainTopView.h"

#import "BaseLinkedMMDetailVC.h"



@interface ReportLinkedinDetailsVC ()
{
    CommonSearchDataTool  *commonSearchDataTool_;
    
    MMMainModel *mmModel_;
    LinkedMainModel *linkModel_;
}

//@property (nonatomic, strong) YJHouseFundModel *houseFundModel;
@end

@implementation ReportLinkedinDetailsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    switch (self.searchConditionModel.type) {
        case YJGoToSearchResultTypeFromHome:
            [self laodHouseFundData];
            break;
        case YJGoToSearchResultTypeFromRecord:
            
            if ([self.recodeType isEqualToString: @"linkedin"]) {
                self.searchType = SearchItemTypeLinkedin;
            } else if ( [self.recodeType isEqualToString: @"maimai"]){
                self.searchType = SearchItemTypeMaimai;
            }
            
            [self checkDetailReport];
            break;
            
        default:
            break;
    }
    
    if (self.searchType == SearchItemTypeMaimai) {
        self.title = @"脉脉报告";
    } else if ( self.searchType ==SearchItemTypeLinkedin){
        self.title = @"领英报告";
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}


#pragma mark - 创建UI
- (void)creatUI {
    [self setupHeaderView];
    [self.tableView reloadData];
}

- (void)setupHeaderView {
    
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = RGB_pageBackground;
    
    
    LinkMMMainTopView *headerView = [LinkMMMainTopView linkMMMainTopViewView:self.searchType];
    headerView.searchType =self.searchType;
    if (self.searchType == SearchItemTypeMaimai) {
        headerView.mmModel = mmModel_.cardInfo;
        bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 460);
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 460);
    } else if ( self.searchType ==SearchItemTypeLinkedin){
        headerView.linkModel = linkModel_.cardInfo;
        bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 370);
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 370);
    }
    
    [bg addSubview:headerView];
    
 
    
    self.tableView.tableHeaderView = bg;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
}

#pragma mark - 创建model view
-(void)creatGroupDataArray:(NSDictionary *)dic {
    
    if (self.searchType == SearchItemTypeMaimai) {
        mmModel_ = [MMMainModel mj_objectWithKeyValues:dic];
        
        NSMutableArray *_titleDataArray = [NSMutableArray arrayWithCapacity:0];
        [_titleDataArray addObject:@"基本信息"];
        [_titleDataArray addObject:@"好友信息"];
        [_titleDataArray addObject:@"工作经历"];
        [_titleDataArray addObject:@"教育经历"];
        NSMutableArray *_DataArray = [NSMutableArray arrayWithCapacity:0];
        if (mmModel_.baseInfo) {
            [_DataArray addObject:mmModel_.baseInfo];
        }else
            [_DataArray addObject:@""];
        if (mmModel_.friendInfos.count) {
            [_DataArray addObject:mmModel_.friendInfos];
        }else
            [_DataArray addObject:@""];
        if (mmModel_.workExps.count) {
            [_DataArray addObject:mmModel_.workExps];
        }else
            [_DataArray addObject:@""];
        if (mmModel_.educationExps.count) {
            [_DataArray addObject:mmModel_.educationExps];
        }else
            [_DataArray addObject:@""];
        
        
        for (int i=0 ; i<_titleDataArray.count; i++) {
            [self creatCellTitle:_titleDataArray[i] index:i other:_DataArray[i]];
        }
        
        
    } else if ( self.searchType ==SearchItemTypeLinkedin){
        linkModel_ = [LinkedMainModel mj_objectWithKeyValues:dic];
        
        NSMutableArray *_titleDataArray = [NSMutableArray arrayWithCapacity:0];
        [_titleDataArray addObject:@"基本信息"];
        [_titleDataArray addObject:@"好友信息"];
        [_titleDataArray addObject:@"工作经历"];
        [_titleDataArray addObject:@"教育经历"];
        NSMutableArray *_DataArray = [NSMutableArray arrayWithCapacity:0];
        if (linkModel_.baseInfo) {
            [_DataArray addObject:linkModel_.baseInfo];
        }else
            [_DataArray addObject:@""];
        if (linkModel_.friendInfos.count) {
            [_DataArray addObject:linkModel_.friendInfos];
        }else
            [_DataArray addObject:@""];
        if (linkModel_.workExps.count) {
            [_DataArray addObject:linkModel_.workExps];
        }else
            [_DataArray addObject:@""];
        if (linkModel_.educationExps.count) {
            [_DataArray addObject:linkModel_.educationExps];
        }else
            [_DataArray addObject:@""];
        
        
        for (int i=0 ; i<_titleDataArray.count; i++) {
            [self creatCellTitle:_titleDataArray[i] index:i other:_DataArray[i]];
        }
        
        
    }
    
    
}

- (void)creatCellTitle:(NSString *)str index:(int)index other:(id)data{
    
    YJArrowItem *item0 = [YJArrowItem itemWithTitle:str destVc:nil];
    __block typeof(self)  sself = self;
    switch (index) {
        case 0:{
            item0.option = ^(NSIndexPath *indexPath){
                if (!data |[data isKindOfClass:[NSString class]]) {
                    [sself.view makeToast:@"无数据记录"];
                }else{
                    
                    BaseLinkedMMDetailVC *vc = [[BaseLinkedMMDetailVC alloc]init];
                    vc.itemType = LinkedMMDetailBaseInfo;
                    vc.searchType = self.searchType;
                    vc.dataDic = data;
                    [sself.navigationController pushViewController:vc animated:YES];
                    
                }
                
                
            };
            break;
        }case 1:{
            item0.option = ^(NSIndexPath *indexPath){
                if (!data |[data isKindOfClass:[NSString class]]) {
                    [sself.view makeToast:@"无数据记录"];
                }else{
                    
                    BaseLinkedMMDetailVC *vc = [[BaseLinkedMMDetailVC alloc]init];
                    vc.itemType = LinkedMMDetailFriendInfo;
                    vc.searchType = self.searchType;
                    vc.dataList = data;
                    [sself.navigationController pushViewController:vc animated:YES];
                }
            };
            break;
        } case 2:{
            item0.option = ^(NSIndexPath *indexPath){
                if (!data |[data isKindOfClass:[NSString class]]) {
                    [sself.view makeToast:@"无数据记录"];
                }else{
                    
                    BaseLinkedMMDetailVC *vc = [[BaseLinkedMMDetailVC alloc]init];
                    vc.itemType = LinkedMMDetailWork;
                    vc.searchType = self.searchType;
                    vc.dataList = data;
                    [sself.navigationController pushViewController:vc animated:YES];
                }
            };
            break;
        }case 3:{
            item0.option = ^(NSIndexPath *indexPath){//教育经历
                if (!data |[data isKindOfClass:[NSString class]]) {
                    [sself.view makeToast:@"无数据记录"];
                }else{
                    
                    BaseLinkedMMDetailVC *vc = [[BaseLinkedMMDetailVC alloc]init];
                    vc.itemType = LinkedMMDetailEducation;
                    vc.searchType = self.searchType;
                    vc.dataList = data;
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
    
    
}

#pragma mark - 网络
#pragma mark 查询记录
-(void)checkDetailReport{
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];
    
    NSDictionary *dicParams =@{@"method" : urlJK_recordDetailProcess,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"reportId":self.searchConditionModel.ID,
                               @"appVersion": VERSION_APP_1_3_3};

    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_recordDetailProcess] params:dicParams success:^(id obj) {
        if (obj[@"data"][@"data"]) {
            NSDictionary *dic = obj[@"data"][@"data"];
            [sself creatGroupDataArray:dic];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [YJCreditWaitingView yj_hideWaitingViewForView:self.view animated:YES];
                [sself creatUI];
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
#pragma mark 首页查询
- (void)laodHouseFundData {
    __weak typeof(self) sself = self;
    [YJCreditWaitingView yj_showWaitingViewAddedTo:self.view animated:YES];

    commonSearchDataTool_ = [[CommonSearchDataTool alloc] init];
    if (self.searchType == SearchItemTypeMaimai) {
        commonSearchDataTool_.method =  urlJK_queryMaiMai;
    } else if ( self.searchType ==SearchItemTypeLinkedin){
        commonSearchDataTool_.method =  urlJK_queryLinkedin;
    }
    
    commonSearchDataTool_.searchConditionModel = self.searchConditionModel;
    commonSearchDataTool_.searchType = self.searchType;
    commonSearchDataTool_.version = VERSION_APP_1_3_3;
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
        if (obj[@"data"][@"data"]) {
            
            NSDictionary *dic = obj[@"data"][@"data"];
            [sself creatGroupDataArray:dic];
            dispatch_async(dispatch_get_main_queue(), ^{
                [YJCreditWaitingView yj_hideWaitingViewForView:sself.view animated:YES];
                [sself creatUI];
            });
            
        } else {
            [sself.view makeToast:@"暂无数据"];
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

//-(void)outselfQ{
//    [self.navigationController popViewControllerAnimated:YES];
//}

@end
