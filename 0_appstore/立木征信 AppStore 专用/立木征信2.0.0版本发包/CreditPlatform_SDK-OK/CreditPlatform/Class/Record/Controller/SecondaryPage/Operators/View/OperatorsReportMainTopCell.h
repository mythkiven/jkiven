//
//  YJHouseFundView.h
//  CreditPlatform
//
//  Created by yj on 16/7/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OperationModel,OperationNewModel;
// 顶部xib
@interface OperatorsReportMainTopCell : UIView
+ (id)houseFundView;

@property (strong,nonatomic) OperationModel *model  ;
@property (strong,nonatomic) OperationNewModel *modelNew ;

@end
