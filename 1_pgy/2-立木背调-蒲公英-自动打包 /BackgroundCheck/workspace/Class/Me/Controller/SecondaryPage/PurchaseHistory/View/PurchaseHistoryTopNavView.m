//
//  PurchaseHistoryTopNavView.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "PurchaseHistoryTopNavView.h"
#import "LeftImgBtn.h"
#define imgWidth 10 
//图片宽度
@interface PurchaseHistoryTopNavView ()


@end

@implementation PurchaseHistoryTopNavView
{
    LeftImgBtn *btnTime;
    UIButton *imgBtn;
    UIButton *_btnType;
    UIButton*_titleBtn;
}
-(void)layoutSubviews{
    CGFloat titleW = _titleBtn.titleLabel.text.length*15;
    _titleBtn.center = _btnType.center;
    imgBtn.center = CGPointMake(_titleBtn.center.x+titleW/2+imgWidth/2+3, _titleBtn.center.y);
//    _btnType.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
//    _btnType.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 60);
    
}


-(id)initPurchaseHistoryTopNavViewWithframe:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        _btnType = [[UIButton alloc]initWithFrame:CGRectMake(0,0, frame.size.width/2-0.5, frame.size.height)];
        _btnType.tag = 77;
        _btnType.backgroundColor = [UIColor clearColor];
        
        _titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, frame.size.width/2-0.5, frame.size.height)];
        _titleBtn.titleLabel.font = Font15;
        [_titleBtn  setTitle:@"类型" forState: UIControlStateNormal];
        [_titleBtn  setTitleColor:RGB_black forState:UIControlStateNormal];
        [self addSubview:_titleBtn];
        imgBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, frame.size.width/2-0.5, frame.size.height)];
        [imgBtn setImage:[UIImage imageNamed:@"icon_menu_down"] forState:UIControlStateNormal];
        [self addSubview:imgBtn];
        
        [_btnType addTarget:self action:@selector(clickedTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        _btnType.adjustsImageWhenHighlighted = NO;
        
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 7, 0.6, frame.size.height - 14)];
        line.center = self.center;
        line.backgroundColor = RGB_grayLine;
        [self addSubview:line];
        
        
        
        
        btnTime = [[LeftImgBtn alloc]initWithFrame:CGRectMake(frame.size.width/2+0.5, 0, frame.size.width/2-0.5, frame.size.height)];
        btnTime.tag = 88;
        btnTime.adjustsImageWhenHighlighted = NO;
        btnTime.titleLabel.font = Font15;
        [btnTime setTitleColor:RGB_black forState:UIControlStateNormal];
        [btnTime setTitle:@"时间" forState: UIControlStateNormal];
        [btnTime setImage:[UIImage imageNamed:@"icon_menu_down"] forState:UIControlStateNormal];
        [btnTime addTarget:self action:@selector(clickedTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
         [self addSubview:_btnType];
         [self addSubview:btnTime];
        UIView *lineD = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
        lineD.backgroundColor = RGB_grayLine;
        [self addSubview:lineD];
        
    }

    return self;
    
}

//icon_menu_up
//点击type tag 77
- (void)clickedTypeBtn:(UIButton *)sender {
    _btnType.selected = !_btnType.selected;
    
    if (self.clickedTopNavBtn) {
        self.clickedTopNavBtn(sender);
    }
    
    if (btnTime.selected) {//选中的话，置为未选中状态
        btnTime.selected = !btnTime.selected;
        [btnTime setImage:[UIImage imageNamed:@"icon_menu_down"] forState:UIControlStateNormal];
//        [UIView animateWithDuration:0.25 animations:^{
//            if (CGAffineTransformIsIdentity(btnTime.imageView.transform)) {
//                btnTime.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//                btnTime.imageView.tintColor = RGB_blueText;
//            }else{
//                btnTime.imageView.transform = CGAffineTransformIdentity;
//            }
//        }];
    }
    if (_btnType.selected) {
        [imgBtn setImage:[UIImage imageNamed:@"icon_menu_up"] forState:UIControlStateNormal];
    }else{
        [imgBtn setImage:[UIImage imageNamed:@"icon_menu_down"] forState:UIControlStateNormal];
    }
//    [UIView animateWithDuration:0.25 animations:^{
//        if (CGAffineTransformIsIdentity(sender.imageView.transform)) {
//            btnTime.imageView.tintColor = RGB_blueText;
//            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//        }else{
//            sender.imageView.transform = CGAffineTransformIdentity;
//        }
//        
//    }];
    
}

//点击time tag 88
- (void)clickedTimeBtn:(UIButton *)sender {
    btnTime.selected = !btnTime.selected;
//    NSString*name = _titleBtn.titleLabel.text;
    
    if (self.clickedTopNavBtn) {
        self.clickedTopNavBtn(sender);
    }
    
    if (_btnType.selected) {//另一个置为未选中 状态
        [imgBtn setImage:[UIImage imageNamed:@"icon_menu_down"] forState:UIControlStateNormal];
        _btnType.selected = !_btnType.selected;
//        [_titleBtn setTitle:name forState:UIControlStateNormal];
        [self layoutSubviews];
//        [UIView animateWithDuration:0.25 animations:^{
//            if (CGAffineTransformIsIdentity(imgBtn.imageView.transform)) {
//                imgBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//            }else{
//                imgBtn.imageView.transform = CGAffineTransformIdentity;
//                
//            }
//        }];
    }
    if (btnTime.selected) {
        [btnTime setImage:[UIImage imageNamed:@"icon_menu_up"] forState:UIControlStateNormal];
    }else{
        [btnTime setImage:[UIImage imageNamed:@"icon_menu_down"] forState:UIControlStateNormal];
    }
    
    
    
//    [UIView animateWithDuration:0.25 animations:^{
//        NSString*name = _titleBtn.titleLabel.text;
//        if (CGAffineTransformIsIdentity(sender.imageView.transform)) {
//            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//        }else{
//            sender.imageView.transform = CGAffineTransformIdentity;
//            [_titleBtn setTitle:name forState:UIControlStateNormal];
//        }
//    }];
    
}

-(void)cancelSelected{
    NSString*name = _titlebtn;
    
    if (_btnType.selected) {
        _btnType.selected = !_btnType.selected;
        [_titleBtn setTitle:name forState:UIControlStateNormal];
        [imgBtn setImage:[UIImage imageNamed:@"icon_menu_down"] forState:UIControlStateNormal];
        [self layoutSubviews];
//        [UIView animateWithDuration:0.25 animations:^{
//            if (CGAffineTransformIsIdentity(imgBtn.imageView.transform)) {
//                imgBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//            }else{
//                imgBtn.imageView.transform = CGAffineTransformIdentity;
//                
//            }
//        }];
        
    }
    
    if (btnTime.selected) {
        btnTime.selected = !btnTime.selected;
        [btnTime setImage:[UIImage imageNamed:@"icon_menu_down"] forState:UIControlStateNormal];
//        [UIView animateWithDuration:0.25 animations:^{
//            if (CGAffineTransformIsIdentity(btnTime.imageView.transform)) {
//                btnTime.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//            }else{
//                btnTime.imageView.transform = CGAffineTransformIdentity;
//            }
//        }];
    }
    
    
}
@end
