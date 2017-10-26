//
//  YJSocialSecurityDetailCell.m
//  CreditPlatform
//
//  Created by yj on 16/8/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJSocialSecurityDetailCell.h"

@interface YJSocialSecurityDetailCell ()

/**
 *  缴费日期
 */
@property (weak, nonatomic) IBOutlet UILabel *payDateLB;
/**
 *  缴费金额
 */
@property (weak, nonatomic) IBOutlet UILabel *payLB;

/**
 *  缴费基数
 */
@property (weak, nonatomic) IBOutlet UILabel *basePayLB;
/**
 *  公司名称
 */
@property (weak, nonatomic) IBOutlet UILabel *companyNameLB;
/**
 *  业务描述
 */
@property (weak, nonatomic) IBOutlet UILabel *desLB;

@end

@implementation YJSocialSecurityDetailCell

+ (instancetype)socialSecurityDetailCellWithTableView:(UITableView *)tableView isMaternity:(BOOL)ret{
    
    YJSocialSecurityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"socialSecurityDetailCell"];
    
    if (cell == nil) {
        if (ret) {
            cell= [[[NSBundle mainBundle] loadNibNamed:@"YJSocialSecurityDetailCell" owner:nil options:nil] lastObject];
        } else {
           cell= [[[NSBundle mainBundle] loadNibNamed:@"YJSocialSecurityDetailCell" owner:nil options:nil] firstObject];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
    
    
}


+ (instancetype)socialSecurityDetailCellWithTableView:(UITableView *)tableView {
    
    YJSocialSecurityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"socialSecurityDetailCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJSocialSecurityDetailCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
    
    
}

- (void)setBaseInsurance:(YJBaseInsurance *)baseInsurance {
    if (baseInsurance.accDate) {
        if (baseInsurance.accDate.length>0)
            self.payDateLB.text = baseInsurance.accDate;
    }
    
    if (baseInsurance.corpName) {
        if (baseInsurance.corpName.length>0)
            self.companyNameLB.text = baseInsurance.corpName;
    }
    
    if (baseInsurance.baseDeposit) {
        if (baseInsurance.baseDeposit.length>0)
            self.basePayLB.text = baseInsurance.baseDeposit;
    }
    
//    if (baseInsurance.payMonth) {
//        self.payDateLB.text = baseInsurance.payMonth;
//    }
//    
    if (baseInsurance.amt) {
        if (baseInsurance.amt.length>0)
            self.payLB.text = baseInsurance.amt;
    }
    
    if (baseInsurance.bizDesc) {
        if (baseInsurance.bizDesc.length>0)
            self.desLB.text = baseInsurance.bizDesc;
    }
    
    
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    
    [super setFrame:frame];
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
