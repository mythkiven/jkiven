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


typedef NS_ENUM(NSInteger,JReportTableCellType){
    JReportTableCellTypeEducation = 0,
    JReportTableCellTypeZIGE
};


@interface ReportRecordInfoCell   () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *childRecordTableView;

@property (strong, nonatomic) ReportRecordEducationCell *reportRecordEducationCell;
@property (strong, nonatomic) ReportRecordQualificationsCell *reportRecordQualificationsCell;

@end


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
    
    [self.childRecordTableView registerNib:[UINib nibWithNibName:ReportRecordEducationCellIdentifier bundle:nil] forCellReuseIdentifier:ReportRecordEducationCellIdentifier];
    [self.childRecordTableView registerNib:[UINib nibWithNibName:ReportRecordQualificationsCellIdentifier bundle:nil] forCellReuseIdentifier:ReportRecordEducationCellIdentifier];
    self.childRecordTableView.estimatedRowHeight=44.0;
    self.childRecordTableView.rowHeight=UITableViewAutomaticDimension;
    
}

-(void)setPersionRecordModel:(PersionRecordModel *)persionRecordModel{
    _persionRecordModel = persionRecordModel;
    
    [self.childRecordTableView reloadData];
    self.tableHeightConstraint.constant = self.childRecordTableView.contentSize.height;
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"111");
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"222-%ld",section);
    if (section == JReportTableCellTypeEducation) { // 最高学历
        return self.persionRecordModel.acrdMsg.count;
    }else if(section == JReportTableCellTypeZIGE){ // 职业资格证书
        return self.persionRecordModel.vcqnMsg.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == JReportTableCellTypeEducation){
        ReportRecordEducationCell *lCell = [tableView dequeueReusableCellWithIdentifier:ReportRecordEducationCellIdentifier forIndexPath:indexPath];
        NSLog(@"-");
        lCell.persionRecordHegihtEducationModel = self.persionRecordModel.acrdMsg[indexPath.row];
        return lCell;
    }else if (indexPath.section == JReportTableCellTypeZIGE){
        ReportRecordQualificationsCell  *pCell = [tableView dequeueReusableCellWithIdentifier:ReportRecordQualificationsCellIdentifier forIndexPath:indexPath];
        pCell.persionRecordQualificationsModel =self.persionRecordModel.vcqnMsg[indexPath.row];
        return pCell;
    }else{
        return [UITableViewCell new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == JReportTableCellTypeEducation){
        self.reportRecordEducationCell.persionRecordHegihtEducationModel = self.persionRecordModel.acrdMsg[indexPath.row];
        return [self.reportRecordEducationCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    }else if (indexPath.section == JReportTableCellTypeZIGE){
        self.reportRecordQualificationsCell.persionRecordQualificationsModel = self.persionRecordModel.vcqnMsg[indexPath.row];
        return [self.reportRecordQualificationsCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    }
    
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20; 
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    //  view.tintColor = [UIColor colorWithRed:70.0f/255.0f green:70.0f/255.0f blue:70.0f/255.0f alpha:1.0f];
}


@end
