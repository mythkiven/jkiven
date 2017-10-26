//
//  YJFilingTimeCell.m
//  CreditPlatform
//
//  Created by yj on 2016/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJFilingTimeCell.h"
#import "reportDishonestyModel.h"
@interface YJFilingTimeCell ()

@property (weak, nonatomic) IBOutlet UILabel *dateLB;

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;


@end

@implementation YJFilingTimeCell

+ (instancetype)filingTimeCellWithTableView:(UITableView *)tableView {
    
    YJFilingTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"filingTimeCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJFilingTimeCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
}

- (void)setReportDishonestyModel:(reportDishonestyModel *)reportDishonestyModel {
    
    self.dateLB.text = reportDishonestyModel.filingTime;
    
    if (reportDishonestyModel.isSelected) {
        self.selectedBtn.selected = YES;
        self.dateLB.textColor = RGB_navBar;
    } else {
        self.selectedBtn.selected = NO;
        self.dateLB.textColor = RGB_black;

    }
    
    
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
