//
//  LMBaseReportViewController.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/29.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "LMBaseReportViewController.h"

#import "ReportSectionView.h"

#import "ReportBaseInfoCell.h"
#import "ReportRiskTipsCell.h"

#import "PersionRiskloanInfoCell.h"
#import "ReportRecordInfoCell.h"

#import "ReportModel.h"

#import "PersionRiskCourtLawSuitCell.h"
#import "PersionRiskDishonestsCell.h"
#import "PersionRiskloanInfoCell.h"
#import "LMZXBaseSearchDataTool.h"
#import "LMZXQueryInfoModel.h"

@interface LMBaseReportViewController () <UITableViewDelegate,UITableViewDataSource>
{
    LMZXBaseSearchDataTool *_searchTool;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) ReportSectionView   *sectionView;
@property (strong, nonatomic) ReportBaseInfoCell  *baseInfoCell;
@property (strong, nonatomic) ReportRiskTipsCell  *riskTipsCell;
//@property (strong, nonatomic) ReportPersonalRiskInfoCell  *personalRiskInfoCell;
@property (strong, nonatomic) ReportRecordInfoCell  *recordInfoCell;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) ReportModel  *dataModel;


@end

@implementation LMBaseReportViewController
{
    NSInteger JBaseReportCellTypeBaseInfo ; // 基础
    NSInteger JBaseReportCellTypeRiskTips ; // 风险提示
    NSInteger JBaseReportCellTypeRecordLvLi; // 履历
    NSInteger JBaseReportCellTypePersionFaYuan ; // 法院
    NSInteger JBaseReportCellTypePersionShiXin ; // 失信
    NSInteger JBaseReportCellTypePersionDaiKuan ; // 贷款
    
}

- (void)dealloc {
    self.tableview.dataSource = nil;
    self.tableview.delegate = nil;
}

