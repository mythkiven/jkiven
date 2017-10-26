//
//  YJIntroContentView.m
//  BackgroundCheck
//
//  Created by yj on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "YJIntroContentView.h"



@interface YJIntroContentView ()

@property (weak, nonatomic) IBOutlet UIView *btnsContainerView;

@end

@implementation YJIntroContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)introContentView{
    return [[[NSBundle mainBundle] loadNibNamed:@"YJIntroContentView" owner:nil options:nil] firstObject];
}


- (void)setType:(NSString *)type{
    _type = [type copy];
    
    if ([type hasPrefix:@"基础"]) {
        UIButton *btn1 = _btnsContainerView.subviews[4];
        btn1.selected = YES;
        UIButton *btn2 = _btnsContainerView.subviews[5];
        btn2.selected = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
}
@end
