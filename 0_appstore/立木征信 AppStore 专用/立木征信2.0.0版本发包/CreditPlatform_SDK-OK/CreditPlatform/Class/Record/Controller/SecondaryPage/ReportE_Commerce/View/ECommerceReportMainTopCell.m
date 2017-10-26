//
//  YJSocialSecurityView.m
//  CreditPlatform
//
//  Created by yj on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ECommerceReportMainTopCell.h"
#import "JDReportModel.h"

@interface ECommerceReportMainTopCell()
/*********基本信息********/
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLB;

/**
 *  等级
 */
@property (weak, nonatomic) IBOutlet UILabel *level;
/**
 *  手机号
 */
@property (weak, nonatomic) IBOutlet UILabel *phone;
/**
 *  邮箱
 */
@property (weak, nonatomic) IBOutlet UILabel *mail;
/**
 *  真实名字
 */
@property (weak, nonatomic) IBOutlet UILabel *realName;
/**
 *  身份证
 */
@property (weak, nonatomic) IBOutlet UILabel *ID;
/**
 *  成长值
 */
@property (weak, nonatomic) IBOutlet UILabel *growLevel;
/**
 *  身安全等级
 */
@property (weak, nonatomic) IBOutlet UILabel *safeLevel;
/*********存缴信息********/
/**
 *  总额度
 */
@property (weak, nonatomic) IBOutlet UILabel *totalLimit;
/**
 *  可用额度
 */
@property (weak, nonatomic) IBOutlet UILabel *canuseLimit;
/**
 *  开通？
 */
@property (weak, nonatomic) IBOutlet UILabel *isOpen;
/**
 *  月还款
 */
@property (weak, nonatomic) IBOutlet UILabel *payMonth;
/**
 *  白条消费
 */
@property (weak, nonatomic) IBOutlet UILabel *baitiaoPay;
/**
 *  信用
 */
@property (weak, nonatomic) IBOutlet UILabel *xinyong;




@end
@implementation ECommerceReportMainTopCell
+ (instancetype)socialSecurityView {
    return [[[NSBundle mainBundle] loadNibNamed:@"ECommerceReportMainTopCell" owner:nil options:nil] firstObject];
}


-(void)setModel:(JDbasicInfoModel *)model {
    _model = model;
    _nameLB.text = FillSpace(model.nickName);
    _level.text = FillSpace(model.vipLevel);
    _phone.text = FillSpace(model.mobileNo);
    _mail.text = FillSpace(model.email);
    _realName.text = FillSpace(model.realName);
    _ID.text = FillSpace(model.idCard);
    _growLevel.text = FillSpace(model.growthValue);
    _safeLevel.text = FillSpace(model.securityLevel);
    
}
-(void)setBaitiaoModel:(JDbaiTiaoInfoModel *)baitiaoModel{
    _totalLimit.text = FillSpace(baitiaoModel.creditlimit);// 总额度
    _canuseLimit.text = FillSpace(baitiaoModel.availablelimit);//可用额度
    _isOpen.text = FillSpace(baitiaoModel.isOpen);//是否开通
    _payMonth.text = FillSpace(baitiaoModel.monthloan);//月还
    _baitiaoPay.text = FillSpace(baitiaoModel.biaoTiaoConSum);//白条金额
    _xinyong.text = FillSpace(baitiaoModel.xiaoBaiCreditValue);//信用
    
    
}
@end
