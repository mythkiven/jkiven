//
//  YJRedPacketCell.m
//  BackgroundCheck
//
//  Created by yj on 2017/10/11.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "YJRedPacketCell.h"

@interface YJRedPacketCell ()
@property (weak, nonatomic) IBOutlet UIButton *redPacketBtn;
@property (weak, nonatomic) IBOutlet UILabel *yuanLB;
@property (weak, nonatomic) IBOutlet UIButton *expirationBtn;
@property (weak, nonatomic) IBOutlet UIButton *usageBtn;


@end

@implementation YJRedPacketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(YJRechargeHistoryListModel *)model {
    _model = model;
    
    NSInteger state = UIControlStateNormal;
    BOOL isSelected = NO;
    if (![model.status isEqualToString:@"有效"]) {
       state = UIControlStateSelected;
        _yuanLB.textColor = RGB(153, 153, 153);
        
        isSelected = YES;
    }
    _redPacketBtn.selected = _expirationBtn.selected =_usageBtn.selected = isSelected;
    
    [_redPacketBtn setTitle:model.redAmt forState:state];
    
    [_expirationBtn setTitle:[NSString stringWithFormat:@"有效期 %@ 至 %@",[self returndate:model.stratDate],[self returndate:model.endDate]] forState:(state)];
    
    [_usageBtn setTitle:model.status forState:(state)];
    
}


- (NSString *)returndate:(NSString *)sec{
    
    int x=[[sec substringToIndex:10] intValue];
//    int x = [sec intValue];
    
    NSDate  *date1 = [NSDate dateWithTimeIntervalSince1970:x];
    
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    return [dateformatter stringFromDate:date1];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
    
}

@end
