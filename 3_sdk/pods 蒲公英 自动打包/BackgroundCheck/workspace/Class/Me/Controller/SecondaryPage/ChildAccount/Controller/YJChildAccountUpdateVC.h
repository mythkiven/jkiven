//
//  YJChildAccountUpdateVC.h
//  CreditPlatform
//
//  Created by yj on 2016/11/10.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJChildAccountListModel;

typedef void(^UpdateSuccessBlock)(NSString *name);
@interface YJChildAccountUpdateVC : UIViewController

@property (nonatomic, strong) YJChildAccountListModel *childAccountModel;

@property (nonatomic, copy) NSString *optionName;

@property (nonatomic, copy) UpdateSuccessBlock updateNameSuccess;

@property (nonatomic, copy) UpdateSuccessBlock updatePasswordSuccess;


@end
