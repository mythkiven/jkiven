//
//  EducationView.h
//  CreditPlatform
//
//  Created by gyjrong on 16/8/18.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EducationInfo,StudentStatusInfo;
@interface EducationView : UIView
@property (strong,nonatomic) StudentStatusInfo  *xjmodel;
@property (strong,nonatomic) EducationInfo  *xmodel;

+ (instancetype)educationViewTop;
//+ (instancetype)educationViewDown;
@end