#pragma mark  - view
- (ReportSectionView *)sectionView {
    if (!_sectionView){
        _sectionView = [[NSBundle mainBundle] loadNibNamed:ReportSectionViewIdentifier owner:self options:nil].firstObject;
    }
    return _sectionView;
}
- (ReportBaseInfoCell *)baseInfoCell {
    if (!_baseInfoCell) {
        _baseInfoCell = [[NSBundle mainBundle] loadNibNamed:ReportBaseInfoCellIdentifier owner:self options:nil].firstObject;
    }
    return _baseInfoCell;
}
- (ReportRiskTipsCell *)riskTipsCell {
    if (!_riskTipsCell) {
        _riskTipsCell = [[NSBundle mainBundle] loadNibNamed:ReportRiskTipsCellIdentifier owner:self options:nil].firstObject;
    }
    return _riskTipsCell;
}
//- (ReportPersonalRiskInfoCell *)personalRiskInfoCell {
//    if (!_personalRiskInfoCell) {
//        _personalRiskInfoCell = [[NSBundle mainBundle] loadNibNamed:ReportPersonalRiskInfoCellIdentifier owner:self options:nil].firstObject;
//    }
//    return _personalRiskInfoCell;
//}
- (ReportRecordInfoCell *)recordInfoCell {
    if (!_recordInfoCell) {
        _recordInfoCell = [[NSBundle mainBundle] loadNibNamed:ReportRecordInfoCellIdentifier owner:self options:nil].firstObject;
    }
    return _recordInfoCell;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (IBAction)scrollTop:(UIButton *)sender {
    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark  -  数据处理
-(void)getData{
    
    
    if (kUserManagerTool.mobile && kUserManagerTool.companyName) {
        _searchTool = [LMZXBaseSearchDataTool searchDataTool];
       
        [YJShortLoadingView yj_makeToastActivityInView:self.view];
        
        switch (_reportDetailFrom) {
            case LMReportDetailFromHome:
                [self runLoopSearch];
                break;
            case LMReportDetailFromList:
                [self reportListGetDetail];
                break;
            default:
                break;
        }
        
        
        
    }
    
    
}


/**
 来自首页的轮循请求
 */
- (void)runLoopSearch {
    
    LMBCSearchType searchType;
    if (_reportType == LMReportTypeStandardType) {
        searchType = LMBCSearchTypeStandard;
    } else {
        searchType = LMBCSearchTypeBasic;
    }
    
    [_searchTool searchType:searchType queryInfoModel:_queryInfoModel];
    
    __block typeof(self) sself = self;
    _searchTool.searchSuccess = ^(id obj){
        sself.dataModel = [ReportModel mj_objectWithKeyValues:obj];
        //处理数据
        [sself manageData];
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        
        // 刷新数据
        [sself.tableview reloadData];
    };
    _searchTool.searchFailure = ^(NSString *error){
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:error duration:2];
        [UIView animateWithDuration:2 animations:^{
            
        } completion:^(BOOL finished) {
            [sself.navigationController popViewControllerAnimated:YES];
        }];
    };
}


/**
 来自报告列表，获取报告详情
 */
- (void)reportListGetDetail{
    __block typeof(self) sself = self;

    [_searchTool getReportWithUID:_UID success:^(id obj) {
        sself.dataModel = [ReportModel mj_objectWithKeyValues:obj];
        //处理数据
        [sself manageData];
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        
        // 刷新数据
        [sself.tableview reloadData];
    } failure:^(NSString *error) {
        [YJShortLoadingView yj_hideToastActivityInView:sself.view];
        [sself.view makeToast:error duration:2];
        [UIView animateWithDuration:2 animations:^{
            
        } completion:^(BOOL finished) {
            [sself.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

-(void)manageData{
    [self.dataSource addObject:self.dataModel.BasicMsg]; //基础
    [self.dataSource addObject:self.dataModel.riskMsg]; // 风险提示
    if (_reportType == LMReportTypeStandardType) {
        if (self.dataModel.BiographicalMsg) {
            [self.dataSource addObject:self.dataModel.BiographicalMsg]; //个人履历 --
        }
       
    }
    
    [self.dataSource addObject:self.dataModel.PersonalRiskMsg.cligMsg]; //法院
    [self.dataSource addObject:self.dataModel.PersonalRiskMsg.dishMsg]; // 失信
    [self.dataSource addObject:self.dataModel.PersonalRiskMsg.linfMsg]; // 贷款
    
}

#pragma mark  - view 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建TableView
    [self setupTableView];
    
   
    [self getData];

    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)setupTableView {
    if (_reportType == LMReportTypeBasicType ) { // 基础
        JBaseReportCellTypeBaseInfo = 0;
        JBaseReportCellTypeRiskTips = 1 ;
        JBaseReportCellTypePersionFaYuan =2;
        JBaseReportCellTypePersionShiXin =3;
        JBaseReportCellTypePersionDaiKuan =4;
    } else if (_reportType == LMReportTypeStandardType ) { // 标准
        JBaseReportCellTypeBaseInfo = 0;
        JBaseReportCellTypeRiskTips = 1 ;
        JBaseReportCellTypeRecordLvLi =2;
        JBaseReportCellTypePersionFaYuan =3;
        JBaseReportCellTypePersionShiXin =4;
        JBaseReportCellTypePersionDaiKuan =5;
    }
    
    //  self.view =  [[[NSBundle mainBundle] loadNibNamed:@"LMBaseReportViewController" owner:self options:nil] firstObject];
    //self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    //[self.view addSubview:self.tableview];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f5"];
    self.tableview.backgroundColor = [UIColor colorWithHexString:@"f0f2f5"];
    [self.tableview registerNib:[UINib nibWithNibName:ReportBaseInfoCellIdentifier bundle:nil] forCellReuseIdentifier:ReportBaseInfoCellIdentifier];
    [self.tableview registerNib:[UINib nibWithNibName:ReportRiskTipsCellIdentifier bundle:nil] forCellReuseIdentifier:ReportRiskTipsCellIdentifier];
    [self.tableview registerNib:[UINib nibWithNibName:ReportSectionViewIdentifier bundle:nil] forHeaderFooterViewReuseIdentifier:ReportSectionViewIdentifier];
    
    //    [self.tableview registerNib:[UINib nibWithNibName:ReportPersonalRiskInfoCellIdentifier bundle:nil] forCellReuseIdentifier:ReportPersonalRiskInfoCellIdentifier];
    [self.tableview registerNib:[UINib nibWithNibName:ReportRecordInfoCellIdentifier bundle:nil] forCellReuseIdentifier:ReportRecordInfoCellIdentifier];
    [self.tableview registerNib:[UINib nibWithNibName:ReportSectionViewIdentifier bundle:nil] forHeaderFooterViewReuseIdentifier:ReportSectionViewIdentifier];
    
    
    [self.tableview registerNib:[UINib nibWithNibName:PersionRiskCourtLawSuitCellIdentifier bundle:nil] forCellReuseIdentifier:PersionRiskCourtLawSuitCellIdentifier];
    [self.tableview registerNib:[UINib nibWithNibName:PersionRiskDishonestsCellIdentifier bundle:nil] forCellReuseIdentifier:PersionRiskDishonestsCellIdentifier];
    [self.tableview registerNib:[UINib nibWithNibName:PersionRiskloanInfoCellIdentifier bundle:nil] forCellReuseIdentifier:PersionRiskloanInfoCellIdentifier];
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.estimatedRowHeight=44;
    self.tableview.rowHeight=UITableViewAutomaticDimension;
    self.tableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UILabel *footer = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    footer.text = @"没有更多数据了";
    footer.font = JFont(15);
    footer.textAlignment = 1;
    footer.textColor = YJColor(209,209, 209);
    self.tableview.tableFooterView = footer;

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_searchTool stopSearch];
}
#pragma mark  -  tableview
// section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==  JBaseReportCellTypeBaseInfo) {
        return 1;
    } else if (section ==  JBaseReportCellTypeRiskTips) {
        return 1;
    }
    if (!self.dataSource.count) {
        return 1;
    }
    if (LMReportTypeBasicType == _reportType) { // 基础
         if (section ==  JBaseReportCellTypePersionFaYuan) {
            return ((NSArray*)self.dataSource[JBaseReportCellTypePersionFaYuan]).count;
        } else if (section ==  JBaseReportCellTypePersionShiXin) {
            return ((NSArray*)self.dataSource[JBaseReportCellTypePersionShiXin]).count;
        } else if (section ==  JBaseReportCellTypePersionDaiKuan) {
            return ((NSArray*)self.dataSource[JBaseReportCellTypePersionDaiKuan]).count;
        }
    }else if(LMReportTypeStandardType == _reportType){ // 标准
        if (section ==JBaseReportCellTypeRecordLvLi ) {
            return 1;
        } else if (section ==  JBaseReportCellTypePersionFaYuan) {
            return ((NSArray*)self.dataSource[JBaseReportCellTypePersionFaYuan]).count;
        } else if (section ==  JBaseReportCellTypePersionShiXin) {
            return ((NSArray*)self.dataSource[JBaseReportCellTypePersionShiXin]).count;
        } else if (section ==  JBaseReportCellTypePersionDaiKuan) {
            return ((NSArray*)self.dataSource[JBaseReportCellTypePersionDaiKuan]).count;
        }
    }
    return 0;
}
// cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (LMReportTypeBasicType == _reportType) {
        return 5;
    }else if(LMReportTypeStandardType == _reportType){ // 标准
        return 6;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.section;
    
    if (index == JBaseReportCellTypeBaseInfo) { // 基本信息
        ReportBaseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ReportBaseInfoCellIdentifier forIndexPath:indexPath];
        cell.reportBaseInfoModel = self.dataModel.BasicMsg;
        return cell;
    }else if(index == JBaseReportCellTypeRiskTips) { // 风险提示
        ReportRiskTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:ReportRiskTipsCellIdentifier forIndexPath:indexPath];
        cell.riskTipsModel = self.dataModel.riskMsg;
        return cell;
    }
    
    if (!self.dataSource.count) {
        return [UITableViewCell new];
    }
    
    if (LMReportTypeBasicType == _reportType) { // 基础
        if (index ==  JBaseReportCellTypePersionFaYuan) {
            PersionRiskCourtLawSuitCell  *pCell = [tableView dequeueReusableCellWithIdentifier:PersionRiskCourtLawSuitCellIdentifier forIndexPath:indexPath];
            pCell.persionRiskInfoFaYuanModel = ((NSArray*)self.dataSource[JBaseReportCellTypePersionFaYuan])[indexPath.row];
            if (indexPath.row == ((NSArray*)self.dataSource[JBaseReportCellTypePersionFaYuan]).count-1) {
                pCell.isLastCell = YES;
            }
            return pCell;
        } else if (index ==  JBaseReportCellTypePersionShiXin) {
            PersionRiskDishonestsCell   *pCell = [tableView dequeueReusableCellWithIdentifier:PersionRiskDishonestsCellIdentifier forIndexPath:indexPath];
            pCell.persionRiskInfoShiXinModel = ((NSArray*)self.dataSource[JBaseReportCellTypePersionShiXin])[indexPath.row];
            if (indexPath.row == ((NSArray*)self.dataSource[JBaseReportCellTypePersionShiXin]).count-1) {
                pCell.isLastCell = YES;
            }
            return pCell;
        } else if (index ==  JBaseReportCellTypePersionDaiKuan) {
            PersionRiskloanInfoCell   *pCell = [tableView dequeueReusableCellWithIdentifier:PersionRiskloanInfoCellIdentifier forIndexPath:indexPath];
            pCell.persionRiskInfoDaiKuanModel = ((NSArray*)self.dataSource[JBaseReportCellTypePersionDaiKuan])[indexPath.row];
            if (indexPath.row == ((NSArray*)self.dataSource[JBaseReportCellTypePersionDaiKuan]).count-1) {
                pCell.isLastCell = YES;
            }
            return pCell;
        }
    }else if(LMReportTypeStandardType == _reportType){    // 标准
        if(index == JBaseReportCellTypeRecordLvLi) {
            ReportRecordInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ReportRecordInfoCellIdentifier forIndexPath:indexPath];
            cell.persionRecordModel = self.dataModel.BiographicalMsg;
            return cell;
        }else if (index ==  JBaseReportCellTypePersionFaYuan) {
            PersionRiskCourtLawSuitCell  *pCell = [tableView dequeueReusableCellWithIdentifier:PersionRiskCourtLawSuitCellIdentifier forIndexPath:indexPath];
            pCell.persionRiskInfoFaYuanModel = ((NSArray*)self.dataSource[JBaseReportCellTypePersionFaYuan])[indexPath.row];
            if (indexPath.row == ((NSArray*)self.dataSource[JBaseReportCellTypePersionFaYuan]).count-1) {
                pCell.isLastCell = YES;
            }
            return pCell;
        } else if (index ==  JBaseReportCellTypePersionShiXin) {
            PersionRiskDishonestsCell   *pCell = [tableView dequeueReusableCellWithIdentifier:PersionRiskDishonestsCellIdentifier forIndexPath:indexPath];
            pCell.persionRiskInfoShiXinModel = ((NSArray*)self.dataSource[JBaseReportCellTypePersionShiXin])[indexPath.row];
            if (indexPath.row == ((NSArray*)self.dataSource[JBaseReportCellTypePersionShiXin]).count-1) {
                pCell.isLastCell = YES;
            }
            return pCell;
        } else if (index ==  JBaseReportCellTypePersionDaiKuan) {
            PersionRiskloanInfoCell   *pCell = [tableView dequeueReusableCellWithIdentifier:PersionRiskloanInfoCellIdentifier forIndexPath:indexPath];
            pCell.persionRiskInfoDaiKuanModel = ((NSArray*)self.dataSource[JBaseReportCellTypePersionDaiKuan])[indexPath.row];
            if (indexPath.row == ((NSArray*)self.dataSource[JBaseReportCellTypePersionDaiKuan]).count-1) {
                pCell.isLastCell = YES;
            }
            return pCell;
        }
    }
    
    return [UITableViewCell new];
}


