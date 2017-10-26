//
//  PersionRiskCourtLawSuitCell.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//



// 法院诉讼
#import <UIKit/UIKit.h>

#import "JBasicRecordCell.h"


static NSString *const PersionRiskCourtLawSuitCellIdentifier = @"PersionRiskCourtLawSuitCell";

@interface PersionRiskCourtLawSuitCell : JBasicRecordCell

@property (assign,nonatomic) BOOL  isLastCell ;

@property (strong,nonatomic) PersionRiskInfoFaYuanModel      *persionRiskInfoFaYuanModel;

+ (CGFloat)cellHeight:(PersionRiskInfoFaYuanModel *)model;


@end
