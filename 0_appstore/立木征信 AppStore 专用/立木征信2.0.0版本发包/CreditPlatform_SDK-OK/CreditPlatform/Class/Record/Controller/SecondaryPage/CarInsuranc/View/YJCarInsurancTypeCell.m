//
//  YJFilingTimeCell.m
//  CreditPlatform
//
//  Created by yj on 2016/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCarInsurancTypeCell.h"
#import "YJCarInsuranceModel.h"
#import "YJEBankBillModel.h"
@interface YJCarInsurancTypeCell ()

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;


@end

@implementation YJCarInsurancTypeCell

+ (instancetype)carInsurancTypeCellWithTableView:(UITableView *)tableView {
    
    YJCarInsurancTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carInsurancTypeCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJCarInsurancTypeCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
}

- (void)setPolicyDetail:(YJCarInsurancePolicyDetails *)policyDetail {
    _policyDetail = policyDetail;
    
    
    self.typeLB.text = [NSString stringWithFormat:@"%@ %@年%@",policyDetail.vehicleInfoModel.plateNo,[policyDetail.effectivePeriodStart componentsSeparatedByString:@"-"][0],policyDetail.insuranceAlias];
    
    
    [self setupSelectedBtn:policyDetail.isSelected];
    
    
}


- (void)setEBankCards:(YJEBankCards *)eBankCards {
    _eBankCards = eBankCards;
    int temp = (int)eBankCards.cardNo.length - 4;
    
    int loc = temp < 0 ? 0 : temp;
    int len = temp < 0 ? (int)eBankCards.cardNo.length : 4;
    NSRange range = NSMakeRange(loc , len);
    
    NSString *subStr = [eBankCards.cardNo substringWithRange:range];
    subStr = [@"**** **** **** " stringByAppendingString:subStr];
    
    self.typeLB.text = [NSString stringWithFormat:@"%@ %@",self.typeLB.text,subStr];
    
    [self setupSelectedBtn:eBankCards.isSelected];

}

- (void)setupSelectedBtn:(BOOL)isSelected {
    
    if (isSelected) {
        self.selectedBtn.selected = YES;
        self.typeLB.textColor = RGB_navBar;
    } else {
        self.selectedBtn.selected = NO;
        self.typeLB.textColor = RGB_black;
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
