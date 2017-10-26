//
//  SettingTopView.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "SettingTopView.h"

@interface SettingTopView ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UIImageView *authImgView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;



@end

@implementation SettingTopView
+ (instancetype)loginHeaderView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"SettingTopView" owner:nil options:nil] firstObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
//    [self.bgImgView setImage:[UIImage imageNamed:@"Me_topImg"]];
    self.iconBtn.layer.cornerRadius = 50;
    self.iconBtn.clipsToBounds = YES;
    self.iconBtn.layer.borderWidth = 3.0f;//边框宽度
    self.iconBtn.layer.borderColor = RGBA(255, 255, 255, 0.5).CGColor;//边框颜色
    
    
}

- (IBAction)clickedIconBtn:(UIButton *)sender {
    if (self.changeImgBlock) {
        self.changeImgBlock(sender);
    }
}
- (IBAction)clickedLoginBtn:(UIButton *)sender {
    if (kUserManagerTool.isLogin) {
        return;
    }
    [self clickedIconBtn:self.iconBtn];
}

- (void)setIcon:(UIImage *)icon {
    [_iconBtn setImage:icon forState:UIControlStateNormal];
}

-(void)setPhone:(NSString *)phone{
    if (phone.length) {
        NSMutableString *a = [[NSMutableString  alloc] initWithString:phone];
        [a replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        [_loginBtn setTitle:a forState:(UIControlStateNormal)];
        
    }else{
         [_loginBtn setTitle:@"登录/注册" forState:(UIControlStateNormal)];
    }
    
}

-(void)setStatus:(NSString *)status{
    if (kUserManagerTool.isLogin) {
        _authImgView.hidden = NO;
    } else {
        _authImgView.hidden = YES;
    }
    
    if ([status isEqualToString:@"00"]) {//正在审核
        _authImgView.image = [UIImage imageNamed:@"me_auth_ing"];
        
    } else if ([status isEqualToString:@"20"]) {//成功
        _authImgView.image = [UIImage imageNamed:@"me_auth_ok"];
    } else if ([status isEqualToString:@"99"]) {//审核失败
        _authImgView.image = [UIImage imageNamed:@"me_auth_fail"];
    } else {//未认证
      _authImgView.image = [UIImage imageNamed:@"me_auth_no"];
    }
    
}

/**
 *  返回不带****的号码
 *
 *  @return
 */
- (NSString *)getPhoneNum:(NSString *)str {
    NSString *phoneStr = nil;
    if (str.length<10) {
        return str;
    }
    if ([[str substringWithRange:NSMakeRange(3, 4)] isEqualToString:@"****"]) {
        phoneStr = str;
    } else {
        phoneStr = str;
    }
    return phoneStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
