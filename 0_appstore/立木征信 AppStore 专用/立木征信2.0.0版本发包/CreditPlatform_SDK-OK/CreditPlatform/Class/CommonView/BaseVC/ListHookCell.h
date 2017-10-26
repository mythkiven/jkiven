//
//  CitySelectCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/7/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CitySelectModel;
@class ListHookModel;
typedef void(^ListHookTapBlock)(ListHookModel *model);

@interface ListHookCell : UITableViewCell

@property (copy,nonatomic) ListHookModel *listHookModel;
@property (copy,nonatomic) ListHookTapBlock  tapListHookCell;

+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview;
@end
