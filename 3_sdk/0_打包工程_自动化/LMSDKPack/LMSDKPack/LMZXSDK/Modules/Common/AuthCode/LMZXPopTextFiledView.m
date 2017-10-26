//
//  JPopTextFiledView.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXPopTextFiledView.h"
#import "UIImage+LMZXTint.h"
#import "LMZXFactoryView.h"
#import "NSString+LMZXCommon.h"

//#define LM_SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
//#define LM_SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define lmzxiPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define LM_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define LM_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define LM_iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//#define LM_RGB(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]




@interface LMZXPopTextFiledView ()

@property (strong, nonatomic)  UILabel *markTitle;
@property (strong, nonatomic)  UILabel *title;
@property (strong, nonatomic)  UIButton *cancle;
@property (strong, nonatomic)  UIButton *sureBtn;


@end

@implementation LMZXPopTextFiledView

# pragma mark  - 创建 UI
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self show];
        self.backgroundColor = LM_RGB(245, 245, 245);
//        [self addSubview:self.backView];
        [self addSubview:self.markTitle];
        [self addSubview:self.title];
        [self addSubview:self.textfile];
        [self addSubview:self.sureBtn];
        [self addSubview:self.cancle];
        
    }
    return self;
 
}
-(void)layoutSubviews{ // 33 11 23  20 //
    
    if (self.sendMsgType == LMZXCommonSendMsgTypeNormal ) { // 只有一条提示语
        self.markTitle.frame    = CGRectMake(0, 0, self.frame.size.width, 1);
        self.title.frame        = CGRectMake(0,28, self.frame.size.width, 15);
        self.textfile.frame     = CGRectMake(20, CGRectGetMaxY(_title.frame)+26, self.frame.size.width-40, 45);
        self.sureBtn.frame      = CGRectMake(20, CGRectGetMaxY(_textfile.frame)+15, self.frame.size.width-40, 45);
        self.cancle.frame       = CGRectMake(self.frame.size.width-35, 5, 30, 30);
    }else{
        self.markTitle.frame    = CGRectMake(0, 19, self.frame.size.width, 15);
        self.title.frame        = CGRectMake(0, CGRectGetMaxY(_markTitle.frame)+12, self.frame.size.width, 15);
        self.textfile.frame     = CGRectMake(20, CGRectGetMaxY(_title.frame)+14, self.frame.size.width-40, 45);
        self.sureBtn.frame      = CGRectMake(20, CGRectGetMaxY(_textfile.frame)+14, self.frame.size.width-40, 41);
        self.cancle.frame       = CGRectMake(self.frame.size.width-35, 5, 30, 30);
    }
    
    
    
    
}

-(void)drawRect:(CGRect)rect{
    self.markTitle.font =LM_Font(15);
    self.title.font = LM_Font(15);
    switch (self.sendMsgType) {
        case LMZXCommonSendMsgTypeNormal:{// 通用
            self.title.text = @"短信验证码已发送";
            self.markTitle.text = @"";
            break;
        }case LMZXCommonSendMsgTypePhone:{ // 运营商   @mobile@
            
            if ([self.mobileSmsMsg isEqualToString:@"发送CXXD至10001,获取验证码"]) {
                NSString *phone = [NSString securtMobileNumber:self.title.text];
                self.markTitle.text = [NSString stringWithFormat:@"请用%@手机",phone];
                self.title.text = @"发送CXXD至10001,获取验证码";
                self.title.adjustsFontSizeToFitWidth =YES;
                
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.title.text];
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2,10)];
                
                self.title.attributedText = str;
            }else{
                self.markTitle.text = self.mobileSmsMsg?self.mobileSmsMsg:@"短信验证码已经发送至";
                self.title.text = [NSString securtMobileNumber:self.title.text];
            }
            
            break;
        }
        case LMZXCommonSendMsgTypeJLDX:{// 吉林电信
            NSString *phone = [NSString securtMobileNumber:self.title.text];
            self.markTitle.text = [NSString stringWithFormat:@"请用%@手机",phone];
            self.title.text = self.mobileSmsMsg?self.mobileSmsMsg:@"发送CXXD至10001,获取验证码";
            self.title.adjustsFontSizeToFitWidth =YES;
            
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.title.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2,10)];
//            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30.0] range:NSMakeRange(0, 5)];
            
            self.title.attributedText = str;
            
            break;
        }
        case LMZXCommonSendMsgTypeQQCredit:{//  QQ 独立密码
            self.markTitle.text = @"提示";
            self.title.text = @"请输入独立密码";
            
            break;
        }default:
            break;
    }
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [self setNeedsLayout];
}
// 设置主题字
-(void)setTxt:(NSString *)txt{
    _txt= txt;
    _title.text = txt;
}

#pragma mark - 交互

