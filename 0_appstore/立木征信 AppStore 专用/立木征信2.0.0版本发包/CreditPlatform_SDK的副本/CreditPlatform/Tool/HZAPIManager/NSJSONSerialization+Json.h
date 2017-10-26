

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (Json)
+(id)returnObjectWithJsonStr:(NSString *)str;
+(NSString *)returnJsonStrWithObject:(id)object;
@end
