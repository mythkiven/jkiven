//
//  YJBaseListViewController.h
//  BackgroundCheck
//
//  Created by yj on 2017/9/19.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJBaseListViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int searchType;
@end
