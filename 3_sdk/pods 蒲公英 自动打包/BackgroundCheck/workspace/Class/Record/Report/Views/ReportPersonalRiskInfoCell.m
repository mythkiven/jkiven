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

// 个人风险
typedef NS_ENUM(NSInteger,JReportRecordType){
    JReportRecordFayuanType = 0,
    JReportRecordDishonestType,
    JReportRecordLoadinfoType
};


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
    
    
    self.childPersionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.childPersionTableView.estimatedRowHeight=44;
    self.childPersionTableView.rowHeight=UITableViewAutomaticDimension;
    self.childPersionTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.childPersionTableView.delegate = self;
    self.childPersionTableView.dataSource = self;
    
    
    
}

-(void)setPersionRiskInfoModel:(PersionRiskInfoModel *)persionRiskInfoModel{
    _persionRiskInfoModel = persionRiskInfoModel;
    
    [self.childPersionTableView reloadData];
    self.tableHeightConstraint.constant = self.childPersionTableView.contentSize.height;
    
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
        self.persionRiskCourtLawSuitCell.persionRiskInfoFaYuanModel = self.persionRiskInfoModel.cligMsg[indexPath.row];
        return [self.persionRiskCourtLawSuitCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    }else if (indexPath.section == JReportRecordDishonestType){ // 失信
        self.persionRiskDishonestsCell.persionRiskInfoShiXinModel = self.persionRiskInfoModel.dishMsg[indexPath.row];
        return [self.persionRiskDishonestsCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    }else if (indexPath.section == JReportRecordDishonestType){ // 贷款
        self.persionRiskloanInfoCell.persionRiskInfoDaiKuanModel = self.persionRiskInfoModel.linfMsg[indexPath.row];
        return [self.persionRiskloanInfoCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 200;
    //    if (section == JATableCellTypePics) {
    //        return CGFLOAT_MIN;
    //    }else if (section == JATableCellTypeText){
    //        if (self.dayModel.journeyrange.count > 0) {
    //            return 10.0f;
    //        }else{
    //            return CGFLOAT_MIN;
    //        }
    //    }
    //    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    //  view.tintColor = [UIColor colorWithRed:70.0f/255.0f green:70.0f/255.0f blue:70.0f/255.0f alpha:1.0f];
}



@end
