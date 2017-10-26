//
//  YJInsuranceCell.m
//  CreditPlatform
//
//  Created by yj on 16/8/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJInsuranceCell.h"


@interface YJInsuranceCell()

/**
 *  保险类型
 */
@property (weak, nonatomic) IBOutlet UILabel *SocialSecurityTypeLB;

/**
 *  余额
 */
@property (weak, nonatomic) IBOutlet UILabel *balLB;
/**
 *  截止年月
 */
@property (weak, nonatomic) IBOutlet UILabel *duteToDateLB;

/**
 *  状态
 */
@property (weak, nonatomic) IBOutlet UILabel *stateLB;





@end
@implementation YJInsuranceCell
+ (instancetype)insuranceCellWithTableView:(UITableView *)tableView {
    
    YJInsuranceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"insuranceCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJInsuranceCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
    
    
}

- (void)setInsurances:(YJInsurances *)insurances {
    int type = [insurances.insuranceType intValue];
    // 1：养老 2：医疗 3：失业 4：工伤 5：生育
    NSString *stringType = nil;
    switch (type) {
        case 1:
        {
            stringType = @"养老保险";
            break;
        }
        case 2:
        {
            stringType = @"医疗保险";
            break;
        }
        case 3:
        {
            stringType = @"失业保险";
            break;
        }
        case 4:
        {
            stringType = @"工伤保险";
            break;
        }
        case 5:
        {
            stringType = @"生育保险";
            break;
        }
        default:
        {
            break;
        }
    }
    
    self.SocialSecurityTypeLB.text = stringType;
    if (insurances.bal) {
        if(insurances.bal.length>0)
            self.balLB.text = insurances.bal;
        else
            self.balLB.text = @"--";
        
    }
    if (insurances.dueToMonth) {
        if (insurances.dueToMonth.length>0) {
            self.duteToDateLB.text = insurances.dueToMonth;
        } else {
            self.duteToDateLB.text = @"--";
        }
        
        
    }
    if (insurances.accStatus) {
        if (insurances.accStatus.length>0) {
            self.stateLB.text = insurances.accStatus;
        } else {
            self.stateLB.text = @"--";
        }
        
        
    }
    
    self.detailBtn.tag = type;
    
}
- (void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    
    [super setFrame:frame];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];

//    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)detailBtnTouchDown:(UIButton *)sender {
    
    sender.backgroundColor = RGB_graySelected;
}

- (IBAction)detailBtnTouchUp:(UIButton *)sender {
    sender.backgroundColor = RGB_white;

    
}
- (IBAction)detailBtnClick:(UIButton *)sender {
    if (self.detailOption) {
        self.detailOption((int)sender.tag);
    }
    
    sender.backgroundColor = RGB_white;

    
}

@end
