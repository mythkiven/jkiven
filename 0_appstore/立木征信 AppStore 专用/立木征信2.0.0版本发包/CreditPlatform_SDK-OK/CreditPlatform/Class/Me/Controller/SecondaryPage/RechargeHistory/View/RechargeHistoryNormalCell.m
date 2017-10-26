//
//  RechargeHistoryNormalCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "RechargeHistoryNormalCell.h"
#import "RechargeHistoryModel.h"

@interface RechargeHistoryNormalCell ()
@property (weak, nonatomic) IBOutlet UILabel *Month;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *Icon;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *payType;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end

@implementation RechargeHistoryNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)purchaseHistoryCellWithTableView:(UITableView *)tableView {
    
    RechargeHistoryNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeHistoryNormalCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"RechargeHistoryNormalCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return cell;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(RechargeHistoryModel *)model{
    _model = model;
    _status.text = model.rechangeStateStr;
    _payType.text = model.rechangeTypeName;
//    _money.text = [model.rechangeAmt stringByAppendingString:@"元"];
     _money.text = [NSString stringWithFormat:@"%.2f元",[model.rechangeAmt floatValue]];
    NSInteger length = _money.text.length;
    if (length>=2) {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithAttributedString:_money.attributedText];
        [att addAttributes:@{NSForegroundColorAttributeName:RGB_black,NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(length-1,1 )];
        _money.attributedText = att;
    }
    
    
    if ([model.rechangeType isEqualToString:@"2"]) {//支付宝 icon_alipay_small
        _Icon.image = [UIImage imageNamed:@"icon_alipay"];
    } else if ([model.rechangeType isEqualToString:@"1"]) {//微信 icon_wechatPay_small
        _Icon.image = [UIImage imageNamed:@"icon_wechatPay"];
    } else if ([model.rechangeType isEqualToString:@"4"]) {//银行转账
        _Icon.image = [UIImage imageNamed:@"icon_transfer"];
    } else if ([model.rechangeType isEqualToString:@"3"]) {//红包
        _Icon.image = [UIImage imageNamed:@"icon_redPacket"];
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
//@property (copy,nonatomic) NSString      *rechangeDate; //消费时间
//@property (copy,nonatomic) NSString      *rechangeType ; //充值类别 代号
//@property (copy,nonatomic) NSString      *rechangeTypeName; //充值类别 名称
//@property (copy,nonatomic) NSString      *serialNo ; //流水号
//@property (copy,nonatomic) NSString      *rechangeAmt; //充值金额
//@property (copy,nonatomic) NSString      *rechangeState; //充值状态



@end
