//
//  YJAuthTipContentView.m
//  CreditPlatform
//
//  Created by yj on 2017/6/16.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import "YJAuthTipContentView.h"

#define kkRadio 0.2


@interface YJAuthTipContentView ()
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *infoLb;

@property (nonatomic, strong) UIButton *XBtn;

@property (nonatomic, strong) UIButton *authBtn;



@end
@implementation YJAuthTipContentView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =[UIColor whiteColor];
        self.layer.cornerRadius = 6;
        self.clipsToBounds = YES;
        [self setupSubViewss];
    }
    return self;
}

- (void)setAuthStatus:(NSString *)authStatus {
    _authStatus = authStatus;
    
//    NSString *status = [kUserManagerTool authStatus];//00-待审核 20-审核成功 99-审核失败
    NSString *info = @"";
    NSString *btnTitle = @"资质认证";
    if ([authStatus isEqualToString:@"0"]) { //未认证
        info = @"根据最新实行的《网络安全法》，为保障个人权益，请您在使用前，进行相关资质认证。";
    } else if ([authStatus isEqualToString:@"00"]) {//待审核
        info = @"您提交的认证资料正在审核中，审核通过后方可使用。";
        btnTitle = @"确定";
    } else if ([authStatus isEqualToString:@"99"]) {//审核失败
        info = @"资质认证失败，请重新提交认证资料，审核通过后方可使用。";
    }
    
    self.infoLb.text = info;
    [self.authBtn setTitle:btnTitle forState:(UIControlStateNormal)];
    
    
}

- (void)setupSubViewss {
    
    
    UILabel *titleLb = [UILabel new];
    titleLb.text = @"温馨提示";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.font = [UIFont systemFontOfSize:15];
    titleLb.textColor = [UIColor blackColor];
    [self addSubview:titleLb];
    self.titleLb = titleLb;
    
    UILabel *infoLb = [UILabel new];
    infoLb.numberOfLines = 0;
    infoLb.font = [UIFont systemFontOfSize:15];
    infoLb.textColor = RGB(102, 102, 102);
    [self addSubview:infoLb];
    self.infoLb = infoLb;


    
    // X 按钮
    UIButton *XBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.XBtn = XBtn;
    XBtn.backgroundColor = [UIColor whiteColor];
    
    [XBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];

    [XBtn setImage:[UIImage imageNamed:@"close_JPopTextFiledView"] forState:(UIControlStateNormal)];
    [XBtn setImage:[UIImage imageNamed:@"close_JPopTextFiledView"] forState:(UIControlStateHighlighted)];
    [self addSubview:XBtn];
    
    
    UIButton *authBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.authBtn = authBtn;
    authBtn.layer.cornerRadius = 4;
    authBtn.clipsToBounds = YES;
    [authBtn addTarget:self action:@selector(authBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [authBtn setBackgroundColor:RGB_greenBtn];
    [authBtn setTitle:@"资质认证" forState:(UIControlStateNormal)];
    [authBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self addSubview:authBtn];
    
    
    
    
    
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLb.frame = CGRectMake(0, 20, self.width, 20);
//    self.titleLb.backgroundColor = [UIColor redColor];
    
    
    CGFloat XBtnW = 30;
    CGFloat XBtnH = XBtnW;
    CGFloat XBtnX = self.width - XBtnW - 10;
    CGFloat XBtnY = 10;
    self.XBtn.frame = CGRectMake(XBtnX, XBtnY, XBtnW, XBtnH);

    
    CGFloat margin = 30;
    CGFloat infoLbW = self.width - margin*2;
    CGFloat infoLbH = [self.infoLb heightOfLabelMaxWidth:infoLbW content:self.infoLb.text];
    
    self.infoLb.frame = CGRectMake(margin, CGRectGetMaxY(self.titleLb.frame)+15, infoLbW, infoLbH);


    
    CGFloat authBtnW = 140;
    CGFloat authBtnH = 35;
    self.authBtn.frame = CGRectMake((self.width-authBtnW)*0.5, 195-20-authBtnH, authBtnW, authBtnH);
    

    
}

- (void)authBtnClick {
    NSLog(@"----------authBtnClick");
    [self closeBtnClick];
    if ([_authStatus isEqualToString:@"0"] || [_authStatus isEqualToString:@"99"]) { //未认证 //审核失败
        
        if ([self.delegate respondsToSelector:@selector(authTipContentViewDidAuth:)]) {
            [self.delegate authTipContentViewDidAuth:self];
        }
    } else if ([_authStatus isEqualToString:@"00"]) {//待审核
//        [self closeBtnClick];
        
    }
    
    
    
    
    
}

/**
 *  关闭图片
 */
- (void)closeBtnClick {
    
    NSLog(@"----------closeBtnClick");
    if ([self.delegate respondsToSelector:@selector(authTipContentViewDidClose:)]) {
        [self.delegate authTipContentViewDidClose:self];
    }
    
    
    
}

- (void)setFrame:(CGRect)frame {
    CGRect temp = frame;
    temp.size.width = 285;
    temp.size.height = 195;
    frame = temp;
    [super setFrame:frame];
}



@end
