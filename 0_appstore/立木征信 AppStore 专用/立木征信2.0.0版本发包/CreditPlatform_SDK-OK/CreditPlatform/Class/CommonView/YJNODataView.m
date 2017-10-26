//
//  YJNODataView.m
//  CreditPlatform
//
//  Created by yj on 16/8/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJNODataView.h"

@interface YJNODataView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *desLB;

@end
@implementation YJNODataView


+ (instancetype)NODataView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"YJNODataView" owner:nil options:nil] firstObject];
}

+ (instancetype)NODataView:(NODataType)type {
    
    
    return [[self alloc] initWithNODataType:type];
    
}



- (instancetype)initWithNODataType:(NODataType)type
{
    self = [super init];
    if (self) {
        self= [[[NSBundle mainBundle] loadNibNamed:@"YJNODataView" owner:nil options:nil] firstObject];
        //设置默认：
        NSString *des =  @"没有相关数据";
        NSString *imgName = @"icon_nodata";
        
        switch (type) {
            case NODataTypeRedNormal:
                des = @"没有相关数据";
                imgName = @"icon_nodata";
                break;
            case NODataTypeRedPacket:
                des = @"您还没有红包哦";
                imgName = @"icon_no_redPacketHis";
                break;
            case NODataTypeRecharge:
                des = @"您还没有充值记录哦";
                imgName = @"icon_no_rechargeHis";
                break;
            case NODataTypepurchase:
                des = @"您还没有消费记录哦";
                imgName = @"icon_no_purchaseHis";
                break;
            case NODataTypeChildAccount:
                des = @"您还没有子账号";
                imgName = @"icon_no_childAccount";
                break;
            default:
                break;
        }
        
        self.iconView.image = [UIImage imageNamed:imgName];
        self.desLB.text = des;
    }
    return self ;
}


- (void)awakeFromNib {
    [super awakeFromNib];
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200+64);
//    self.frame = CGRectMake(0, -200, SCREEN_WIDTH, 200+64);
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200+64);

    
}

@end
