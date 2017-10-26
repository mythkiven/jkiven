//
//  YJMenuModel.h
//  CreditPlatform
//
//  Created by yj on 2017/6/30.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJMenuModel : NSObject


@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL isSelected;


//@property (nonatomic, copy) NSString *title;
+ (instancetype)menuModelWith:(NSString *)title ;
@end
