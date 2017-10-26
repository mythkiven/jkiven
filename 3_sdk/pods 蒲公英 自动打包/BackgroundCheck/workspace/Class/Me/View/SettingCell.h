//
//  YJHomeCell.h
//  CreditPlatform
//
//  Created by yj on 16/8/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UIView


/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger tag;

+ (instancetype)homeCell;
- (void)setupItemCellIcon:(NSString *)icon title:(NSString *)title ;

@end
