//
//  YJChildAccountInfoView.h
//  CreditPlatform
//
//  Created by yj on 2016/11/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJChildAccountInfoView : UIView
+ (instancetype)childAccountInfoView ;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameHeightConstraint;


@property (weak, nonatomic) IBOutlet UILabel *nameLB;

@property (weak, nonatomic) IBOutlet UILabel *accountLB;
@end
