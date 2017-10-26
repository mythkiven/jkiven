//
//  DataModel.h
//  CreditPlatform
//
//  Created by yj on 16/7/11.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSString *dataID;
@property (nonatomic, strong) NSString *dataName;
@property (nonatomic, assign) NSInteger dataNum;
@property (nonatomic, strong) UIImage  *dataIcon;

@end
