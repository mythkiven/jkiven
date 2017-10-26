//
//  YJCitySearchResultVC.h
//  CreditPlatform
//
//  Created by yj on 2016/12/14.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LMZXCitySearchResultVC;
@protocol LMZXCitySearchResultVCDelegate <NSObject>

- (void)citySearchResultVC:(LMZXCitySearchResultVC *)vc didSelectCity:(NSString *)cityName;

@end

typedef void(^SelectCity)(NSString *);

@interface LMZXCitySearchResultVC : UIViewController
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *inputValue;

@property (nonatomic, strong) NSArray *matchValues;

@property (strong,nonatomic) NSMutableArray *searchList;

@property (nonatomic, weak) id delegate;


@end
