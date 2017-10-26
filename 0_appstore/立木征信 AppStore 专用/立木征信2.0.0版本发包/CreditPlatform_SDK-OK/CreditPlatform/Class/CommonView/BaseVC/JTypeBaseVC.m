//
//  JTypeBaseVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "JTypeBaseVC.h"

@interface JTypeBaseVC ()

@end

@implementation JTypeBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.recodeType isEqualToString:kBizType_housefund]) {
        _searchItemType = SearchItemTypeHousingFund;
        
    } else if ([self.recodeType isEqualToString:kBizType_socialsecurity]) {
        _searchItemType = SearchItemTypeSocialSecurity;
        
        
    } else if ([self.recodeType isEqualToString:kBizType_mobile]) {
        _searchItemType = SearchItemTypeOperators;
        
    } else if ([self.recodeType isEqualToString:kBizType_jd]) {
        _searchItemType = SearchItemTypeE_Commerce;
        
    } else if ([self.recodeType isEqualToString:kBizType_credit]) {
        _searchItemType = SearchItemTypeCentralBank;
        
        
    } else if ([self.recodeType isEqualToString:kBizType_education]) {
        _searchItemType = SearchItemTypeEducation;
        
    } else if ([self.recodeType isEqualToString:kBizType_taobao]) {
        _searchItemType = SearchItemTypeTaoBao;
        
    } else if ([self.recodeType isEqualToString:kBizType_linkedin]) {
        _searchItemType = SearchItemTypeLinkedin;
        
    } else if ([self.recodeType isEqualToString:kBizType_maimai]) {
        _searchItemType = SearchItemTypeMaimai;
        
    } else if ([self.recodeType isEqualToString:kBizType_bill]) {
        _searchItemType = SearchItemTypeCreditCardBill;
        
    } else if ([self.recodeType isEqualToString:kBizType_shixin]) {
        _searchItemType = SearchItemTypeLostCredit;
        
    }
    // 车险
    
    //企业信用
    
    //网银流水
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
