//
//  ReportCreditEmailBillDetailfenqiCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ReportCreditEmailBillDetailfenqiCell.h"
@interface ReportCreditEmailBillDetailfenqiCell ()
@property (weak, nonatomic) IBOutlet UILabel *fqdate;
@property (weak, nonatomic) IBOutlet UILabel *fqMoney;
@property (weak, nonatomic) IBOutlet UILabel *fqnum;
@property (weak, nonatomic) IBOutlet UILabel *everyMoney;
@property (weak, nonatomic) IBOutlet UILabel *everysxf;
@property (weak, nonatomic) IBOutlet UILabel *everyLittle;

@end

@implementation ReportCreditEmailBillDetailfenqiCell

+ (instancetype)reportCreditEmailBillDetailfenqiCellWithTableView:(UITableView *)tableView {
    
    ReportCreditEmailBillDetailfenqiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportCreditEmailBillDetailfenqiCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"ReportCreditEmailBillDetailfenqiCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
    
}
-(void)setModel:(reportCreditBillinstallments *)model{
    _model = model;
    _fqdate.text = FillSpace(model.instalmentDate);
    _fqMoney.text = zeroSpace( model.instalmentBal);
    _fqnum.text = FillSpace(model.instalmentCount);
    _everyMoney.text = zeroSpace( model.curInstalmentAmt);
    _everysxf.text = zeroSpace( model.curInstalmentFeeAmt) ;
    _everyLittle.text = zeroSpace( model.curRepaymentAmt) ;
}
-(void)setCoinSign:(NSString *)coinSign{
    _fqMoney.text = [_fqMoney.text decodeCoinSign:coinSign];
    _everyMoney.text = [_everyMoney.text  decodeCoinSign:coinSign];
    _everysxf.text = [_everysxf.text  decodeCoinSign:coinSign];
    _everyLittle.text = [_everyLittle.text  decodeCoinSign:coinSign];
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
