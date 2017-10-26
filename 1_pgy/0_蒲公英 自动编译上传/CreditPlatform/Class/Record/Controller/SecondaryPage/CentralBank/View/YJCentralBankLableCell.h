//
//  YJCentralBankLableCell.h
//  CreditPlatform
//
//  Created by yj on 16/8/22.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJCentralBankLableCell : UITableViewCell

@property (nonatomic, copy) NSString *content;

+ (instancetype)centralBankLableCell:(UITableView *)tableview ;
@end
