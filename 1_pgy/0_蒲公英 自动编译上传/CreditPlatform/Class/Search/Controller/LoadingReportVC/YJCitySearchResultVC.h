//
//  YJCitySearchResultVC.h
//  CreditPlatform
//
//  Created by yj on 2016/12/14.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectCity)(NSString *);

@interface YJCitySearchResultVC : UITableViewController

@property (strong,nonatomic) NSMutableArray *searchList;

@property (nonatomic, copy) SelectCity selectCity;

@end
