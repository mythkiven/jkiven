//
//  RechargeHistoryPayCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "RechargeHistoryPayCell.h"
#import "RechargeHistoryModel.h"
#import "YJRechargeHistoryModel.h"
@interface RechargeHistoryPayCell()
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *pay;
@property (weak, nonatomic) IBOutlet UILabel *Month;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *moneyType;

@end

@implementation RechargeHistoryPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self cornerBtn:_cancel green:NO ];
    [self cornerBtn:_pay green:YES];
}

+ (instancetype)purchaseHistoryCellWithTableView:(UITableView *)tableView {
    
    RechargeHistoryPayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeHistoryPayCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"RechargeHistoryPayCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return cell;
    
    
}

-(void)setModel:(YJRechargeHistoryListModel *)model{
    _model = model;
    _moneyType.text = model.rechangeTypeName;
    _money.text = [NSString stringWithFormat:@"%.2f元",[model.rechangeAmt floatValue]];
    NSInteger length = _money.text.length;
    if (length>=2) {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithAttributedString:_money.attributedText];
        [att addAttributes:@{NSForegroundColorAttributeName:RGB_black,NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(length-1,1 )];
        _money.attributedText = att;
    }
    
    
    if ([model.rechangeType isEqualToString:@"2"]) {//支付宝
        _icon.image = [UIImage imageNamed:@"icon_alipay"];
    } else if ([model.rechangeType isEqualToString:@"1"]) {//微信
        _icon.image = [UIImage imageNamed:@"icon_wechatPay"];
    } else if ([model.rechangeType isEqualToString:@"4"]) {//银行转账
        _icon.image = [UIImage imageNamed:@"icon_transfer"];
    } else if ([model.rechangeType isEqualToString:@"3"]) {//红包
        _icon.image = [UIImage imageNamed:@"icon_redPacket"];
    }
    
    // 1111 22 33 44 55 66
    if (model.rechangeDate.length>=14) {
        _Month.text = [NSString stringWithFormat:@"%@-%@",
                       [model.rechangeDate substringWithRange:NSMakeRange(4, 2)],
                       [model.rechangeDate substringWithRange:NSMakeRange(6, 2)]];
        _time.text = [NSString stringWithFormat:@"%@:%@:%@",
                      [model.rechangeDate substringWithRange:NSMakeRange(8, 2)],
                      [model.rechangeDate substringWithRange:NSMakeRange(10, 2)],
                      [model.rechangeDate substringWithRange:NSMakeRange(12, 2)]];
    }else if(model.rechangeDate.length ==13){
        NSString *str = [self ConvertStrToTime:model.rechangeDate];
        _Month.text =[str substringWithRange:NSMakeRange(5, 5)];
        _time.text = [str substringFromIndex:11];
    }else{
        _Month.text = @"-";
        _time.text =  @"-";
    }
    
    
    
    
    
}

- (NSString *)ConvertStrToTime:(NSString *)timeStr {
    
    long long time=[timeStr longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString*timeString=[formatter stringFromDate:d];
    
    return timeString;
    
}

-(void)cornerBtn:(UIButton*)btn green:(BOOL)no{
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    if (no) {
    }else{
        btn.layer.borderColor = RGB_grayLine.CGColor;
        btn.layer.borderWidth = 0.5;
    }
}


- (IBAction)cancelBtn:(UIButton *)sender {
    if (self.clickedRechargePayBtn) {
        self.clickedRechargePayBtn(@"00",nil);
    }
}

- (IBAction)payBtn:(UIButton *)sender {
    if (self.clickedRechargePayBtn) {
        self.clickedRechargePayBtn(@"11",_model);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
