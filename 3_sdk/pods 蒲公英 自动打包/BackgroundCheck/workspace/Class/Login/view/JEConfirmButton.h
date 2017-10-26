//
//  JEConfirmButton.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/22.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JEConfirmButton : UIButton

/**
 绿色带圆角的确认按钮
 YES NO 对应 可点击  不可点击(透明度0.3)
 */
@property (assign,nonatomic) BOOL  canClicked;
/**
 加载绿色带圆角的确认按钮
 */
-(void)loadConfigEnable:(BOOL)enbale;
 
//-(instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor*)backgroundColor titleColor:(UIColor*)titleColor borderColor:(UIColor*)borderColor;

@end
