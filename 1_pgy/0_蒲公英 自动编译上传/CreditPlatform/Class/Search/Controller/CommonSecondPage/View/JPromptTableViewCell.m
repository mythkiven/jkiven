//
//  PromptTableViewCell.m
//
//  Created by xinstar on 16/5/26.
//  Copyright © 2016年 xinstar1. All rights reserved.
//

#import "JPromptTableViewCell.h"

@implementation JPromptTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, SCREEN_WIDTH-65, self.frame.size.height)];
    self.emailLabel.textColor = [UIColor lightGrayColor];
    //self.emailLabel.backgroundColor =RGB_red;
    [self addSubview:self.emailLabel];
    self.backgroundColor = RGB_grayBar;
    self.alpha = 0.8;
    self.contentView.backgroundColor = RGB_grayBar;
    self.contentView.alpha = 0.8;
    
}
- (IBAction)tapCell:(UIButton *)sender {
    MYLog(@"");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
