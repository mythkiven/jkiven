//
//  CalendarManger.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarManger : NSCalendar
+ (instancetype)defaulting;
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;
//-(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;
@end
