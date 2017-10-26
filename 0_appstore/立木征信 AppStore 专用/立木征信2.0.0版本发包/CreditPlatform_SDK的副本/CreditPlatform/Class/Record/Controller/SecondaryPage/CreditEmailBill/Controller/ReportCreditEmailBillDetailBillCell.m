//
//  ReportCreditEmailBillDetailBillCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ReportCreditEmailBillDetailBillCell.h"
@interface ReportCreditEmailBillDetailBillCell ()

// header view
//

// cell
@property (weak, nonatomic) IBOutlet UILabel *payDetail;
@property (weak, nonatomic) IBOutlet UILabel *cardG;
@property (weak, nonatomic) IBOutlet UILabel *cardID;
@property (weak, nonatomic) IBOutlet UILabel *dec;
@property (weak, nonatomic) IBOutlet UILabel *dearPay;



@end

@implementation ReportCreditEmailBillDetailBillCell
+ (instancetype)reportCreditEmailBillDetailBillCellWithTableView:(UITableView *)tableView{
    ReportCreditEmailBillDetailBillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportCreditEmailBillDetailBillCell"];
    
    if (cell == nil) {
        
        cell= [[[NSBundle mainBundle] loadNibNamed:@"ReportCreditEmailBillDetailBillCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
   
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.contentView.backgroundColor = RGB_white;
    self.backgroundColor = RGB_white;
}

//设置cell
-(void)setCellmodel:(reportCreditBilldetails *)cellmodel{
    _cellmodel =cellmodel;
    _payDetail.text = cellmodel.trdDate ;
    _cardG.text = [cellmodel.currency decodeCoin];
    _cardID.text = cellmodel.cardNo;
    _dec.text = [cellmodel.summary cutSpace];
    _dearPay.text = [cellmodel.amt decodeCoinSign:cellmodel.currency];
    if (_dec.text.length) {
        CGFloat MAXW = SCREEN_WIDTH - 120-10;
//        NSString* str = [NSString  newString:_dec.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;
        CGFloat height= [_dec.text
                         boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
        if (height>=30) {
            _dec.frame = CGRectMake(120,  114, MAXW, height);
            _dec.numberOfLines = (NSInteger)(height/15.0 +1);
        }
        
    }
    
}
-(void)drawRect:(CGRect)rect{
    if (_dec.text.length>6) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_dec.text];
        [attributedString addAttribute:NSFontAttributeName value:_dec.font range:NSMakeRange(0, [_dec.text length])];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [paragraphStyle setAlignment:0];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_dec.text length])];
        _dec.attributedText = attributedString;
    }
    
}

+(CGFloat)cellHelight:(NSString*)str{
    if (str.length) {
        CGFloat MAXW = SCREEN_WIDTH - 120-10;
//        str = [NSString  newString:str];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;
        CGFloat height= [str
                         boundingRectWithSize:CGSizeMake(MAXW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : paragraphStyle} context:nil].size.height;
        if (height>=30) {
            return 180+(height-20);
        }
        return 180;
        
    }
    // 默认180
    return 180;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
