//
//  LMZXSettingCell.m
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/2/16.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXSettingCell.h"

@implementation LMZXSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.colorView.layer.borderWidth = 0.5;
    self.colorView.layer.cornerRadius = 2;
    self.colorView.layer.borderColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0].CGColor;
    self.colorView.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
