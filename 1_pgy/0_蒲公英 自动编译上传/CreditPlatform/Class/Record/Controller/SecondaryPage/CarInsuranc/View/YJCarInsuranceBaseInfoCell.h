//
//  YJCarInsuranceOtherInfoCell.h
//  CreditPlatform
//
//  Created by yj on 2016/11/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YJCarInsuranceBaseInfoCell : UITableViewCell
{
    NSMutableArray *_leftLbArray;
    NSMutableArray *_rightLbArray;
    
    NSArray *_leftTitles;
    
    CGFloat _leftLbWidth;
    CGFloat _rightLbWidth;
    
    UIView *_lastView; // 上一个控件
    UIView  *_topLine;
    
    UIView  *_bottomLine;
    
}
- (void)addSubViewToCell ;


- (void)layoutSubview ;


@end
