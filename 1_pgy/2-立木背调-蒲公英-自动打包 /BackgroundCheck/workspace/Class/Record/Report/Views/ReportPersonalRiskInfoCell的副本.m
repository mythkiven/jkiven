//
//  ReportPersonalRiskInfoCell.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "ReportPersonalRiskInfoCell.h"

#import "PersionRiskCourtLawSuitCell.h"
#import "PersionRiskDishonestsCell.h"
#import "PersionRiskloanInfoCell.h"




@interface ReportPersonalRiskInfoCell  ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *childPersionTableView;

// 法院
@property (strong, nonatomic) PersionRiskCourtLawSuitCell *persionRiskCourtLawSuitCell;
// 失信
@property (strong, nonatomic) PersionRiskDishonestsCell *persionRiskDishonestsCell;
// 贷款
@property (strong, nonatomic) PersionRiskloanInfoCell *persionRiskloanInfoCell;

@end

static CGFloat cellHeight = 1;

@implementation ReportPersonalRiskInfoCell

- (PersionRiskCourtLawSuitCell *)persionRiskCourtLawSuitCell {
    if (!_persionRiskCourtLawSuitCell) {
        _persionRiskCourtLawSuitCell = [[NSBundle mainBundle] loadNibNamed:PersionRiskCourtLawSuitCellIdentifier owner:self options:nil].firstObject;
    }
    return _persionRiskCourtLawSuitCell;
}
- (PersionRiskDishonestsCell *)persionRiskDishonestsCell {
    if (!_persionRiskDishonestsCell) {
        _persionRiskDishonestsCell = [[NSBundle mainBundle] loadNibNamed:PersionRiskDishonestsCellIdentifier owner:self options:nil].firstObject;
    }
    return _persionRiskDishonestsCell;
}
- (PersionRiskloanInfoCell *)persionRiskloanInfoCell {
    if (!_persionRiskloanInfoCell) {
        _persionRiskloanInfoCell = [[NSBundle mainBundle] loadNibNamed:PersionRiskloanInfoCellIdentifier owner:self options:nil].firstObject;
    }
    return _persionRiskloanInfoCell;
}

 
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.childPersionTableView registerNib:[UINib nibWithNibName:PersionRiskCourtLawSuitCellIdentifier bundle:nil] forCellReuseIdentifier:PersionRiskCourtLawSuitCellIdentifier];
    [self.childPersionTableView registerNib:[UINib nibWithNibName:PersionRiskDishonestsCellIdentifier bundle:nil] forCellReuseIdentifier:PersionRiskDishonestsCellIdentifier];
    [self.childPersionTableView registerNib:[UINib nibWithNibName:PersionRiskloanInfoCellIdentifier bundle:nil] forCellReuseIdentifier:PersionRiskloanInfoCellIdentifier];
    self.childPersionTableView.estimatedRowHeight=44.0;
    self.childPersionTableView.rowHeight=UITableViewAutomaticDimension;
    
    
    
    self.childPersionTableView.estimatedRowHeight=44;
    self.childPersionTableView.rowHeight=UITableViewAutomaticDimension; 
    
}

+ (CGFloat)cellHeight:(PersionRiskInfoModel*)model {
    
    cellHeight = 0;
    CGFloat height =0;
    for (int i=0; i<model.cligMsg.count; i++) { // 法院
        height +=[PersionRiskCourtLawSuitCell cellHeight:model.cligMsg[i]];
    }
    for (int i=0; i<model.dishMsg.count; i++) { // 失信
        height +=[PersionRiskDishonestsCell cellHeight:model.dishMsg[i]];
    }
    for (int i=0; i<model.linfMsg.count; i++) { // 贷款
        height +=[PersionRiskloanInfoCell cellHeight];
    }
    model.cellHeight = cellHeight;
    
    return cellHeight;
}

-(void)setPersionRiskInfoModel:(PersionRiskInfoModel *)persionRiskInfoModel{
    _persionRiskInfoModel = persionRiskInfoModel;
    
    [self.childPersionTableView reloadData];
    self.tableHeightConstraint.constant = self.childPersionTableView.contentSize.height;
    
    cellHeight = 0;
    CGFloat height =0;
    for (int i=0; i<self.persionRiskInfoModel.cligMsg.count; i++) { // 法院
        height +=[PersionRiskCourtLawSuitCell cellHeight:self.persionRiskInfoModel.cligMsg[i]];
    }
    for (int i=0; i<self.persionRiskInfoModel.dishMsg.count; i++) { // 失信
        height +=[PersionRiskDishonestsCell cellHeight:self.persionRiskInfoModel.dishMsg[i]];
    }
    for (int i=0; i<self.persionRiskInfoModel.linfMsg.count; i++) { // 贷款
        height +=[PersionRiskloanInfoCell cellHeight];
    }
    _persionRiskInfoModel.cellHeight = cellHeight;
    
}


#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == JReportRecordFayuanType) { // 法院
        return self.persionRiskInfoModel.cligMsg.count;
    }else if(section == JReportRecordDishonestType){ // 失信
        return self.persionRiskInfoModel.dishMsg.count;
    }else if(section == JReportRecordLoadinfoType){ // 贷款
        return self.persionRiskInfoModel.linfMsg.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == JReportRecordFayuanType){// 法院诉讼
        PersionRiskCourtLawSuitCell  *pCell = [tableView dequeueReusableCellWithIdentifier:PersionRiskCourtLawSuitCellIdentifier forIndexPath:indexPath];
        pCell.persionRiskInfoFaYuanModel = self.persionRiskInfoModel.cligMsg[indexPath.row];
        return pCell;
    }else if (indexPath.section == JReportRecordDishonestType){// 失信
        PersionRiskDishonestsCell   *pCell = [tableView dequeueReusableCellWithIdentifier:PersionRiskDishonestsCellIdentifier forIndexPath:indexPath];
        pCell.persionRiskInfoShiXinModel = self.persionRiskInfoModel.dishMsg[indexPath.row];
        return pCell;
    }else if (indexPath.section == JReportRecordLoadinfoType){// 贷款
        PersionRiskloanInfoCell   *pCell = [tableView dequeueReusableCellWithIdentifier:PersionRiskloanInfoCellIdentifier forIndexPath:indexPath];
        pCell.persionRiskInfoDaiKuanModel = self.persionRiskInfoModel.linfMsg[indexPath.row];
        return pCell;
    }
    return [UITableViewCell new];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == JReportRecordFayuanType){ // 法院诉讼
        return [PersionRiskCourtLawSuitCell cellHeight:self.persionRiskInfoModel.cligMsg[indexPath.row] ];
    }else if (indexPath.section == JReportRecordDishonestType){ // 失信 
        return [PersionRiskDishonestsCell cellHeight:self.persionRiskInfoModel.dishMsg[indexPath.row]];
    }else if (indexPath.section == JReportRecordDishonestType){ // 贷款
        return [PersionRiskloanInfoCell cellHeight];
    }
    return CGFLOAT_MIN;
}

#pragma mark section view
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 36;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *title;
    if (section == JReportRecordFayuanType) { // 法院
        title = @"法院诉讼记录";
    }else if(section == JReportRecordDishonestType){ // 失信
        title = @"失信被执行记录";
    }else if(section == JReportRecordLoadinfoType){ // 贷款
        title = @"贷款信息";
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
    view.backgroundColor = YJColor(152, 161, 179);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-15, 36)];
    [label setText:title];
    [label setFont:JFont(15)];
    [view addSubview:label];
    return view;
}

@end
