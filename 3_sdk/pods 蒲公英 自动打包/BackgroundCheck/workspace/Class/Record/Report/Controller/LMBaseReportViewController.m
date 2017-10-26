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

#import "ReportPersonalRiskInfoCell.h"
#import "ReportRecordInfoCell.h"

#import "ReportModel.h"


typedef NS_ENUM(NSInteger,JBaseReportCellType){
    JBaseReportCellTypeBaseInfo = 0,
    JBaseReportCellTypeRiskTips,
    JBaseReportCellTypePersionRecord,
    JBaseReportCellTypePersionRiskInfo
};

@interface LMBaseReportViewController () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableview;

@property (strong, nonatomic) ReportSectionView   *sectionView;
@property (strong, nonatomic) ReportBaseInfoCell  *baseInfoCell;
@property (strong, nonatomic) ReportRiskTipsCell  *riskTipsCell;
@property (strong, nonatomic) ReportPersonalRiskInfoCell  *personalRiskInfoCell;
@property (strong, nonatomic) ReportRecordInfoCell  *recordInfoCell;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) ReportModel  *dataModel;


@end

@implementation LMBaseReportViewController

- (void)dealloc {
    self.tableview.dataSource = nil;
    self.tableview.delegate = nil;
}

#pragma mark  - view
- (ReportSectionView *)sectionView {
    if (!_sectionView) {
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
- (ReportPersonalRiskInfoCell *)personalRiskInfoCell {
    if (!_personalRiskInfoCell) {
        _personalRiskInfoCell = [[NSBundle mainBundle] loadNibNamed:ReportPersonalRiskInfoCellIdentifier owner:self options:nil].firstObject;
    }
    return _personalRiskInfoCell;
}
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


#pragma mark  -  数据处理
-(void)getData{
    __block typeof(self) sself = self;
    [YJHTTPTool get:@"http://192.168.117.36:8080/BackData/backDemo.do" params:nil success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        sself.dataModel = [ReportModel mj_objectWithKeyValues:responseObj];
        [sself manageData];
        [sself.tableview reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)manageData{
    [self.dataSource addObject:self.dataModel.BasicMsg];
    [self.dataSource addObject:self.dataModel.riskMsg];
    [self.dataSource addObject:self.dataModel.BiographicalMsg];
    [self.dataSource addObject:self.dataModel.PersonalRiskMsg];
}

#pragma mark  - view 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:self.tableview];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f2f5"];
    [self.tableview registerNib:[UINib nibWithNibName:ReportBaseInfoCellIdentifier bundle:nil] forCellReuseIdentifier:ReportBaseInfoCellIdentifier];
    [self.tableview registerNib:[UINib nibWithNibName:ReportRiskTipsCellIdentifier bundle:nil] forCellReuseIdentifier:ReportRiskTipsCellIdentifier];
    [self.tableview registerNib:[UINib nibWithNibName:ReportRecordInfoCellIdentifier bundle:nil] forCellReuseIdentifier:ReportRecordInfoCellIdentifier];
    [self.tableview registerNib:[UINib nibWithNibName:ReportPersonalRiskInfoCellIdentifier bundle:nil] forCellReuseIdentifier:ReportPersonalRiskInfoCellIdentifier];
    [self.tableview registerNib:[UINib nibWithNibName:ReportSectionViewIdentifier bundle:nil] forHeaderFooterViewReuseIdentifier:ReportSectionViewIdentifier];
    
    // self.tableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    //    self.tableVivew.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    self.tableview.estimatedRowHeight=44;
    self.tableview.rowHeight=UITableViewAutomaticDimension;
    self.tableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self getData];
    
}
#pragma mark  -  tableview
// section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
// cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    
    if (index == JBaseReportCellTypeBaseInfo) { // 基本信息
        ReportBaseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ReportBaseInfoCellIdentifier forIndexPath:indexPath];
        cell.reportBaseInfoModel = self.dataModel.BasicMsg;
        return cell;
    }else if(index == JBaseReportCellTypeRiskTips) { // 风险提示
        ReportRiskTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:ReportRiskTipsCellIdentifier forIndexPath:indexPath];
        cell.riskTipsModel = self.dataModel.riskMsg;
        return cell;
    }else if(index == JBaseReportCellTypePersionRecord) { // 个人履历
        ReportRecordInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ReportRecordInfoCellIdentifier forIndexPath:indexPath];
        cell.persionRecordModel = self.dataModel.BiographicalMsg;
        return cell;
    }else if(index == JBaseReportCellTypePersionRiskInfo) { // 个人风险信息
        ReportPersonalRiskInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ReportPersonalRiskInfoCellIdentifier forIndexPath:indexPath];
        cell.persionRiskInfoModel = self.dataModel.PersonalRiskMsg;
        return cell;
    }
    
    return nil;
}


#pragma mark tableview 高度
// cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    
    if (index == JBaseReportCellTypeBaseInfo) { // 基本信息
        return 476;
    }else if(index == JBaseReportCellTypeRiskTips) { // 风险提示
        return 120;
    }else if(index == JBaseReportCellTypePersionRecord) { // 个人履历
        self.recordInfoCell.persionRecordModel = self.dataModel.BiographicalMsg;
        return [self.personalRiskInfoCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    }else if(index == JBaseReportCellTypePersionRiskInfo) { // 个人风险信息
        
        self.personalRiskInfoCell.persionRiskInfoModel = self.dataModel.PersonalRiskMsg;
        return [self.personalRiskInfoCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
        
    }
    
    return 45;
 
//    JADataModel *sectionModel = self.dataArr[indexPath.section];
//    self.nestCell.dayModel = sectionModel.dayjourney[indexPath.row];
//    return [self.nestCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
}
 
#pragma mark section view
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ReportSectionView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ReportSectionViewIdentifier];
    [view configureSection: section ReportType:1]; 
    return view;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     
}
/**
 
 
 
 */

@end
