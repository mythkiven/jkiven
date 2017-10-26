//
//  YJHomeCell.m
//  CreditPlatform
//
//  Created by yj on 16/8/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "SettingCell.h"

@interface SettingCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLB;

@end

@implementation SettingCell

+ (instancetype)homeCell {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconView.contentMode = UIViewContentModeCenter;

}

- (void)setupItemCellIcon:(NSString *)icon title:(NSString *)title  {
    self.icon = icon;
    self.title = title;
    
}

- (void)setIcon:(NSString *)icon {
    _icon = icon;
    
    self.iconView.image =[[UIImage imageNamed:icon] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLB.text = title;
}

@end
