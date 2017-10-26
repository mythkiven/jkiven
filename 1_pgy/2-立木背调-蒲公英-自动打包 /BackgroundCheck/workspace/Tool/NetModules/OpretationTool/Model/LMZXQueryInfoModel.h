//
//  YJQueryInfoModel.h
//  LiMuCycle
//
//  Created by yj on 2017/2/13.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LMZXQueryInfoModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *identityNo;


@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *position;


- (instancetype)initWithName:(NSString*)name mobile:(NSString*)mobile idNO:(NSString*)idNO position:(NSString*)position;


@end
