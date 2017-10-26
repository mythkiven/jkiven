//
//  PersionRiskloanInfoCell.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBasicRecordCell.h"

static NSString *const PersionRiskloanInfoCellIdentifier = @"PersionRiskloanInfoCell";
@interface PersionRiskloanInfoCell : JBasicRecordCell

@property (strong,nonatomic) PersionRiskInfoDaiKuanModel      *persionRiskInfoDaiKuanModel;

@property (assign,nonatomic) BOOL  isLastCell ;
+ (CGFloat)cellHeight;
@end
