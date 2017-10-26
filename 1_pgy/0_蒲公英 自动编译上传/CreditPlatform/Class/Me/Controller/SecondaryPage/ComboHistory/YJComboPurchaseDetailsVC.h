//
//  YJComboPurcjhaseDetailsVC.h
//  CreditPlatform
//
//  Created by yj on 2016/10/26.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ComboPurchaseType) {
    //A套餐
    ComboPurchaseTA,
    //B套餐
    ComboPurchaseTB,
    
    
};

@interface YJComboPurchaseDetailsVC : UITableViewController

@property (assign,nonatomic) ComboPurchaseType  comboPurchaseType;

@property (nonatomic, copy) NSString *packConsuId;

@end
