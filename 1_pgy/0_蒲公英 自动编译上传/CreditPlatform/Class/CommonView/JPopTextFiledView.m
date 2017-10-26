//
//  JPopTextFiledView.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "JPopTextFiledView.h"



@interface JPopTextFiledView ()

@property (strong, nonatomic)  UILabel *markTitle;
@property (strong, nonatomic)  UILabel *title;
@property (strong, nonatomic)  UIButton *cancle;
@property (strong, nonatomic)  UIButton *sureBtn;


@end

@implementation JPopTextFiledView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self show];
        self.backgroundColor = RGB_pageBackground;
//        [self addSubview:self.backView];
        [self addSubview:self.markTitle];
        [self addSubview:self.title];
        [self addSubview:self.textfile];
        [self addSubview:self.sureBtn];
        [self addSubview:self.cancle];
        
    }
    return self;
 
}
-(void)layoutSubviews{
    
    self.markTitle.frame =CGRectMake(0, 20, self.width, 13);
    self.title.frame = CGRectMake(0, CGRectGetMaxY(_markTitle.frame)+11, self.width, 23);
    self.textfile.frame =CGRectMake(20, CGRectGetMaxY(_title.frame)+20, self.width-40, 45);
    self.sureBtn.frame =CGRectMake(20, CGRectGetMaxY(_textfile.frame)+20, self.width-40, 45);
    self.cancle.frame =CGRectMake(5, 5, 30, 30);
    
}
-(void)drawRect:(CGRect)rect{
    
    switch (self.sendMsgType) {
        case CommonSendMsgTypeNormal:{
            self.markTitle.text = @"短信验证码已经发送至";
            
            break;
        }case CommonSendMsgTypePhone:{
            
            break;
        }case CommonSendMsgTypeMail:{
            
            break;
        }case CommonSendMsgTypeJLDX:{
            self.markTitle.text = [NSString stringWithFormat:@"请用手机%@",self.title.text];
            self.title.text = @"发送CXXD至10001获取验证码";
            self.title.adjustsFontSizeToFitWidth =YES;
            self.title.font =JFont(20);
            break;
        }case CommonSendMsgTypeQQCredit:{// 信用卡-- QQ邮箱
            
            break;
        }default:
            break;
    }
    
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

-(void)setTxt:(NSString *)txt{
    _txt= txt;
    _title.text = txt;
}

#pragma mark -

- (void)clicked:(UIButton *)sender {
    
    
    
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
-(void)clickedCancle{
    if (self.CancleBlock) {
        self.CancleBlock();
    }
}
-(void)sendInfo{
    if (self.clickedBlock) {
        [self hide];
        self.clickedBlock([self.textfile.text cutAllSpace]);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

- (void)show {
    
    __block typeof(self) sself =self;
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat spaceH=0;
        if (iPhone5) {
            spaceH = 80;
        } else if (iPhone6) {
            spaceH =60;
        }else if (iPhone6P) {
            spaceH =60;
        }
        sself.frame = CGRectMake((SCREEN_WIDTH - JPWIDTH)/2, (SCREEN_HEIGHT - JPHEIGHT)/2 - spaceH, JPWIDTH, JPHEIGHT);
        
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
- (void)hide {
    [UIView animateWithDuration:0.25 animations:^{
//        self.backView.alpha = 0;
        [self setFrame:CGRectMake((SCREEN_WIDTH - JPWIDTH)/2, SCREEN_HEIGHT, JPWIDTH, JPHEIGHT)];
    } completion:^(BOOL finished) {
//        [self.backView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}
#pragma mark - 创建View
-(UILabel*)title{
    if (!_title) {
        _title = [JFactoryView JlabelWithSuper:nil Color:RGB_black Font:23.0 Alignment:1 Text:@"--"];
    }
    return _title;
}
-(UILabel*)markTitle{
    if (!_markTitle) {
        _markTitle = [JFactoryView JlabelWithSuper:nil Color:RGB_black Font:13.0 Alignment:1 Text:@"短信验证码已发送至:"];
    }
    return _markTitle;
}
-(UITextField*)textfile{
    if (!_textfile) {
        _textfile = [JFactoryView JTextFieldWithSuper:nil Color:RGB_black Font:15 Alignment:1 PlaceHold:@"请输入验证码"];
        _textfile.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textfile.layer.borderColor= RGB(153, 153, 153).CGColor;
        _textfile.layer.borderWidth= 0.5f;
    }
    return _textfile;
}
-(UIButton*)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [JFactoryView JBtnWithBgColor:RGB_greenBtn Font:18 Alignment:1 textColor:RGB_white title:@"确定"];
        _sureBtn.layer.cornerRadius = 2;
        _sureBtn.layer.masksToBounds =YES;
        [_sureBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

-(UIButton*)cancle{
    if (!_cancle) {
        _cancle = [JFactoryView JBtnWithBgColor:RGB_clear Font:18 Alignment:1 textColor:RGB_white title:@""  image:@"close_JPopTextFiledView" backImg:@""];
//        _cancle.layer.cornerRadius = 2;
//        _cancle.layer.masksToBounds =YES;
        [_cancle addTarget:self action:@selector(clickedCancle) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancle;
}


@end
