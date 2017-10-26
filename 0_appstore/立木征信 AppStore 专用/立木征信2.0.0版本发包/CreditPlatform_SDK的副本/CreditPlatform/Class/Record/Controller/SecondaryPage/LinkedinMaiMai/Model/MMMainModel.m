//
//  MMMainModel.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "MMMainModel.h"



@implementation MMMainModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"workExps" : [workInfoMM class],
             @"educationExps" : [educationInfoMM class],
             @"friendInfos" : [friendInfoMM class],};
}
-(void)setCardInfo:(cardInfoMM *)cardInfo{
    _cardInfo = cardInfo;
    _cardInfo = [cardInfoMM mj_objectWithKeyValues:cardInfo];
}
-(void)setBaseInfo:(baseInfoMM *)baseInfo{
    _baseInfo = baseInfo;
    _baseInfo = [baseInfoMM mj_objectWithKeyValues:baseInfo];
}

@end
@implementation cardInfoMM
@end
@implementation baseInfoMM
@end
@implementation workInfoMM
@end
@implementation educationInfoMM
@end
@implementation friendInfoMM
@end

