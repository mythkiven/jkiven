//
//  ORDetailTypeMessageCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJOperatorBaseCell.h"
@class OperationMessageSix;
// 短信

@interface ORDetailTypeMessageCell : YJOperatorBaseCell
@property (strong,nonatomic) OperationMessageSix *model  ;
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview;
@end
