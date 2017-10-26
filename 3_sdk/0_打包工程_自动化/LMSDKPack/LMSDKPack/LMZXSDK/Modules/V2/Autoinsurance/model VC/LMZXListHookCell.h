//
//  CitySelectCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CitySelectModel;
@class LMZXListHookModel;
typedef void(^ListHookTapBlock)(LMZXListHookModel *model);

@interface LMZXListHookCell : UITableViewCell

@property (copy,nonatomic) LMZXListHookModel *listHookModel;
@property (copy,nonatomic) ListHookTapBlock  tapListHookCell;
@property (strong,nonatomic) UIImage      *imgData;
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview;
@end
