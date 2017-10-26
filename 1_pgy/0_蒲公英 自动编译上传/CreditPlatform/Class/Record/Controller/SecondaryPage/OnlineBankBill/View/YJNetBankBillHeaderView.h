//
//  YJNetBankBillHeaderView.h
//  CreditPlatform
//
//  Created by yj on 2016/11/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJEBankBillModel;

@interface YJNetBankBillHeaderView : UIView
+ (id)netBankBillHeaderView ;

@property (nonatomic, assign) int index;
@property (nonatomic, strong) YJEBankBillModel *eBankBillModel;


@end
