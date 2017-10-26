//
//  ORDetailTypeBillCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ECommerceReportDetailTypeCardCell.h"
#import "JDReportModel.h"
@interface ECommerceReportDetailTypeCardCell()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *cardType;
@property (weak, nonatomic) IBOutlet UILabel *detailCard;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *cardMain;

@end

@implementation ECommerceReportDetailTypeCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = NO;
    // Initialization code
}
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview {
    static NSString *ID = @"ECommerceReportDetailTypeCardCell";
    ECommerceReportDetailTypeCardCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ECommerceReportDetailTypeCardCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(JDbankInfoModel *)model{
    _model = model;
    _name.text = FillSpace(model.name);
    _cardType.text = FillSpace(model.cardType);
    _phone.text = FillSpace(model.tel);
    
    _cardMain.text = FillSpace(model.bankCardID);
    if (model.bankCardID.length>6) {
        NSRange rg = [model.bankCardID rangeOfString:@"(尾号"];
        if (rg.location>1) {
            _cardMain.text = model.bankCardID;
        }else{
            model.bankCardID= [model.bankCardID stringByReplacingOccurrencesOfString:@"尾号" withString:@"(尾号"];
            model.bankCardID = [model.bankCardID stringByAppendingString:@")"];
            _cardMain.text = model.bankCardID;
            NSInteger leng = model.bankCardID.length;
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithAttributedString:_cardMain.attributedText];
            NSRange r =  NSMakeRange(leng-8, 8);
            [att addAttributes:@{NSForegroundColorAttributeName:RGB_gray115,NSFontAttributeName:[UIFont systemFontOfSize:12]} range:r];
            _cardMain.attributedText = att;
        }
       
    }
    
}


@end















