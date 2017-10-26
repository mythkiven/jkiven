//
//  YJPurchaseHistoryCell.m
//  CreditPlatform
//
//  Created by yj on 16/9/5.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJPurchaseHistoryCell.h"
#import "YJPurchaseHistoryModel.h"
@interface YJPurchaseHistoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *Month;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *Icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *money;

@property (weak, nonatomic) IBOutlet UILabel *childNameLB;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneyTopConstraint;

@end

@implementation YJPurchaseHistoryCell

+ (instancetype)purchaseHistoryCellWithTableView:(UITableView *)tableView {
    
    YJPurchaseHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"purchaseHistoryCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJPurchaseHistoryCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return cell;
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
//    if (iPhone5|iPhone4s) {
//        _name.font =Font16;
//    }
}

- (void)setListModel:(YJPurchaseHistoryListModel *)listModel {
    _listModel = listModel;

    
    _name.text = listModel.serviceName;
    //    NSString *ID = [model.serialNo StringReplaceRangeFrom:9 To:(model.serialNo.length - 3) WithString:@"..."];
    _ID.text = [NSString stringWithFormat:@"ID:%@",listModel.serialNo];
    
    _money.text = [NSString stringWithFormat:@"%.2f",[listModel.consuAmt floatValue]];
    if ([listModel.serviceType isEqualToString:@"maimai"]) {//脉脉
        _Icon.image = [UIImage imageNamed:@"icon_purchase_MaiMai"];
    } else if ([listModel.serviceType isEqualToString:@"linkedin"]) {//领英
        _Icon.image = [UIImage imageNamed:@"icon_purchase_Linyin"];
    } else if ([listModel.serviceType isEqualToString:@"taobao"]) {//淘宝
        _Icon.image = [UIImage imageNamed:@"icon_purchase_TaoBao"];
        
    } else if ([listModel.serviceType isEqualToString:@"mobile"]) {//手机
        _Icon.image = [UIImage imageNamed:@"icon_purchase_operator"];
    } else if ([listModel.serviceType isEqualToString:@"credit"]) {//央行
        _Icon.image = [UIImage imageNamed:@"icon_purchase_centralBank"];
    } else if ([listModel.serviceType isEqualToString:@"housefund"]) {//公积金
        _Icon.image = [UIImage imageNamed:@"icon_purchase_houseFund"];
    } else if ([listModel.serviceType isEqualToString:@"jd"]) {//京东
        _Icon.image = [UIImage imageNamed:@"icon_purchase_JD"];
    } else if ([listModel.serviceType isEqualToString:@"socialsecurity"]) {//社保
        _Icon.image = [UIImage imageNamed:@"icon_purchase_socialSecturity"];
    }else if ([listModel.serviceType isEqualToString:@"education"]) {//学历
        _Icon.image = [UIImage imageNamed:@"icon_purchase_education"];
    } else if ([listModel.serviceType isEqualToString:kBizType_shixin]) {//失信
        _Icon.image = [UIImage imageNamed:@"icon_purchase_shixin"];
    }else if ([listModel.serviceType isEqualToString:kBizType_bill]) {//信用卡账单
        _Icon.image = [UIImage imageNamed:@"icon_purchase_creditBill"];
    }else if ([listModel.serviceType isEqualToString:kBizType_autoinsurance]) {//车险
        _Icon.image = [UIImage imageNamed:@"icon_purchase_carInsurance"];
    }else if ([listModel.serviceType isEqualToString:kBizType_ebank]) {//网银
        _Icon.image = [UIImage imageNamed:@"icon_purchase_eBankBill"];
    } else if ([listModel.serviceType isEqualToString:kBizType_diditaxi]) {//滴滴
        _Icon.image = [UIImage imageNamed:@"icon_purchase_didi"];
    }else if ([listModel.serviceType isEqualToString:kBizType_ctrip]) {//携程
        _Icon.image = [UIImage imageNamed:@"icon_purchase_ctrip"];
    } else if ([listModel.serviceType isEqualToString:kBizType_mobilecheck]) {//手机号
        _Icon.image = [UIImage imageNamed:@"icon_purchase_mobilecheck"];
    }else if ([listModel.serviceType isEqualToString:kBizType_idcheck]) {//身份
        _Icon.image = [UIImage imageNamed:@"icon_purchase_idcheck"];
    }else if ([listModel.serviceType isEqualToString:kBizType_bankcard3check]) {//银行3
        _Icon.image = [UIImage imageNamed:@"icon_purchase_bankcard3check"];
    }else if ([listModel.serviceType isEqualToString:kBizType_bankcard4check]) {//银行4
        _Icon.image = [UIImage imageNamed:@"icon_purchase_bankcard4check"];
    }else if ([listModel.serviceType isEqualToString:kBizType_mobile_report]) {//运营商信用报告
        _Icon.image = [UIImage imageNamed:@"icon_purchase_mobile_report"];
    }else{// 使用默认:
        _Icon.image = [UIImage imageNamed:@"icon_purchase_default"];
    }
    
    
    
    // 1111 22 33 44 55 66
    if (listModel.consuTime.length>=14) {
        _Month.text = [NSString stringWithFormat:@"%@-%@",
                       [listModel.consuTime substringWithRange:NSMakeRange(4, 2)],
                       [listModel.consuTime substringWithRange:NSMakeRange(6, 2)]];
        _time.text = [NSString stringWithFormat:@"%@:%@:%@",
                      [listModel.consuTime substringWithRange:NSMakeRange(8, 2)],
                      [listModel.consuTime substringWithRange:NSMakeRange(10, 2)],
                      [listModel.consuTime substringWithRange:NSMakeRange(12, 2)]];
    }else if(listModel.consuTime.length ==13){
        NSString *str = [self ConvertStrToTime:listModel.consuTime];
        _Month.text =[str substringWithRange:NSMakeRange(5, 5)];
        _time.text = [str substringFromIndex:11];
    }else{
        _Month.text = @"-";
        _time.text =  @"-";
    }
    
    if (listModel.userOperatorId && ![listModel.userOperatorId isEqualToString:@"0"]) {
        self.childNameLB.hidden = NO;
        self.childNameLB.text = listModel.userOperatorName;
        self.nameTopConstraint.constant = 10;
        self.moneyTopConstraint.constant = 27;
    } else {
        self.childNameLB.hidden = YES;
        self.nameTopConstraint.constant = 20;
        self.moneyTopConstraint.constant = 20;
    }
    
    
    
    
    
}

