//
//  CalendarManger.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "CalendarManger.h"

@implementation CalendarManger

+ (instancetype)defaulting {
    static CalendarManger *tool = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        tool = [[self alloc] init];
    });
    
    return tool;
}

//// 0 当前 -1 往前1月 +2 往后2月
//-(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month {
//    
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    
//    [comps setMonth:month];
//    
//    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    
//    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
//    
//    return mDate;
//    
//}
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month {
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    return mDate;
    
}
//
//-(void)INIT{
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *comps = nil;
//    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:mydate];
//    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
//    [adcomps setYear:0];
//    [adcomps setMonth:-1];
//    [adcomps setDay:0];
//    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
//    
//}
@end
