//
//  ReportRiskTipsCell.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "ReportRiskTipsCell.h"


@interface ReportRiskTipsCell   ()  
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *fayuanss;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *shixinbzx;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *daikuanxx;
// 121.5

@end
static CGFloat cellHeight = 121.5;

@implementation ReportRiskTipsCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
+ (CGFloat)cellHeight{
    return cellHeight;
}


-(void)setRiskTipsModel:(RiskTipsModel *)riskTipsModel{
    _riskTipsModel = riskTipsModel;
    _fayuanss.text = [riskTipsModel.cligNum stringByAppendingString:@"次"];
    _shixinbzx.text = [riskTipsModel.dishNum stringByAppendingString:@"次"];
    _daikuanxx.text = [riskTipsModel.linfNum stringByAppendingString:@"次"];
    
}

@end
