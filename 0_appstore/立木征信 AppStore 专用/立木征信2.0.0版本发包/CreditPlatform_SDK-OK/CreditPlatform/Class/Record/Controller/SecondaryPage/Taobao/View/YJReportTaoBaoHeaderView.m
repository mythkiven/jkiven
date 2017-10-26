//
//  YJReportTaoBaoHeaderView.m
//  CreditPlatform
//
//  Created by yj on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportTaoBaoHeaderView.h"


@interface YJReportTaoBaoHeaderView ()

/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
/**
 *  身份证号
 */
@property (weak, nonatomic) IBOutlet UILabel *idLB;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLB;

/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nickNameLB;
/**
 *  性别
 */
@property (weak, nonatomic) IBOutlet UILabel *sexLB;
/**
 *  出生日期
 */
@property (weak, nonatomic) IBOutlet UILabel *birthdayLB;
/**
 *  认证渠道
 */
@property (weak, nonatomic) IBOutlet UILabel *authLB;

/**
 *  是否实名认证
 */
@property (weak, nonatomic) IBOutlet UILabel *isRealNameLB;


/**
 *  邮箱
 */
@property (weak, nonatomic) IBOutlet UILabel *emailLB;
/**
 *  绑定手机号
 */
@property (weak, nonatomic) IBOutlet UILabel *phoneLB;
/**
 *  会员等级
 */
@property (weak, nonatomic) IBOutlet UILabel *memberLevelLB;

/**
 *  成长值
 */
@property (weak, nonatomic) IBOutlet UILabel *growPointLB;

/**
 *  信用积分
 */
@property (weak, nonatomic) IBOutlet UILabel *creditPointLB;
/**
 *  好评率
 */
@property (weak, nonatomic) IBOutlet UILabel *goodCommentLB;
/**
 *  安全等级
 */
@property (weak, nonatomic) IBOutlet UILabel *safeLevelLB;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *identityChanneH;

@end
@implementation YJReportTaoBaoHeaderView

+ (id)taoBaoHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YJReportTaoBaoHeaderView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];

    
}

- (void)setTaoBaoBasicInfo:(YJTaoBaoBasicInfo *)taoBaoBasicInfo {
    _taoBaoBasicInfo = taoBaoBasicInfo;
    if (![taoBaoBasicInfo.realName isEqualToString:@""]) {
        self.nameLB.text = taoBaoBasicInfo.realName;
    }
    
    if (![taoBaoBasicInfo.identityNo isEqualToString:@""]) {
        self.idLB.text = taoBaoBasicInfo.identityNo;
    }
    
    if (![taoBaoBasicInfo.username isEqualToString:@""]) {
        self.userNameLB.text = taoBaoBasicInfo.username;
    }
    
    if (![taoBaoBasicInfo.nickName isEqualToString:@""]) {
        self.nickNameLB.text = taoBaoBasicInfo.nickName;
    }
    
    if (![taoBaoBasicInfo.gender isEqualToString:@""]) {
        self.sexLB.text = taoBaoBasicInfo.gender;
    }
    
    if (![taoBaoBasicInfo.birthday isEqualToString:@""]) {
        self.birthdayLB.text = taoBaoBasicInfo.birthday;
    }
    
    if (![taoBaoBasicInfo.identityChannel isEqualToString:@""]) {
        self.authLB.text = taoBaoBasicInfo.identityChannel;
    }
    if ((iPhone5 || iPhone4s  || iPhone6) && [taoBaoBasicInfo.identityStatus isEqualToString:@"已认证"]) {
        self.identityChanneH.constant = 40;
    } else {
        self.identityChanneH.constant = 20;
        
    }
    
    
    if (![taoBaoBasicInfo.identityStatus isEqualToString:@""]) {
        self.isRealNameLB.text = taoBaoBasicInfo.identityStatus;
    }
    
    if (![taoBaoBasicInfo.email isEqualToString:@""]) {
        self.emailLB.text = taoBaoBasicInfo.email;
    }
    
    if (![taoBaoBasicInfo.mobile isEqualToString:@""]) {
        self.phoneLB.text = taoBaoBasicInfo.mobile;
    }
    
    if (![taoBaoBasicInfo.vipLevel isEqualToString:@""]) {
        self.memberLevelLB.text = taoBaoBasicInfo.vipLevel;
    }
    
    if (![taoBaoBasicInfo.growthValue isEqualToString:@""]) {
        self.growPointLB.text = taoBaoBasicInfo.growthValue;
    }
    
    if (![taoBaoBasicInfo.creditScore isEqualToString:@""]) {
        self.creditPointLB.text = taoBaoBasicInfo.creditScore;
    }
    
    if (![taoBaoBasicInfo.favorableRate isEqualToString:@""]) {
        self.goodCommentLB.text = taoBaoBasicInfo.favorableRate;
    }
    
    if (![taoBaoBasicInfo.securityLevel isEqualToString:@""]) {
        self.safeLevelLB.text = taoBaoBasicInfo.securityLevel;
    }
    
    
    

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
