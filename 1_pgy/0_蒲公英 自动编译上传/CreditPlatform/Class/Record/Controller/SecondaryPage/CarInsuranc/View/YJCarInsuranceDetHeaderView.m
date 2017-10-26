//
//  YJReportTaoBaoHeaderView.m
//  CreditPlatform
//
//  Created by yj on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCarInsuranceDetHeaderView.h"
#import "YJCarInsuranceModel.h"

@interface YJCarInsuranceDetHeaderView ()
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLB;
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLB;

/**
 *  性别
 */
@property (weak, nonatomic) IBOutlet UILabel *sexLB;
/**
 *  出生日期
 */
@property (weak, nonatomic) IBOutlet UILabel *birthdayLB;

/**
 *  身份证号
 */
@property (weak, nonatomic) IBOutlet UILabel *idLB;

/**
 *  婚姻
 */
@property (weak, nonatomic) IBOutlet UILabel *marriageLB;

/**
 *  城市
 */
@property (weak, nonatomic) IBOutlet UILabel *cityLB;

/**
 *  绑定手机号
 */
@property (weak, nonatomic) IBOutlet UILabel *phoneLB;
/**
 *  邮箱
 */
@property (weak, nonatomic) IBOutlet UILabel *emailLB;

/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *addressLB;

/**
 *  保险公司
 */
@property (weak, nonatomic) IBOutlet UILabel *insuranceCompanyLB;



@end
@implementation YJCarInsuranceDetHeaderView

+ (id)carInsuranceDetHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YJCarInsuranceDetHeaderView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];

    
}

- (void)setBasicInfo:(YJCarInsuranceBasicInfo *)basicInfo {
    _basicInfo = basicInfo;
    
    if (![basicInfo.username isEqualToString:@""]) {
        self.userNameLB.text = basicInfo.username;
    }

    if (![basicInfo.name isEqualToString:@""]) {
        self.nameLB.text = basicInfo.name;
    }
    
    if (![basicInfo.gender isEqualToString:@""]) {
        self.sexLB.text = basicInfo.gender;
    }
    
    if (![basicInfo.birthday isEqualToString:@""]) {
        self.birthdayLB.text = basicInfo.birthday;
    }
    
    if (![basicInfo.identityNo isEqualToString:@""]) {
        self.idLB.text = basicInfo.identityNo;
    }
    
    if (![basicInfo.maritalStatus isEqualToString:@""]) {
        self.marriageLB.text = basicInfo.maritalStatus;
    }
    
    
    
    if (![basicInfo.city isEqualToString:@""]) {
        self.cityLB.text = basicInfo.city;
    }
    
    if (![basicInfo.mobile isEqualToString:@""]) {
        self.phoneLB.text = basicInfo.mobile;
    }
    
    if (![basicInfo.email isEqualToString:@""]) {
        self.emailLB.text = basicInfo.email;
    }
    
    if (![basicInfo.address isEqualToString:@""]) {
        self.addressLB.text = basicInfo.address;
    }
    
    if (![basicInfo.insuranceCompany isEqualToString:@""]) {
        self.insuranceCompanyLB.text = basicInfo.insuranceCompany;
    }
    
    
}





@end
