//
//  ReportRecordInfoCell.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

// 个人履历

#import "ReportRecordInfoCell.h"


#import "ReportRecordEducationCell.h"
#import "ReportRecordQualificationsCell.h"





@interface ReportRecordInfoCell   () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *childRecordTableView;

@property (strong, nonatomic) ReportRecordEducationCell *reportRecordEducationCell;
@property (strong, nonatomic) ReportRecordQualificationsCell *reportRecordQualificationsCell;

@end

static CGFloat cellHeight = 1;


@implementation ReportRecordInfoCell

- (ReportRecordEducationCell *)reportRecordEducationCell {
    if (!_reportRecordEducationCell) {
        _reportRecordEducationCell = [[NSBundle mainBundle] loadNibNamed:ReportRecordEducationCellIdentifier owner:self options:nil].firstObject;
    }
    return _reportRecordEducationCell;
}
- (ReportRecordQualificationsCell *)reportRecordQualificationsCell {
    if (!_reportRecordQualificationsCell) {
        _reportRecordQualificationsCell = [[NSBundle mainBundle] loadNibNamed:ReportRecordQualificationsCellIdentifier owner:self options:nil].firstObject;
    }
    return _reportRecordQualificationsCell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"00");
    [self.childRecordTableView registerNib:[UINib nibWithNibName:ReportRecordEducationCellIdentifier bundle:nil] forCellReuseIdentifier:ReportRecordEducationCellIdentifier];
    [self.childRecordTableView registerNib:[UINib nibWithNibName:ReportRecordQualificationsCellIdentifier bundle:nil] forCellReuseIdentifier:ReportRecordQualificationsCellIdentifier];
    self.childRecordTableView.estimatedRowHeight=44.0;
    self.childRecordTableView.rowHeight=UITableViewAutomaticDimension;
    self.childRecordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)setPersionRecordModel:(PersionRecordModel *)persionRecordModel{
    _persionRecordModel =  persionRecordModel ;
    NSLog(@"11");
    
    cellHeight = 0;
    cellHeight = _persionRecordModel.acrdMsg.count*[ReportRecordEducationCell cellHeight]+36;
    cellHeight += _persionRecordModel.vcqnMsg.count*[ReportRecordQualificationsCell cellHeight]+36+10;
    _persionRecordModel.cellHeight = cellHeight;
    [self.childRecordTableView reloadData];
    
    self.tableHeightConstraint.constant = self.childRecordTableView.contentSize.height;
    NSLog(@"==%lf==%lf",cellHeight,self.tableHeightConstraint.constant);
}

+ (CGFloat)cellHeight:(PersionRecordModel*)model {
    cellHeight = 0;
    cellHeight = model.acrdMsg.count*[ReportRecordEducationCell cellHeight]+36;
    cellHeight += model.vcqnMsg.count*[ReportRecordQualificationsCell cellHeight]+36+10-0.5;
    model.cellHeight = cellHeight;
    return cellHeight;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"22");
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"33-%ld-%ld-%ld",section,self.persionRecordModel.acrdMsg.count,self.persionRecordModel.vcqnMsg.count);
    if (section == JReportTableCellTypeEducation) { // 最高学历
        return self.persionRecordModel.acrdMsg.count;
    }else if(section == JReportTableCellTypeZIGE){ // 职业资格证书
        return self.persionRecordModel.vcqnMsg.count;
    }else{
        NSLog(@"--");
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"44-%@-%ld-%ld",indexPath,self.persionRecordModel.acrdMsg.count,self.persionRecordModel.vcqnMsg.count);
    if(indexPath.section == JReportTableCellTypeEducation){
        ReportRecordEducationCell *lCell = [tableView dequeueReusableCellWithIdentifier:ReportRecordEducationCellIdentifier forIndexPath:indexPath];
        NSLog(@"-");
        lCell.persionRecordHegihtEducationModel = self.persionRecordModel.acrdMsg[indexPath.row];
        return lCell;
    }else if (indexPath.section == JReportTableCellTypeZIGE){
        ReportRecordQualificationsCell  *pCell = [tableView dequeueReusableCellWithIdentifier:ReportRecordQualificationsCellIdentifier forIndexPath:indexPath];
        pCell.persionRecordQualificationsModel =self.persionRecordModel.vcqnMsg[indexPath.row];
        if (indexPath.row == self.persionRecordModel.vcqnMsg.count-1) {
            pCell.hiddenLine =YES;
        }
        return pCell;
    }else{
        return [UITableViewCell new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == JReportTableCellTypeEducation){
        return [ReportRecordEducationCell cellHeight];
    }else if (indexPath.section == JReportTableCellTypeZIGE){
        return [ReportRecordQualificationsCell cellHeight];
    }
    return 180;
}

#pragma mark section view
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if( section == JReportTableCellTypeEducation){
        return 36;
    }else if ( section == JReportTableCellTypeZIGE){
        return 36+10;
    }
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *title;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
    view.backgroundColor = YJColor(152, 161, 179);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-15, 36)];
    [label setFont:JFont(15)];
    [view addSubview:label];
    if( section == JReportTableCellTypeEducation){
        title = @"最高学历";
        [label setText:title];
    }else if ( section == JReportTableCellTypeZIGE){
        title = @"职业资格";
        [label setText:title];
        UIView *sview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        sview.backgroundColor = YJColor(240, 242, 245);
        [view addSubview:sview];
        view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 10+36);
        label.frame =CGRectMake(15, 10, SCREEN_WIDTH-15, 36);
    }
    label.textColor = [UIColor whiteColor];
    
    return view;
}



@end
