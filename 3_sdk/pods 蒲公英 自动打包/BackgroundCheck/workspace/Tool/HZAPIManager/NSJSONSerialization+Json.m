

#import "NSJSONSerialization+Json.h"

@implementation NSJSONSerialization (Json)
+(id)returnObjectWithJsonStr:(NSString *)str
{
//    if (str) {
//        <#statements#>
//    }
    NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
    id object =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    
    return object;
}
+(NSString *)returnJsonStrWithObject:(id)object
{
    if (object ==nil) {
        return @"";
    }
    NSData *jsonObject  =[NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str1 =[[NSString alloc] initWithData:jsonObject encoding:NSUTF8StringEncoding];
    return str1;
}
@end