-(void)setModel:(PurchaseHistoryModel *)model{
    _model = model;
    _name.text = model.serviceName;
//    NSString *ID = [model.serialNo StringReplaceRangeFrom:9 To:(model.serialNo.length - 3) WithString:@"..."];
    _ID.text = [NSString stringWithFormat:@"ID:%@",model.serialNo];
    
    _money.text = [NSString stringWithFormat:@"%.2f",[model.consuAmt floatValue]];
    if ([model.serviceType isEqualToString:@"maimai"]) {//脉脉
        _Icon.image = [UIImage imageNamed:@"icon_purchase_MaiMai"];
    } else if ([model.serviceType isEqualToString:@"linkedin"]) {//领英
        _Icon.image = [UIImage imageNamed:@"icon_purchase_Linyin"];
    } else if ([model.serviceType isEqualToString:@"taobao"]) {//淘宝
        _Icon.image = [UIImage imageNamed:@"icon_purchase_TaoBao"];
        
    } else if ([model.serviceType isEqualToString:@"mobile"]) {//手机
        _Icon.image = [UIImage imageNamed:@"icon_purchase_operator"];
    } else if ([model.serviceType isEqualToString:@"credit"]) {//央行
        _Icon.image = [UIImage imageNamed:@"icon_purchase_centralBank"];
    } else if ([model.serviceType isEqualToString:@"housefund"]) {//公积金
        _Icon.image = [UIImage imageNamed:@"icon_purchase_houseFund"];
    } else if ([model.serviceType isEqualToString:@"jd"]) {//京东
        _Icon.image = [UIImage imageNamed:@"icon_purchase_JD"];
    } else if ([model.serviceType isEqualToString:@"socialsecurity"]) {//社保
        _Icon.image = [UIImage imageNamed:@"icon_purchase_socialSecturity"];
    }else if ([model.serviceType isEqualToString:@"education"]) {//学历
        _Icon.image = [UIImage imageNamed:@"icon_purchase_education"];
    } else if ([model.serviceType isEqualToString:kBizType_shixin]) {//失信
        _Icon.image = [UIImage imageNamed:@"icon_purchase_shixin"];
    }else if ([model.serviceType isEqualToString:kBizType_bill]) {//信用卡账单
        _Icon.image = [UIImage imageNamed:@"icon_purchase_creditBill"];
    }else if ([model.serviceType isEqualToString:kBizType_autoinsurance]) {//车险
        _Icon.image = [UIImage imageNamed:@"icon_purchase_carInsurance"];
    }else if ([model.serviceType isEqualToString:kBizType_ebank]) {//网银
        _Icon.image = [UIImage imageNamed:@"icon_purchase_eBankBill"];
    } else if ([model.serviceType isEqualToString:kBizType_diditaxi]) {//滴滴
        _Icon.image = [UIImage imageNamed:@"icon_purchase_didi"];
    }else if ([model.serviceType isEqualToString:kBizType_ctrip]) {//携程
        _Icon.image = [UIImage imageNamed:@"icon_purchase_ctrip"];
    } else if ([model.serviceType isEqualToString:kBizType_mobilecheck]) {//手机号
        _Icon.image = [UIImage imageNamed:@"icon_purchase_mobilecheck"];
    }else if ([model.serviceType isEqualToString:kBizType_idcheck]) {//身份
        _Icon.image = [UIImage imageNamed:@"icon_purchase_idcheck"];
    }else if ([model.serviceType isEqualToString:kBizType_bankcard3check]) {//银行3
        _Icon.image = [UIImage imageNamed:@"icon_purchase_bankcard3check"];
    }else if ([model.serviceType isEqualToString:kBizType_bankcard4check]) {//银行4
        _Icon.image = [UIImage imageNamed:@"icon_purchase_bankcard4check"];
    }else if ([model.serviceType isEqualToString:kBizType_mobile_report]) {//运营商信用报告
        _Icon.image = [UIImage imageNamed:@"icon_purchase_mobile_report"];
    }else{// 使用默认:
        _Icon.image = [UIImage imageNamed:@"icon_purchase_default"];
    }
    
    
    
    // 1111 22 33 44 55 66
    if (model.consuTime.length>=14) {
        _Month.text = [NSString stringWithFormat:@"%@-%@",
                       [model.consuTime substringWithRange:NSMakeRange(4, 2)],
                       [model.consuTime substringWithRange:NSMakeRange(6, 2)]];
        _time.text = [NSString stringWithFormat:@"%@:%@:%@",
                      [model.consuTime substringWithRange:NSMakeRange(8, 2)],
                      [model.consuTime substringWithRange:NSMakeRange(10, 2)],
                      [model.consuTime substringWithRange:NSMakeRange(12, 2)]];
    }else if(model.consuTime.length ==13){
       NSString *str = [self ConvertStrToTime:model.consuTime];
        _Month.text =[str substringWithRange:NSMakeRange(5, 5)];
        _time.text = [str substringFromIndex:11];
    }else{
        _Month.text = @"-";
        _time.text =  @"-";
    }
    
    if (model.userOperatorId && ![model.userOperatorId isEqualToString:@"0"]) {
        self.childNameLB.hidden = NO;
        self.childNameLB.text = model.userOperatorName;
        self.nameTopConstraint.constant = 10;
        self.moneyTopConstraint.constant = 27;
    } else {
        self.childNameLB.hidden = YES;
        self.nameTopConstraint.constant = 20;
        self.moneyTopConstraint.constant = 20;
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
