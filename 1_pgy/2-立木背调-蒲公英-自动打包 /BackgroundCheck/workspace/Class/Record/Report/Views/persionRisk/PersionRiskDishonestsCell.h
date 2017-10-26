//
//  PersionRiskDishonestsCell.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBasicRecordCell.h"

static NSString *const PersionRiskDishonestsCellIdentifier = @"PersionRiskDishonestsCell";
@interface PersionRiskDishonestsCell : JBasicRecordCell

@property (strong,nonatomic) PersionRiskInfoShiXinModel      *persionRiskInfoShiXinModel;
@property (assign,nonatomic) BOOL  isLastCell ;

+ (CGFloat)cellHeight:(PersionRiskInfoShiXinModel *)model;

@end
