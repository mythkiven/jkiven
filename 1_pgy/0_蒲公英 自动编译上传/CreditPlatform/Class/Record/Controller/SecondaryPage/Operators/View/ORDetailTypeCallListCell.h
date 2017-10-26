//
//  ORDetailTypeCallListCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJOperatorBaseCell.h"
@class OperationCallSix;
// 通话记录

@interface ORDetailTypeCallListCell : YJOperatorBaseCell
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview;
@property (strong,nonatomic) OperationCallSix *model  ;
@end
