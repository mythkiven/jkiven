//
//  YJHomeCollectionViewCell.h
//  CreditPlatform
//
//  Created by yj on 16/10/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJHomeItemModel.h"



typedef void(^GuideBlock)();
typedef void(^QuickSearchBlock)();

@interface YJHomeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) YJHomeItemModel *homeItemModel;

@property (nonatomic, copy) GuideBlock guideBlock;

@property (nonatomic, copy) QuickSearchBlock quickSearchBlock;



@end
