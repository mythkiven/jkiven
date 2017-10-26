//
//  YJHomeCell.m
//  CreditPlatform
//
//  Created by yj on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJPayWayCell.h"
#import "YJHomeItemModel.h"
@interface YJPayWayCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLB;


@end

@implementation YJPayWayCell
+ (instancetype)payWayCellWithTableView:(UITableView *)tableView {
    
    YJPayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payWayCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJPayWayCell" owner:nil options:nil] lastObject];
        
    }
    return cell;
    
    
}

- (void)setHomeItemModel:(YJHomeItemModel *)homeItemModel {
    _homeItemModel = homeItemModel;
    
    self.iconView.image = [UIImage imageNamed:homeItemModel.icon];
    self.titleLB.text = homeItemModel.title;
    self.subTitleLB.text = homeItemModel.subTitle;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconView.contentMode = UIViewContentModeCenter;}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
