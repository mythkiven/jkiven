//
//  YJoverdraftView.h
//  CreditPlatform
//
//  Created by yj on 16/10/12.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RechargeBlock)(void);

@interface YJoverdraftView : UIView

@property (nonatomic, copy) RechargeBlock rechargeBlock;
@end
