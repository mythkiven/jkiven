//
//  reportDishonestyModel.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "reportDishonestyModel.h"

@implementation reportDishonestyModel

- (void)setLegalObligation:(NSString *)legalObligation {
    legalObligation = [legalObligation stringByReplacingOccurrencesOfString:@"<br></br>" withString:@"\n"];

    legalObligation = [legalObligation stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
 

    _legalObligation = legalObligation;
    
    
    
}

@end
