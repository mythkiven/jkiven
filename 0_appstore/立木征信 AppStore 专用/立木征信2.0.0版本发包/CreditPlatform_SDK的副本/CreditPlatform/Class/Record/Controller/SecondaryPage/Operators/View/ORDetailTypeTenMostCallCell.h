//
//  ORDetailTypeTenMostCallCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJOperatorBaseCell.h"
@class OperationCallTen,OperationNewCallTen;
// 前10通话

@interface ORDetailTypeTenMostCallCell : YJOperatorBaseCell
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview;
@property (strong,nonatomic) OperationCallTen *model  ;
@property (strong,nonatomic) OperationNewCallTen *modelNew  ;

@end
