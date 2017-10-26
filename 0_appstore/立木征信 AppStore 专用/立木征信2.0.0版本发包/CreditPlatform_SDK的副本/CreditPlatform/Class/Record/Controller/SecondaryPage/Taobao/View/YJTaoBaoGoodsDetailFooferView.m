//
//  YJTaoBaoGoodsDetailFooferView.m
//  CreditPlatform
//
//  Created by yj on 16/10/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTaoBaoGoodsDetailFooferView.h"

@interface YJTaoBaoGoodsDetailFooferView ()
@property (weak, nonatomic) IBOutlet UILabel *deliverTypeLB;
@property (weak, nonatomic) IBOutlet UILabel *deliverCompanyLB;

@property (weak, nonatomic) IBOutlet UILabel *deliverIdLB;

@end

@implementation YJTaoBaoGoodsDetailFooferView

+ (instancetype)taoBaoGoodsDetailFooferView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"YJTaoBaoGoodsDetailFooferView" owner:nil options:nil] firstObject];

}

- (void)setLogisticsInfo:(YJTaoBaoLogisticsInfo *)logisticsInfo {
    _logisticsInfo = logisticsInfo;
    
    if (![logisticsInfo.deliverType isEqualToString:@""]) {
        self.deliverTypeLB.text = logisticsInfo.deliverType;
    }
    
    if (![logisticsInfo.deliverId isEqualToString:@""]) {
        self.deliverIdLB.text = logisticsInfo.deliverId;
    }
    
    if (![logisticsInfo.deliverCompany isEqualToString:@""]) {
        self.deliverCompanyLB.text = logisticsInfo.deliverCompany;
    }
    
}

@end
