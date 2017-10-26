//
//  SpaceLabel.m
//  CreditPlatform
//
//  Created by gyjrong on 16/8/14.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "SpaceLabel.h"

@implementation SpaceLabel

//+ (void)initialize{
//    
//    Method setText = class_getInstanceMethod([UILabel class], @selector(setText:));
//    Method setTextMySelf = class_getInstanceMethod([self class], @selector(setTextHooked:));
//    IMP setTextImp = method_getImplementation(setText);
//    class_addMethod([UILabel class], @selector(setTextOriginal:), setTextImp, method_getTypeEncoding(setText));
//    IMP setTextMySelfImp = method_getImplementation(setTextMySelf);
//    class_replaceMethod([UILabel class], @selector(setText:), setTextMySelfImp, method_getTypeEncoding(setText));
//    
//}
//
//
//- (void)setTextHooked:(NSString *)string{
//        if ([string isEqualToString:@""]|[string isKindOfClass:[NSNull class]]|!string) {
//            string = @"--";
//        }
//    [self performSelector:@selector(setTextOriginal:) withObject:string];
//    
//}




@end
