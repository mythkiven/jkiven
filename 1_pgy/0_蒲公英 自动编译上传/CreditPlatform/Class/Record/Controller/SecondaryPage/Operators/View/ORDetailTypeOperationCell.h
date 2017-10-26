//
//  ORDetailTypeOperationCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJOperatorBaseCell.h"
@class OperationBanliSix;
// 办理业务
@interface ORDetailTypeOperationCell : YJOperatorBaseCell
@property (strong,nonatomic)  OperationBanliSix     *model;
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview;
@end
