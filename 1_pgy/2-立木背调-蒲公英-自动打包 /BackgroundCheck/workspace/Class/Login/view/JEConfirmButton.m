//
//  JEConfirmButton.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/22.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "JEConfirmButton.h"

@implementation JEConfirmButton

-(instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor*)backgroundColor titleColor:(UIColor*)titleColor borderColor:(UIColor*)borderColor{
    if (self = [super initWithFrame:frame]){
         self.enabled = YES;
        [self setBackgroundColor:backgroundColor];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        self.layer.cornerRadius = 2.0;
        self.layer.masksToBounds = YES;
        [self.layer setBorderWidth:1.0];
        [self.layer setBorderColor:borderColor.CGColor];
         return self;
    }
    return nil;
}

-(void)loadConfigEnable:(BOOL)enbale{
    self.enabled = enbale;
    self.alpha = enbale ? 1.0:0.3; 
    
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self setBackgroundColor:[UIColor  colorWithHexString:@"#39b31b"]];
    [self setTitleColor:RGB_white forState:UIControlStateNormal];
    self.layer.cornerRadius = 2.0;
    self.layer.masksToBounds = YES;
    
}

-(void)setCanClicked:(BOOL)canClicked{
    _canClicked = canClicked;
    if (canClicked) {
        self.enabled = YES;
        self.alpha = 1;
    }else{
        self.enabled = NO;
        self.alpha = 0.3;
    }
}
@end
