//
//  YJaccessoryArrowBtn.h
//  CreditPlatform
//
//  Created by yj on 16/8/1.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    YJaccessoryArrowBtnTypeNone,
    YJaccessoryArrowBtnTypeArrow
} YJaccessoryArrowBtnType;
@interface YJaccessoryArrowBtn : UIButton

@property (nonatomic) YJaccessoryArrowBtnType accessoryArrowType;



@end
