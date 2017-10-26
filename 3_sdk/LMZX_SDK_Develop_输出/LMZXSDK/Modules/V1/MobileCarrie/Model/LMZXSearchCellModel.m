
//
//  CommonSearchCellModel.m
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/8/17.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXSearchCellModel.h"
#import "LMZXCityModel.h"
@implementation LMZXSearchCellModel
//
+ (NSArray*)dataArrWithFundSocialModel:(NSArray *)data Withtype:(SearchItemType)type{
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:0];
    CGFloat titleWidth = 0.0;
    if (data.count) {
        for (LMZXCityLoginElement *element in data) {
            CGFloat width=[element.label boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
            titleWidth = (width>= titleWidth ? width: titleWidth);
        }
        
        if (titleWidth<=62) {
            titleWidth =62;
        }
        
        for (int i = 0; i<data.count; i++) {
            LMZXCityLoginElement *element = data[i];
            
            LMZXSearchCellModel*model = [[LMZXSearchCellModel alloc]init];
            model.location = i+2;
            model.Name = element.label;
            if ([element.type isEqualToString:@"text"]) {
                model.type = 3;
            } else if ([element.type isEqualToString:@"password"]) {
                model.type = 2;
            }
            model.Text = @"";
            model.placeholdText = element.prompt;
            model.maxLength     = titleWidth;
            model.searchItemType= type;
            model.fundModel = element;
            [marr addObject:model];
            
        }
        
    }
    NSArray *arr = marr;
    return arr;
}

-(LMZXSearchCellModel *)jModelLocation:(NSInteger)location Name:(NSString*)name type:(LMZXCommonSearchCellType)type place:(NSString *)hold {
    LMZXSearchCellModel*  model = [[LMZXSearchCellModel alloc]init];
    model.location = location;
    model.Name = name;
    model.type = type;
    model.placeholdText = hold;
    model.searchItemType = self.searchItemType;
    model.maxLength = 60;
    return model;
}

@end

