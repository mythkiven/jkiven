//
//  Foundation+log.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import <Foundation/Foundation.h>
@implementation NSDictionary (Log)
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    [str appendString:@"}"];
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        [str deleteCharactersInRange:range];
    }
    return str;
}
@end

@implementation NSArray (Log)
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"[\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    [str appendString:@"]"];
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        [str deleteCharactersInRange:range];
    }
    return str;
}



@end
