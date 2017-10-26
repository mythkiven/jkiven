//
//  YJCarInsuranceOtherInfoCell.m
//  CreditPlatform
//
//  Created by yj on 2016/11/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCarInsurancePolicyInfoCell.h"
#import "YJCarInsuranceModel.h"

@interface YJCarInsurancePolicyInfoCell ()


@end
@implementation YJCarInsurancePolicyInfoCell




#pragma mark--创建UI

- (void)creatUI {

            
    _leftTitles = @[@"保单号",@"保险期限",@"总保额(元)",@"总保费(元)",@"投保人",@"被保险人",@"被保险人\n身份证号",@"已缴保费(元)",@"欠缴保费(元)",@"缴费方式",@"缴费日期"];
    
    _leftLbWidth = 90;

    
    _rightLbWidth = SCREEN_WIDTH - kMargin_15 * 3 - _leftLbWidth;
    
    [self addSubViewToCell];
    
    
}



#pragma mark--保单
- (void)setPolicyDetails:(YJCarInsurancePolicyDetails *)policyDetails {
    _policyDetails = policyDetails;
    
    MYLog(@"----------保单");
    
    [self creatUI];
    
    [self loadPolicyInfo];
    
    [self layoutSubview];
}

#pragma mark--加载数据

/**
 保单信息
 */
- (void)loadPolicyInfo {
    
    MYLog(@"==================loadPolicyInfo");
    
    if (_rightLbArray.count == 0) {
        return;
    }
    // 保单号
    if (![self.policyDetails.policyNo isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[0];
        lb.text = self.policyDetails.policyNo;
    }
    // 保险期限
    if (![self.policyDetails.effectivePeriodStart  isEqualToString:@""] || ![self.policyDetails.effectivePeriodEnd  isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[1];
        lb.text = [NSString stringWithFormat:@"%@至%@",self.policyDetails.effectivePeriodStart ,self.policyDetails.effectivePeriodEnd ];
    }
    // 总保额
    if (![self.policyDetails.insuredAmt isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[2];
        lb.text = self.policyDetails.insuredAmt;
    }
    // 总保费
    if (![self.policyDetails.premiumAmt isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[3];
        lb.text = self.policyDetails.premiumAmt;
    }
    // 投保人
    if (![self.policyDetails.insurer isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[4];
        lb.text = self.policyDetails.insurer;
    }
    // 被保险人
    if (![self.policyDetails.insured isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[5];
        lb.text = self.policyDetails.insured;
    }
    // 被保险人身份号
    if (![self.policyDetails.insuredIdentityNo isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[6];
        lb.text = self.policyDetails.insuredIdentityNo;
    }
    // 已缴保费
    if (![self.policyDetails.paidAmt isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[7];
        lb.text = self.policyDetails.paidAmt;
    }
    // 欠缴保费
    if (![self.policyDetails.unPaidAmt isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[8];
        lb.text = self.policyDetails.unPaidAmt;
    }
    // 缴费方式
    if (![self.policyDetails.payType  isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[9];
        lb.text = self.policyDetails.payType ;
    }
    // 缴费日期
    if (![self.policyDetails.payDate isEqualToString:@""]) {
        UILabel *lb = _rightLbArray[10];
        lb.text = self.policyDetails.payDate;
    }
    
    
    
    
}



@end
