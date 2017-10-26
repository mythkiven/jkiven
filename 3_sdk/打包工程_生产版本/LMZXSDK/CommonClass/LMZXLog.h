//
//  LMZXLog.h
//  LMZX_SDK_Demo
//
//  Created by yj on 2017/3/20.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import <Foundation/Foundation.h>


static char TAG_ACTIVITY_SHOW;





@interface LMZXLog : NSObject

+(LMZXLog *)defaultLog;
- (void)closeLog;
- (void)unlockLog;
- (void)LMZXLogging:(NSString *)info;

@end
