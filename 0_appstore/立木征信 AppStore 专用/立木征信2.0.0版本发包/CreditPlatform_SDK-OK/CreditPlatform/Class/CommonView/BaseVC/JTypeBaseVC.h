//
//  JTypeBaseVC.h
//  CreditPlatform
//
//  Created by gyjrong on 16/11/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTypeBaseVC : UITableViewController

/**记录页面的 type*/
@property (strong,nonatomic,readwrite) NSString      *recodeType;

/**首页传入 type*/
@property (nonatomic, assign,readwrite) SearchItemType  searchItemType;

/**区分首页还是记录页*/
@property (nonatomic, strong,readwrite) YJSearchConditionModel *searchConditionModel;

@end
