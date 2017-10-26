//
//  YJSocialSecurityView.m
//  CreditPlatform
//
//  Created by yj on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJSocialSecurityView.h"
#import "YJSocialSecurityModel.h"

@interface YJSocialSecurityView ()
/*********基本信息********/
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLB;

/**
 *  身份证号
 */
@property (weak, nonatomic) IBOutlet UILabel *idLB;
/**
 *  公司名称
 */
@property (weak, nonatomic) IBOutlet UILabel *companyLB;
/**
 *  开户日期
 */
@property (weak, nonatomic) IBOutlet UILabel *openAccountDateLB;
/**
 *  累计缴纳月数
 */
@property (weak, nonatomic) IBOutlet UILabel *totalMonthPayLB;
/**
 *  账户状态
 */
@property (weak, nonatomic) IBOutlet UILabel *accountStateLB;



@end
@implementation YJSocialSecurityView
+ (instancetype)socialSecurityView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YJSocialSecurityView" owner:nil options:nil] firstObject];
}



- (void)setSocialSecurityModel:(YJSocialSecurityModel *)socialSecurityModel {
    _socialSecurityModel = socialSecurityModel;
    
    if (socialSecurityModel.name) {
        self.nameLB.text = socialSecurityModel.name;
    }
    if (socialSecurityModel.identityNo) {
        self.idLB.text = socialSecurityModel.identityNo;
    }
    
    if (socialSecurityModel.corpName) {
        self.companyLB.text = socialSecurityModel.corpName;
    }
    
    if (socialSecurityModel.openDate) {
        self.openAccountDateLB.text = socialSecurityModel.openDate;
    }
    
    if (socialSecurityModel.accStatus) {
        self.accountStateLB.text = socialSecurityModel.accStatus;
    }

    
}




@end
