//
//  YJHouseFundView.m
//  CreditPlatform
//
//  Created by yj on 16/7/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJHouseFundView.h"
#import "YJHouseFundModel.h"
@interface YJHouseFundView ()
/*********基本信息********/
/**
*  姓名
*/
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
/**
 *  公积金账号
 */
@property (weak, nonatomic) IBOutlet UILabel *houseFundLB;
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
 *  末次缴存日期
 */
@property (weak, nonatomic) IBOutlet UILabel *lastPayDateLB;
/**
 *  账户状态
 */
@property (weak, nonatomic) IBOutlet UILabel *accountStateLB;
/**
 *  地区
 */
@property (weak, nonatomic) IBOutlet UILabel *regionLB;

/********* 存缴信息 ********/

/**
 *  余额
 */
@property (weak, nonatomic) IBOutlet UILabel *balanceLB;
/**
 *  月缴存
 */
@property (weak, nonatomic) IBOutlet UILabel *monthPayLB;
/**
 *  存缴基数
 */
@property (weak, nonatomic) IBOutlet UILabel *payBaseLB;


@end

@implementation YJHouseFundView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setHouseFundModel:(YJHouseFundModel *)houseFundModel {
    _houseFundModel = houseFundModel;
    
    
    if (houseFundModel.name) {
        self.nameLB.text = houseFundModel.name;
    }
    if (houseFundModel.acctNo) {
        self.houseFundLB.text = houseFundModel.acctNo;
    }
    if (houseFundModel.identityNo) {
        self.idLB.text = houseFundModel.identityNo;
    }
    if (houseFundModel.corpName) {
        self.companyLB.text = houseFundModel.corpName;
    }
    
    
    
    
    if (houseFundModel.openDate) {
        self.openAccountDateLB.text = houseFundModel.openDate;
    }
    if (houseFundModel.lastDepostDate) {
        self.lastPayDateLB.text = houseFundModel.lastDepostDate;
    }
    if (houseFundModel.accStatus) {
        self.accountStateLB.text = houseFundModel.accStatus;
    }
    if (houseFundModel.area) {
        self.regionLB.text = houseFundModel.area;
    }
    
    if (houseFundModel.bal) {
        self.balanceLB.text = [NSString stringWithFormat:@"%@元",houseFundModel.bal];
    }
    if (houseFundModel.monthlyDeposit) {
        self.monthPayLB.text = houseFundModel.monthlyDeposit;
    }
    if (houseFundModel.baseDeposit) {
        self.payBaseLB.text = [NSString stringWithFormat:@"%@元",houseFundModel.baseDeposit];
    }
    
    
    
    
    
}

+ (id)houseFundView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YJHouseFundView" owner:nil options:nil] firstObject];
}

@end
