//
//  YJQueryInfoModel.m
//  LiMuCycle
//
//  Created by yj on 2017/2/13.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import "LMZXQueryInfoModel.h"

@implementation LMZXQueryInfoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithName:(NSString*)name mobile:(NSString*)mobile idNO:(NSString*)idNO position:(NSString*)position {
    self = [super init];
    if (self) {
        self.name = name;
        self.mobile = mobile;
        self.identityNo = idNO;
        self.position = position;
    }
    return self;
}
@end
