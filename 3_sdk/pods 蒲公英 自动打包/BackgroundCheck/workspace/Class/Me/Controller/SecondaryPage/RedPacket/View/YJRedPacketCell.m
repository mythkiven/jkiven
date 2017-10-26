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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   

}

@end
