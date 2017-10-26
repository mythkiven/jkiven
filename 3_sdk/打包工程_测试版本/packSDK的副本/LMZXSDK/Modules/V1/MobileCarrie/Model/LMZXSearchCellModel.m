
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
+ (NSArray*)dataArrWithFundSocialModel:(NSArray *)data Withtype:(LMZXSearchItemType)type{
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

// 运营商 model
+ (NSArray*)dataArrWithMobileModel:(NSArray *)data Withtype:(LMZXSearchItemType)type{
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:0];
    CGFloat titleWidth = 0.0;

    if (data.count) {
        for (LMZXMobileLoginElement *element in data) {
            CGFloat width=[element.label boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
            titleWidth = (width>= titleWidth ? width: titleWidth);
        }
        
        if (titleWidth<=62) {
            titleWidth =62;
        }
        
        // 第一个是手机号, 我们不需要,所以排除掉 从 1 开始
        for (int i = 1; i<data.count; i++) {
            LMZXMobileLoginElement *element = data[i];
            
            LMZXSearchCellModel*model = [[LMZXSearchCellModel alloc]init];
            
            if (data.count==3 &&i==1) { //123模式
                model.location = 2;
            } else if (data.count==3 &&i==2) { //123模式
                model.location = 3;
            } else if (data.count==4 &&i<3) {// 1223模式
                model.location = 2;
            } else if (data.count==4 &&i==3) {// 1223模式
                model.location = 3;
            }  else if (data.count==5 &&i<4) {//12223模式
                model.location = 2;
            } else if (data.count==5 &&i==4) {//12223模式
                model.location = 3;
            } else {// 13模式
                model.location = i+1;
            }
            
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
            model.mobileModel = element;
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




 

@implementation LMZXMobileLoginElement

 

+ (instancetype)mobileLoginElementWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}


- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}



@end



