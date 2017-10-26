//
//  YJRechargeTypeCell.m
//  CreditPlatform
//
//  Created by yj on 16/9/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJRechargeTypeCell.h"
#import "YJHomeItemModel.h"
@interface YJRechargeTypeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

@property (weak, nonatomic) IBOutlet UILabel *subTitleView;


@end
@implementation YJRechargeTypeCell
+ (instancetype)rechargeTypeCellWithTableView:(UITableView *)tableView {
    
    YJRechargeTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rechargeTypeCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJRechargeTypeCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return cell;
    
    
}
- (void)setPayTypeModel:(YJHomeItemModel *)payTypeModel {
    _payTypeModel = payTypeModel;
    
    self.iconView.image = [UIImage imageNamed:payTypeModel.icon];
    self.titleView.text = payTypeModel.title;
    self.subTitleView.text = payTypeModel.subTitle;
    self.selectedView.highlighted = payTypeModel.isSelected;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconView.backgroundColor = [UIColor clearColor];
    self.iconView.contentMode = UIViewContentModeCenter;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
