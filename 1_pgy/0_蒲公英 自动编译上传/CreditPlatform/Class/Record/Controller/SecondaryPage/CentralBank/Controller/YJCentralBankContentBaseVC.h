//
//  YJCentralBankContentBaseVC.h
//  CreditPlatform
//
//  Created by yj on 16/8/22.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJCentralBankContentBaseVC : UITableViewController
@property (nonatomic, strong) NSArray *dataArray;
- (void)setupFooterNODataView;
@end
