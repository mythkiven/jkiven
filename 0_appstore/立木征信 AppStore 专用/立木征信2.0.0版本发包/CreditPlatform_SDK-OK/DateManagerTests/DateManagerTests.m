//
//  DateManagerTests.m
//  DateManagerTests
//
//  Created by gyjrong on 16/9/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CalendarManger.h"
//#import "CalendarManger.h"

@interface DateManagerTests : XCTestCase
@property (nonatomic,strong) CalendarManger  *dateManger;
@end

@implementation DateManagerTests


- (void)setUp {
    [super setUp];
    
    self.dateManger = [CalendarManger defaulting];
    
}
- (void)tearDown {
    self.dateManger = nil;
    [super tearDown];
}


#pragma  mark 测试日期管理类
- (void)testDateManager {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSDate *date1 = [dateFormatter dateFromString:@"2017-01-01"];
    NSDate *date2 = [dateFormatter dateFromString:@"2016-02-29"];
    NSDate *date3 = [dateFormatter dateFromString:@"2016-07-31"];
    NSDate *date4 = [dateFormatter dateFromString:@"2016-01-31"];
    
    
    NSDate *date12 =  [CalendarManger getPriousorLaterDateFromDate: date1 withMonth:-1];
    XCTAssertEqual(date12,[dateFormatter dateFromString:@"2016-12-01"],@"1测试不通过");
    NSDate *date22 =  [CalendarManger getPriousorLaterDateFromDate: date2 withMonth:-1];
    XCTAssertEqual(date22,[dateFormatter dateFromString:@"2016-01-29"],@"2测试不通过");
    NSDate *date32 =  [CalendarManger getPriousorLaterDateFromDate: date3 withMonth:-1];
    XCTAssertEqual(date32, [dateFormatter dateFromString:@"2016-06-30"],@"3测试不通过");
    NSDate *date42 =  [CalendarManger getPriousorLaterDateFromDate: date4 withMonth:-1];
    XCTAssertEqual(date42, [dateFormatter dateFromString:@"2015-12-31"],@"4测试不通过");
    
    
    NSDate *date13 =  [CalendarManger getPriousorLaterDateFromDate: date1 withMonth:-3];
//    XCTAssertEqual(date13,[dateFormatter dateFromString:@"2016-10-01"],@"1测试不通过");
    NSDate *date23 =  [CalendarManger getPriousorLaterDateFromDate: date2 withMonth:-3];
//    XCTAssertEqual(date23,[dateFormatter dateFromString:@"2016-11-29"],@"2测试不通过");
    NSDate *date33 =  [CalendarManger getPriousorLaterDateFromDate: date3 withMonth:-3];
//    XCTAssertEqual(date33, [dateFormatter dateFromString:@"2016-04-30"],@"3测试不通过");
    NSDate *date43 =  [CalendarManger getPriousorLaterDateFromDate: date4 withMonth:-3];
//    XCTAssertEqual(date43, [dateFormatter dateFromString:@"2015-10-31"],@"4测试不通过");
    
    
}

@end
