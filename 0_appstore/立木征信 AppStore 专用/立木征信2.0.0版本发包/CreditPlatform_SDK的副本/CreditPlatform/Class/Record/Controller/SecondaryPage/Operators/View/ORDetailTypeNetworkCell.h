//
//  ORDetailTypeNetworkCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJOperatorBaseCell.h"
@class OperationNetworkSix;
// 网络数据

@interface ORDetailTypeNetworkCell : YJOperatorBaseCell
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview;
@property (strong,nonatomic) OperationNetworkSix *model  ;
@end