# pragma mark 点击确认
- (void)clicked:(UIButton *)sender {
    
    [self endEditing:YES];
    
    if (!self.textfile|!self.textfile.text|!self.textfile.text.length) {
        
        CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        shake.fromValue = [NSNumber numberWithFloat:-5];
        shake.toValue = [NSNumber numberWithFloat:5];
        shake.duration = 0.1;//执行时间
        shake.autoreverses = YES; //是否重复
        shake.repeatCount = 2;//次数
        [self.layer addAnimation:shake forKey:@"shakeAnimation"];
        
        return;
    }
    
    NSString *str = self.textfile.text;
    str = [str cutAllSpace];
    if ([str isEqualToString:@""]|[str isEqualToString:@" "]|[str isEqualToString:@"  "]|[str isEqualToString:@"   "]|[str isEqualToString:@"    "] ) {
        CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        shake.fromValue = [NSNumber numberWithFloat:-5];
        shake.toValue = [NSNumber numberWithFloat:5];
        shake.duration = 0.1;//执行时间
        shake.autoreverses = YES; //是否重复
        shake.repeatCount = 2;//次数
        [self.layer addAnimation:shake forKey:@"shakeAnimation"];
        
        return;
    }
    
    [self endEditing:YES];
    [self performSelector:@selector(sendInfo) withObject:nil afterDelay:0.5];
   
}
// 回调
-(void)sendInfo{
    if (self.clickedBlock) {
        [self hide];
        self.clickedBlock([self.textfile.text cutAllSpace]);
    }
}


# pragma mark 点击取消
-(void)clickedCancle{
    [self endEditing:YES];
    if (self.CancleBlock) {
        [self hide];
        self.CancleBlock();
    }
}

# pragma mark - 其他

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

# pragma mark - 展示隐藏
#pragma mark show
- (void)show {
    
    __block typeof(self) sself =self;
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat spaceH=0;
        if (LM_iPhone5) {
            spaceH = 80-64+64; // ios11修改
        } else if (LM_iPhone6) {
            spaceH = 60-64+64; // ios11修改
        }else if (LM_iPhone6P) {
            spaceH = 60-64+64; // ios11修改
        }
        sself.frame = CGRectMake((LM_SCREEN_WIDTH - lmzxJPWIDTH)/2, (LM_SCREEN_HEIGHT - lmzxJPHEIGHT)/2 - spaceH, lmzxJPWIDTH, lmzxJPHEIGHT);
        
    }];
    
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
//    animation.delegate = self;
    animation.values = @[@(M_PI/64),@(-M_PI/64),@(M_PI/64),@(0)];
    animation.duration = 0.5;
    [animation setKeyPath:@"transform.rotation"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"shake"];
}
#pragma mark hide
- (void)hide {
    [UIView animateWithDuration:0.25 animations:^{
//        self.backView.alpha = 0;
        [self setFrame:CGRectMake((LM_SCREEN_WIDTH - lmzxJPWIDTH)/2, LM_SCREEN_HEIGHT, lmzxJPWIDTH, lmzxJPHEIGHT)];
    } completion:^(BOOL finished) {
//        [self.backView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}


#pragma mark - 创建View
-(UILabel*)title{
    if (!_title) {
        _title = [LMZXFactoryView JlabelWithSuper:nil Color:[UIColor blackColor] Font:23.0 Alignment:1 Text:@"--"];
    }
    return _title;
}
-(UILabel*)markTitle{
    if (!_markTitle) {
        _markTitle = [LMZXFactoryView JlabelWithSuper:nil Color:[UIColor blackColor] Font:13.0 Alignment:1 Text:@"短信验证码已发送"];
    }
    return _markTitle;
}
-(LMZXSMSTextFiled*)textfile{
    if (!_textfile) {
        _textfile = [LMZXFactoryView JSMSTextFieldWithSuper:nil Color:[UIColor blackColor] Font:15 Alignment:0 PlaceHold:@"请输入验证码"];
        _textfile.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textfile.layer.borderColor= LM_RGB(153, 153, 153).CGColor;
        _textfile.layer.borderWidth= 0.5f;
        _textfile.backgroundColor = [UIColor whiteColor];
    }
    return _textfile;
}
-(UIButton*)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [LMZXFactoryView JBtnWithBgColor:LM_RGB(57, 179, 27) Font:18 Alignment:1 textColor:[UIColor whiteColor] title:@"确定"];
        if ([LMZXSDK shared].lmzxSubmitBtnColor) {
            [_sureBtn setBackgroundColor:[LMZXSDK shared].lmzxSubmitBtnColor];
        }
        if ([LMZXSDK shared].lmzxSubmitBtnTitleColor) {
            [_sureBtn setTitleColor:[LMZXSDK shared].lmzxSubmitBtnTitleColor forState:UIControlStateNormal];
        }
        
        
        _sureBtn.layer.cornerRadius = 2;
        _sureBtn.layer.masksToBounds =YES;
        [_sureBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

-(UIButton*)cancle{
    if (!_cancle) {
//        _cancle = [LMZXFactoryView JBtnWithBgColor:[UIColor clearColor] Font:18 Alignment:1 [UIColor whiteColor] title:@""  image:@"close_JPopTextFiledView" backImg:@""];
        

        _cancle = [LMZXFactoryView YJ_BtnWithBgColor:[UIColor clearColor] Font:18 Alignment:1 textColor:[UIColor whiteColor] title:@"" image:[UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_close"] backImg:nil];

        


        
//        _cancle.layer.cornerRadius = 2;
//        _cancle.layer.masksToBounds =YES;
        [_cancle addTarget:self action:@selector(clickedCancle) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancle;
}


@end
