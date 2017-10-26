//
//  YJComboPurchaseDetHeaderView.m
//  CreditPlatform
//
//  Created by yj on 2016/10/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJComboPurchaseDetHeaderView.h"
#import "YJComboPurchaseDetModel.h"
@interface YJComboPurchaseDetHeaderView ()
/**
 总金额
 */
@property (weak, nonatomic) IBOutlet UILabel *totalAmtLB;
/**
 账单号
 */
@property (weak, nonatomic) IBOutlet UILabel *packageSerialNoLB;
/**
 套餐名称
 */
@property (weak, nonatomic) IBOutlet UILabel *servicePackageNameLB;

/**
 消费时间
 */
@property (weak, nonatomic) IBOutlet UILabel *consuDateLB;

/**
 出账时间
 */
@property (weak, nonatomic) IBOutlet UILabel *payDateLB;

/**
 账单状态
 */
/// 账单状态
@property (weak, nonatomic) IBOutlet UILabel *settleStatusLB;



@end
@implementation YJComboPurchaseDetHeaderView

+ (instancetype)comboPurchaseDetHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YJComboPurchaseDetHeaderView" owner:nil options:nil] firstObject];
}


- (void)setComboDetModel:(YJComboPurchaseDetModel *)comboDetModel {
    _comboDetModel = comboDetModel;
    self.totalAmtLB.attributedText = [self setStatisticsAmt:comboDetModel.amt];
    self.packageSerialNoLB.text = comboDetModel.packageSerialNo;
    self.servicePackageNameLB.text = comboDetModel.servicePackageName;
    self.consuDateLB.text = [comboDetModel.consuDate componentsSeparatedByString:@" "][0];// 消费时间
//    if ([comboDetModel.createDate componentsSeparatedByString:@" "].count>=2) {
//        self.payDateLB.text = [comboDetModel.createDate componentsSeparatedByString:@" "][1];// 出账时间
//    } else {
        self.payDateLB.text = comboDetModel.createDate;// 出账时间
//    }
    
    self.settleStatusLB.text = comboDetModel.settleStatus;
    
}
- (void)setJComboPurchaseBDataModel:(JComboPurchaseBDataModel *)jComboPurchaseBDataModel{
    
    _jComboPurchaseBDataModel = jComboPurchaseBDataModel;
    self.totalAmtLB.attributedText = [self setStatisticsAmt:jComboPurchaseBDataModel.amt];
    self.packageSerialNoLB.text = jComboPurchaseBDataModel.packageSerialNo;
    self.servicePackageNameLB.text = jComboPurchaseBDataModel.servicePackageName;
    self.consuDateLB.text = [jComboPurchaseBDataModel.consuDate componentsSeparatedByString:@" "][0];// 消费时间
//    if ([jComboPurchaseBDataModel.createDate componentsSeparatedByString:@" "].count>=2) {
//        self.payDateLB.text = [jComboPurchaseBDataModel.createDate componentsSeparatedByString:@" "][1];// 出账时间
//    } else {
        self.payDateLB.text = jComboPurchaseBDataModel.createDate;// 出账时间
//    }
    
    self.settleStatusLB.text = jComboPurchaseBDataModel.settleStatus;
    
}



/**
 充值成功 笔，共 元
 消费 笔，共 元
 @param type  充值成功/(标准、套餐)消费
 @param count 总笔数
 @param amt   总金额
 */
- (NSMutableAttributedString *)setStatisticsAmt:(NSString *)amt {
    NSString *str = [NSString stringWithFormat:@"￥%.2f",[amt floatValue]];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:str];
    [att addAttributes:@{NSForegroundColorAttributeName:RGB_redText,NSFontAttributeName:[UIFont systemFontOfSize:30]} range:NSMakeRange(0, str.length)];
    
    NSRange amtRange = [str rangeOfString:@"￥"];
    NSDictionary *attributtedDict = @{NSForegroundColorAttributeName:RGB_redText,NSFontAttributeName:[UIFont systemFontOfSize:15]};
    
    [att addAttributes:attributtedDict range:amtRange];
    
    return att;
}
@end
