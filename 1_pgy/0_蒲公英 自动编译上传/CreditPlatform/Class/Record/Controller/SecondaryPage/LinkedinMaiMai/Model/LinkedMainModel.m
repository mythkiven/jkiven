//
//  LinkedMainModel.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LinkedMainModel.h"

@implementation LinkedMainModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"workExps" : [workInfoLY class],
             @"educationExps" : [educationInfoLY class],
             @"friendInfos" : [friendInfoLY class],};
}
-(void)setCardInfo:(cardInfoLY *)cardInfo{
    _cardInfo = cardInfo;
    _cardInfo = [cardInfoLY mj_objectWithKeyValues:cardInfo];
}
-(void)setBaseInfo:(baseInfoLY *)baseInfo{
    _baseInfo = baseInfo;
    _baseInfo = [baseInfoLY mj_objectWithKeyValues:baseInfo];
}

@end
@implementation cardInfoLY
@end
@implementation baseInfoLY
@end
@implementation workInfoLY
@end
@implementation educationInfoLY
@end
@implementation friendInfoLY
@end



