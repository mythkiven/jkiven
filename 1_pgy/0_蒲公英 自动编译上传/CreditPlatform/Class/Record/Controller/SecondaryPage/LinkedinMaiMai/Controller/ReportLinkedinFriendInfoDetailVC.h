//
//  YJReportLinkedinFriendInfoVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMMainModel.h"
#import "LinkedMainModel.h"
//好友信息
@interface ReportLinkedinFriendInfoDetailVC : UITableViewController
@property (nonatomic,strong) id data;
@property (nonatomic, assign) SearchItemType  searchType;
@end
