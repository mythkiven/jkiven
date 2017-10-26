//
//  ORDetailTypeMessageCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "OperationModel.h"
#import "ORDetailTypeMessageCell.h"
@interface ORDetailTypeMessageCell()
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *Month;

@end
@implementation ORDetailTypeMessageCell
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview {
    static NSString *ID = @"ORDetailTypeMessageCell";
    ORDetailTypeMessageCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ORDetailTypeMessageCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(OperationMessageSix *)model{
    _model = model;
    _num.text = model.sendSmsToTelCode;
    if (model.sendSmsAddress) {
        if (model.sendSmsAddress.length) {
            _adress.text = model.sendSmsAddress;
        }else
            _adress.text = @"--";
    } else {
        _adress.text = @"--";
    }
//    _adress.text = model.sendSmsAddress?@"--":(model.sendSmsAddress.length?@"--":model.sendSmsAddress);
    _time.text = [model.sendSmsTime substringFromIndex:10];
    _Month.text = [model.sendSmsTime substringToIndex:10];
    _type.text = model.sendType;
}
@end