#pragma mark tableview 高度
// cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.section;
    if (index ==  JBaseReportCellTypeBaseInfo) { // 基本信息
        return [ReportBaseInfoCell cellHeight];
    } else if (index ==  JBaseReportCellTypeRiskTips) { // 风险提示
        return [ReportRiskTipsCell cellHeight];
    }
    
    if (!self.dataSource.count) {
        return CGFLOAT_MIN;
    }
    
    if (LMReportTypeBasicType == _reportType) { // 基础
        if (index ==  JBaseReportCellTypePersionFaYuan) {
             return [PersionRiskCourtLawSuitCell cellHeight:((NSArray*)self.dataSource[JBaseReportCellTypePersionFaYuan])[indexPath.row] ];
         } else if (index ==  JBaseReportCellTypePersionShiXin) {
            return [PersionRiskDishonestsCell cellHeight:((NSArray*)self.dataSource[JBaseReportCellTypePersionShiXin])[indexPath.row]];
        } else if (index ==  JBaseReportCellTypePersionDaiKuan) {
            return [PersionRiskloanInfoCell cellHeight];
        }
    }else if(LMReportTypeStandardType == _reportType){ // 标准
        if (index ==JBaseReportCellTypeRecordLvLi ) {// 个人履历
            self.recordInfoCell.persionRecordModel = self.dataModel.BiographicalMsg;
            return [ReportRecordInfoCell cellHeight:self.dataModel.BiographicalMsg];
        } else if (index ==  JBaseReportCellTypePersionFaYuan) {
            return [PersionRiskCourtLawSuitCell cellHeight:((NSArray*)self.dataSource[JBaseReportCellTypePersionFaYuan])[indexPath.row] ];
        } else if (index ==  JBaseReportCellTypePersionShiXin) {
            return [PersionRiskDishonestsCell cellHeight:((NSArray*)self.dataSource[JBaseReportCellTypePersionShiXin])[indexPath.row]];
        } else if (index ==  JBaseReportCellTypePersionDaiKuan) {
            return [PersionRiskloanInfoCell cellHeight];
        }
    }
    return CGFLOAT_MIN;
}
 
