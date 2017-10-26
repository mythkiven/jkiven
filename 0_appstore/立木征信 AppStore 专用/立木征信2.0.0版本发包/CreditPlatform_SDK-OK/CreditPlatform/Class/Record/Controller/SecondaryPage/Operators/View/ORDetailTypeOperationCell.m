//
//  ORDetailTypeOperationCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "OperationModel.h"
#import "ORDetailTypeOperationCell.h"
@interface ORDetailTypeOperationCell ()
@property (weak, nonatomic) IBOutlet UILabel *month;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *money;
//@property (weak, nonatomic) IBOutlet UILabel *time;

@end
@implementation ORDetailTypeOperationCell
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview {
    static NSString *ID = @"ORDetailTypeOperationCell";
    ORDetailTypeOperationCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ORDetailTypeOperationCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(OperationBanliSix *)model{
    _model = model;
    _month.text = FillSpace(model.beginTime);
    _name.text = FillSpace(model.businessName);
//    _time.text = model.beginTime;
    
    if (model.cost) {
        if (model.cost.length) {
            _money.text = model.cost;
        }else
            _money.text = @"----";
    }else {
        _money.text = @"----";
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
