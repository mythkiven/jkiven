//
//  YJResultViewController.h
//  CreditPlatform
//
//  Created by yj on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJResultViewController : UITableViewController

/**
 *  搜索类型
 */
@property (nonatomic, strong) NSString *searchType;
/**
 *  搜索返回的结果
 */
@property (nonatomic, strong) NSArray *searchDataArray;

@end
