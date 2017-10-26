//
//  YJSearchResultViewController.h
//  BackgroundCheck
//
//  Created by yj on 2017/9/19.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJSearchResultViewController : UITableViewController
/**
 *  搜索类型
 */
@property (nonatomic, assign) int searchType;

/**
 *  搜索返回的结果
 */
@property (nonatomic, strong) NSMutableArray *searchDataArray;

@end
