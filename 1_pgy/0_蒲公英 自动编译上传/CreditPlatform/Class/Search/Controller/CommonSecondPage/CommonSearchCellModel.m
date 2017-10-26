
//
//  CommonSearchCellModel.m
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/8/17.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "CommonSearchCellModel.h"
#import "YJCityModel.h"
@implementation CommonSearchCellModel

+ (NSArray*)dataArrWithFundSocialModel:(NSArray *)data Withtype:(SearchItemType)type{
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:0];
    CGFloat titleWidth = 0.0;
    if (data.count) {
        for (JFundSocialSearchCellModel * mm in data) {
            CGFloat width=[mm.lable boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
            titleWidth = (width>= titleWidth ? width: titleWidth);
        }
        
        if (titleWidth<=62) {
            titleWidth =62;
        }
        
        for (int i = 0; i<data.count; i++) {
            JFundSocialSearchCellModel * mm = data[i];
            
            CommonSearchCellModel*model = [[CommonSearchCellModel alloc]init];
            model.location = i+2;
            model.Name = mm.lable;
            if ([mm.elementType isEqualToString:@"text"]) {
                model.type = 3;
            } else if ([mm.elementType isEqualToString:@"password"]) {
                model.type = 2;
            }
            model.placeholdText = mm.placeHolder;
            model.maxLength     = titleWidth;
            model.searchItemType= type;
            model.fundModel =mm;
            [marr addObject:model];
            
        }
        
    }
    NSArray *arr = marr;
    return arr;
}

-(CommonSearchCellModel *)jModelLocation:(NSInteger)location Name:(NSString*)name type:(CommonSearchCellType)type place:(NSString *)hold {
    CommonSearchCellModel*  model = [[CommonSearchCellModel alloc]init];
    model.location = location;
    model.Name = name;
    model.type = type;
    model.placeholdText = hold;
    model.searchItemType = self.searchItemType;
    model.maxLength = 60;
    return model;
}

@end