#pragma mark section view
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section ==  JBaseReportCellTypeBaseInfo) {
        return 50;
    } else if (section ==  JBaseReportCellTypeRiskTips) {
        return 50;
    }
    
    if (LMReportTypeBasicType == _reportType) { // 基础
        if (section ==  JBaseReportCellTypePersionFaYuan) {
            return 50+36;
        } else if (section ==  JBaseReportCellTypePersionShiXin) {
            return 10+36;
        } else if (section ==  JBaseReportCellTypePersionDaiKuan) {
            return 10+36;
        }
    }else if(LMReportTypeStandardType == _reportType){ // 标准
        if (section ==JBaseReportCellTypeRecordLvLi ) {
            return 50;
        } else if (section ==  JBaseReportCellTypePersionFaYuan) {
            return 50+36;
        } else if (section ==  JBaseReportCellTypePersionShiXin) {
            return 10+36;
        } else if (section ==  JBaseReportCellTypePersionDaiKuan) {
            return 10+36;
        }
    }
    return CGFLOAT_MIN;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 标准的 view:
    ReportSectionView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ReportSectionViewIdentifier];
    [view configureSection: section ReportType:_reportType];
    UIView *sview = [[UIView alloc]initWithFrame:view.frame];
    sview.backgroundColor = YJColor(240,242,245);
    view.backgroundView = sview;
    view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 50);
    
    // view 2:
    UIView *viewS2 = [self view2:section];
    
    
    if (section ==  JBaseReportCellTypeBaseInfo) {
        return view;
    } else if (section ==  JBaseReportCellTypeRiskTips) {
        return view;
    }
    
    if (LMReportTypeBasicType == _reportType) { // 基础
        if (section ==  JBaseReportCellTypePersionFaYuan) {
            return [self view1];
        } else if (section ==  JBaseReportCellTypePersionShiXin) {
            return viewS2;
        } else if (section ==  JBaseReportCellTypePersionDaiKuan) {
            return viewS2;
        }
    }else if(LMReportTypeStandardType == _reportType){ // 标准
        if (section ==JBaseReportCellTypeRecordLvLi ) {
            return view;
        } else if (section ==  JBaseReportCellTypePersionFaYuan) {
             return [self view1];
        } else if (section ==  JBaseReportCellTypePersionShiXin) {
            return viewS2;
        } else if (section ==  JBaseReportCellTypePersionDaiKuan) {
            return viewS2;
        }
    }
    return nil;
    
    
}
-(UIView*)view1{
    ReportSectionView *views = [[NSBundle mainBundle] loadNibNamed:ReportSectionViewIdentifier owner:self options:nil].firstObject;
    views.frame =CGRectMake(0, 0, SCREEN_WIDTH, 50);
    views.title = @"个人风险信息";
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36+50)];
    view.backgroundColor = YJColor(240,242,245);
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 36)];
    v.backgroundColor = YJColor(152, 161, 179);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-15, 36)];
    [label setText:@"法院诉讼记录"];
    [label setFont:JFont(15)];
    [label setTextColor:[UIColor whiteColor]];
    [v addSubview:label];
    [view addSubview:v];
    [view addSubview:views];
    return view;
}
-(UIView*)view2:(NSInteger )section{
    NSString*title;
    if (LMReportTypeBasicType == _reportType) { // 基础
        if (section ==  JBaseReportCellTypePersionFaYuan) {
            title = @"法院诉讼记录";
        } else if (section ==  JBaseReportCellTypePersionShiXin) {
            title = @"失信被执行记录";
        } else if (section ==  JBaseReportCellTypePersionDaiKuan) {
            title = @"贷款信息";
        }
    }else if(LMReportTypeStandardType == _reportType){ // 标准
        if (section ==JBaseReportCellTypeRecordLvLi ) {
            
        } else if (section ==  JBaseReportCellTypePersionFaYuan) {
            title = @"法院诉讼记录";
        } else if (section ==  JBaseReportCellTypePersionShiXin) {
            title = @"失信被执行记录";
        } else if (section ==  JBaseReportCellTypePersionDaiKuan) {
            title = @"贷款信息";
        }
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36+10)];
    view.backgroundColor = YJColor(152, 161, 179);
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view1.backgroundColor = YJColor(240, 242, 245);
    [view addSubview:view1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-15, 36)];
    [label setText:title];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:JFont(15)];
    [view addSubview:label];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 50;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}

/**
 
 
 
 */

@end
