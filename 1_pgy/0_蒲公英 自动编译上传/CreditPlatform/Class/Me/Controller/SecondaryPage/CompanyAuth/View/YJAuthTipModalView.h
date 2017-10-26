//
//  YJAuthTipView.h
//  CreditPlatform
//
//  Created by yj on 2017/6/16.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^YJCityPickerViewResult)(NSString* province,NSString* city,int index);

typedef void(^AuthBlock)();
@interface YJAuthTipModalView : UIView

@property (nonatomic, copy) NSString *authStatus;

@property (nonatomic, copy) AuthBlock authBlock;


- (void)showInRect:(CGRect)rect;


@end
