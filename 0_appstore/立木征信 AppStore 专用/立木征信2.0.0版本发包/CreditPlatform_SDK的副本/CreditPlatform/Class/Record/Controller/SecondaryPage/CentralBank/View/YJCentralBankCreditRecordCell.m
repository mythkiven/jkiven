//
//  ORDetailTypeBillCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "YJCentralBankCreditRecordCell.h"
#import "YJCentralBankModel.h"

@interface YJCentralBankCreditRecordCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *creditLB;
@property (weak, nonatomic) IBOutlet UILabel *houseLoanLB;

@property (weak, nonatomic) IBOutlet UILabel *otherLoanLB;


@end

@implementation YJCentralBankCreditRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}
+ (instancetype)creditRecordCellWithTabelView:(UITableView *)tableview {
    static NSString *ID = @"creditRecordCell";
    YJCentralBankCreditRecordCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YJCentralBankCreditRecordCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}

- (void)setSummaryModel:(YJCentralBankSummary *)summaryModel {
    if (summaryModel.var) {
        self.titleLB.text = summaryModel.var;
    }
    if (summaryModel.creditCount) {
        self.creditLB.text = summaryModel.creditCount;
    }
    if (summaryModel.houseLoanCount) {
        self.houseLoanLB.text = summaryModel.houseLoanCount;
    }
    if (summaryModel.otherLoanCount) {
        self.otherLoanLB.text = summaryModel.otherLoanCount;
    }
    
}


@end
