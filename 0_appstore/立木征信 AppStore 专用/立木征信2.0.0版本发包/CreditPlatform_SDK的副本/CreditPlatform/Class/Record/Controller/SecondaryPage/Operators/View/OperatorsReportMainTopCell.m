//
//  YJHouseFundView.m
//  CreditPlatform
//
//  Created by yj on 16/7/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "OperatorsReportMainTopCell.h"
#import "OperationModel.h"
#import "OperationNewModel.h"

@interface OperatorsReportMainTopCell ()
/*********基本信息********/
/**
*  姓名
*/
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
/**
 *  会员等级
 */
@property (weak, nonatomic) IBOutlet UILabel *level;
/**
 *  手机号
 */
@property (weak, nonatomic) IBOutlet UILabel *phone;
/**
 *  邮箱
 */
@property (weak, nonatomic) IBOutlet UILabel *mail;
/**
 *  余额
 */
@property (weak, nonatomic) IBOutlet UILabel *money;
/**
 *  身份证
 */
@property (weak, nonatomic) IBOutlet UILabel *ID;
/**
 *  积分
 */
@property (weak, nonatomic) IBOutlet UILabel *score;
/**
 *  地区
 */
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet SpaceLabel *firstNet;
@property (weak, nonatomic) IBOutlet SpaceLabel *timeOfNet;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contstraintHeight1;
@property (weak, nonatomic) IBOutlet SpaceLabel *placeOfUser;
@property (weak, nonatomic) IBOutlet SpaceLabel *operationOfuser;


@end
@implementation OperatorsReportMainTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _address.numberOfLines = 0;
//    _address.backgroundColor = RGB_red;
}


+ (id)houseFundView {
    return [[[NSBundle mainBundle] loadNibNamed:@"OperatorsReportMainTopCell" owner:nil options:nil] firstObject];
}

-(void)setModel:(OperationModel *)model{
    _model = model;
    _nameLB.text = model.realName;
    _level.text = model.vipLevelstr;
    _phone.text = model.mobileNo;
    _mail.text = model.email;
    _money.text =model.amount;
    _ID.text = model.idCard;
    _score.text = model.pointsValuestr;
    _address.text = model.address;
    _firstNet.text = model.registerDate;
//    _address.adjustsFontSizeToFitWidth = YES;
    
    CGFloat maxWidth = SCREEN_WIDTH - 90 - 15 - 10;
    CGFloat h = [model.address boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font15} context:nil].size.height;
    if (h < 20) {
        h = 20;
    }
    
    self.contstraintHeight1.constant = h;
    
}

-(void)setModelNew:(OperationNewModel *)modelNew {
    _timeOfNet.text = modelNew.networkAge;
    _placeOfUser.text = modelNew.mobileAreaAddress;
    _operationOfuser.text = modelNew.mobileOperator;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}



@end
