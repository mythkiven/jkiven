//
//  JBasicRecordCell.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/12.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "JBasicRecordCell.h"

@implementation JBasicRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    if (value.length<10) {
        return 15;
    }
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    return sizeToFit.height;
}
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    if (value.length<10) {
        return 15;
    }
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    return sizeToFit.height;
}

@end
