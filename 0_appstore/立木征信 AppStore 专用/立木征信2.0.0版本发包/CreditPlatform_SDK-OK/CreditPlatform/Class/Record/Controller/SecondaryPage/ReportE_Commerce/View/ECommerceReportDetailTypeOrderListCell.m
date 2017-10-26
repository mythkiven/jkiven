//
//  ECommerceReportDetailTypeOrderListCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ECommerceReportDetailTypeOrderListCell.h"
#import "JDReportModel.h"
@interface ECommerceReportDetailTypeOrderListCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *receive;
@property (weak, nonatomic) IBOutlet UILabel *receivePhone;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *payType;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressLbConstraint;
@end

@implementation ECommerceReportDetailTypeOrderListCell
-(void)setModel:(JDorderDetailModel *)model {
    _model = model;
    _name.text =  FillSpace(model.goodsName);
    _address.text = model.consigneeAddr;
    
    if (model.consigneeAddr.length>=1) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 4;
        CGFloat MAXW = SCREEN_WIDTH - 105-15;
        CGFloat height= [model.consigneeAddr
                    boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
        
        [self heightOfLabel:self.address content:self.address.text maxWidth:SCREEN_WIDTH-105-15];
        _address.numberOfLines = (NSInteger)height/15+1;
        self.address.frame =CGRectMake(105, 45, SCREEN_WIDTH-105-15, height);
       } else {
        self.address.text = @"--";
        self.address.frame =CGRectMake(90, 80, SCREEN_WIDTH-90-15, 15);
       }
    
    _orderTime.text = FillSpace(model.orderDate);
    _money.text = FillSpace(model.orderMoney);
    _receive.text = FillSpace(model.consigneePerson);
    _receivePhone.text = FillSpace(model.tel);
    _state.text = FillSpace(model.orderStatus);
    _payType.text = FillSpace(model.payType);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = NO;
    // Initialization code
}
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview {
    static NSString *ID = @"ECommerceReportDetailTypeOrderListCell";
    ECommerceReportDetailTypeOrderListCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ECommerceReportDetailTypeOrderListCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)heightOfLabel:(UILabel *)contentLabel content:(NSString *)content maxWidth:(CGFloat)maxWidth{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    [attributedString addAttribute:NSFontAttributeName value:contentLabel.font range:NSMakeRange(0, [content length])];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    [paragraphStyle setAlignment:0];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    contentLabel.attributedText = attributedString;
    
}
@end
