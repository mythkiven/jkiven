//
//  JBasicRecordCell.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/12.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBasicRecordCell : UITableViewCell
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
@end
