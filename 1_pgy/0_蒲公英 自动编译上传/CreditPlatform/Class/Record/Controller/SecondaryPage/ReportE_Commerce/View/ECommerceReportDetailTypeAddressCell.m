//
//  ECommerceReportDetailTypeAddressCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ECommerceReportDetailTypeAddressCell.h"
#import "JDReportModel.h"
@interface ECommerceReportDetailTypeAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *adress;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressLbConstraint;

@end

@implementation ECommerceReportDetailTypeAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = NO;
    // Initialization code
}
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview {
    static NSString *ID = @"ECommerceReportDetailTypeAddressCell";
    ECommerceReportDetailTypeAddressCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ECommerceReportDetailTypeAddressCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}
-(void)setModel:(JDaddressInfoModel *)model {
    _model= model;
    _name.text =  FillSpace(model.linkman);
    _phone.text =  FillSpace(model.tel);
    _adress.text =  FillSpace(model.address);
    if (model.address.length>=1) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 4;
        CGFloat MAXW = SCREEN_WIDTH - 90-15;
        CGFloat height= [model.address
                         boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
        
        _adress.numberOfLines = (NSInteger)height/15;
        MYLog(@"%@--%ld",model.address,_adress.numberOfLines);
        [self heightOfLabel:self.adress content:model.address maxWidth:SCREEN_WIDTH-90-15];
        self.adress.frame =CGRectMake(90, 80, SCREEN_WIDTH-90-15, height);
//        self.addressLbConstraint.constant = height;
    } else {
        self.adress.text = @"--";
        self.adress.frame =CGRectMake(90, 80, SCREEN_WIDTH-90-15, 15);
    }
    
    
//    if (model.address.length>=1) {
//        _adress.textAlignment = NSTextAlignmentLeft ;
//        _adress.lineBreakMode = UILineBreakModeWordWrap;
//        _adress.numberOfLines = 0;
//    }
    
    
    
//    [_adress alignTop];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
// Configure the view for the selected state
}

- (void)heightOfLabel:(UILabel *)contentLabel content:(NSString *)content maxWidth:(CGFloat)maxWidth{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    
    contentLabel.attributedText = attributedString;
    
}

@end
