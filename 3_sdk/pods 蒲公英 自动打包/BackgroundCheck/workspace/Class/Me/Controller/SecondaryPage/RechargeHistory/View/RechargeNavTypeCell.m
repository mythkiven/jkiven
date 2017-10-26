//
//  RechargeNavTypeCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "RechargeNavTypeCell.h"
#import "RechargeNavTypeModel.h"

@interface RechargeNavTypeCell ()
@property (weak, nonatomic) IBOutlet UIButton *leftIcon;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@end

@implementation RechargeNavTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _leftBtn.selected = NO;
    _leftIcon.selected = NO;
    _leftIcon.hidden = YES;
    _leftBtn.enabled =YES;
    _leftIcon.enabled =YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_leftBtn setTitleColor:RGB_blueText forState:UIControlStateSelected];
    
}

+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview{
    RechargeNavTypeCell *cell = [tableview dequeueReusableCellWithIdentifier:@"RechargeNavTypeCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"RechargeNavTypeCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return cell;
}

-(void)clearData {
    _leftBtn.selected = NO;
    _leftIcon.selected = NO;
    _leftIcon.hidden = YES;
    
}

-(void)setModel:(RechargeNavTypeModel *)model{
    [self clearData];
    _model = model;
    if (!model.canTouch) {
        _leftIcon.enabled =NO;
        _leftBtn.enabled =NO;
    }else{
        _leftIcon.enabled =YES;
        _leftBtn.enabled =YES;
    }
    if (model.showIcon) {
        _leftIcon.hidden =NO;
    }else{
        _leftIcon.hidden =YES;
    }
    _leftBtn.tag = model.Tag;
    [_leftBtn setTitle:model.Name forState:UIControlStateNormal];
}

- (IBAction)selectBtn:(UIButton *)sender {
//    sender.selected =!sender.selected;
//    _model.showIcon = !_model.showIcon;
    sender.selected = YES;
    _model.showIcon = YES;
    
    if ([self.delegate respondsToSelector:@selector( didSelectedRechargeNavTypeDidSelected:)]) {
        _rechargeStatusType =[_model.tagL integerValue];
        [self.delegate didSelectedRechargeNavTypeDidSelected:_model];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
//- (void)setFrame:(CGRect)frame {
//    [super setFrame:frame];
//}








@end
