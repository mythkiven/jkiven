//
//  YJCitySelectCell.h
//  CreditPlatform
//
//  Created by yj on 2016/11/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import <UIKit/UIKit.h>

@class LMZXCityModel;

@interface LMZXCityListCell : UITableViewCell
@property (strong, nonatomic)  UILabel *textLB;

@property (nonatomic, copy) NSString *title;
@property (strong, nonatomic)  UIView *topLine;

@property (nonatomic, strong) LMZXCityModel *cityModel;


@end
