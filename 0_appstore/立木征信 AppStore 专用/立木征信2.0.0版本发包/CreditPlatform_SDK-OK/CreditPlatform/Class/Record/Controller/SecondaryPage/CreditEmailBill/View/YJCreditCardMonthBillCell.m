//
//  YJCreditCardMonthBillCell.m
//  CreditPlatform
//
//  Created by yj on 2016/11/4.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCreditCardMonthBillCell.h"
#import "reportCreditBillModel.h"
#define kLeftLabelWidth 95
@interface YJCreditCardMonthBillCell ()
{
    UILabel *_trdDateTitleLB;
    UILabel *_currencyTitleLB;
    UILabel *_cardNoTitleLB;
    UILabel *_summaryTitleLB;
    UILabel *_amtTitleLB;
    // 👆为左侧标题
    // 👇为右侧内容
    UILabel *_trdDateLB;
    UILabel *_currencyLB;
    UILabel *_cardNoLB;
    UILabel *_summaryLB;
    UILabel *_amtLB;
    
    UIView *_topLine;
}



@end
@implementation YJCreditCardMonthBillCell
+ (instancetype)creditCardMonthBillCelWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"creditCardMonthBillCell";
    YJCreditCardMonthBillCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
    
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _trdDateTitleLB = [self grayTitleLBWithTitle:@"交易明细日期"];
        _currencyTitleLB = [self grayTitleLBWithTitle:@"币别"];
        _cardNoTitleLB = [self grayTitleLBWithTitle:@"卡号"];
        _summaryTitleLB = [self grayTitleLBWithTitle:@"交易描述"];
        _amtTitleLB = [self grayTitleLBWithTitle:@"交易金额"];
        // 👆为左侧标题
        // 👇为右侧内容
        _trdDateLB = [self contentLB];
        _currencyLB = [self contentLB];
        _cardNoLB = [self contentLB];
        _summaryLB = [self contentLB];
        _amtLB = [self contentLB];
        
        
        _topLine = [self line];
        self.bottomLine = [self line];
        
        [self.contentView sd_addSubviews:@[_trdDateTitleLB, _currencyTitleLB, _cardNoTitleLB, _summaryTitleLB, _amtTitleLB, _trdDateLB, _currencyLB, _cardNoLB, _summaryLB, _amtLB,_topLine,_bottomLine]];
        

        
    }
    return self;
}



//设置cell
-(void)setCellmodel:(reportCreditBilldetails *)cellmodel{

    _cellmodel =cellmodel;
    _trdDateLB.text = cellmodel.trdDate;
    _currencyLB.text = [cellmodel.currency decodeCoin];
    _cardNoLB.text = cellmodel.cardNo;
    _summaryLB.text = [cellmodel.summary cutSpace];
    _amtLB.text = [cellmodel.amt decodeCoinSign:cellmodel.currency];
    

    [self layoutMySubviews];
    
    
}

- (void)layoutMySubviews {
    CGFloat marginToSuper = 15;
    
    _topLine.sd_layout
    .leftSpaceToView(self.contentView, marginToSuper)
    .rightSpaceToView(self.contentView, 0)
    .topSpaceToView(self.contentView, 0)
    .heightIs(.5);
    
    self.bottomLine.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0)
    .heightIs(.5);
    
    // 固定两侧的宽度
    CGFloat leftW = kLeftLabelWidth;
    CGFloat leftH = 18;
    CGFloat rightW = SCREEN_WIDTH - marginToSuper*3 - leftW;
    CGFloat rightH = 0;
    
    
    // 交易明细日期
    _trdDateTitleLB.sd_layout
    .leftSpaceToView(self.contentView, marginToSuper)
    .topSpaceToView(self.contentView, marginToSuper)
    .widthIs(leftW)
    .heightIs(leftH);
    
    rightH = [_trdDateLB heightOfLabelMaxWidth:rightW];
    _trdDateLB.sd_layout
    .leftSpaceToView(_trdDateTitleLB, marginToSuper)
    .topEqualToView(_trdDateTitleLB)
    .widthIs(rightW)
    .heightIs(rightH);
    
    // 币别
    _currencyTitleLB.sd_layout
    .leftSpaceToView(self.contentView, marginToSuper)
    .topSpaceToView(_trdDateLB, marginToSuper)
    .widthIs(leftW)
    .heightIs(leftH);
    
    rightH = [_currencyLB heightOfLabelMaxWidth:rightW];
    _currencyLB.sd_layout
    .leftSpaceToView(_currencyTitleLB, 15)
    .topEqualToView(_currencyTitleLB)
    .widthIs(rightW)
    .heightIs(rightH);
    
    // 卡号
    _cardNoTitleLB.sd_layout
    .leftSpaceToView(self.contentView, marginToSuper)
    .topSpaceToView(_currencyLB, marginToSuper)
    .widthIs(leftW)
    .heightIs(leftH);
    
    rightH = [_cardNoLB heightOfLabelMaxWidth:rightW];
    _cardNoLB.sd_layout
    .leftSpaceToView(_cardNoTitleLB, marginToSuper)
    .topEqualToView(_cardNoTitleLB)
    .widthIs(rightW)
    .heightIs(rightH);
    
    // 交易描述
    _summaryTitleLB.sd_layout
    .leftSpaceToView(self.contentView, marginToSuper)
    .topSpaceToView(_cardNoLB, marginToSuper)
    .widthIs(leftW)
    .heightIs(leftH);
    
    rightH = [_summaryLB heightOfLabelMaxWidth:rightW];
    _summaryLB.sd_layout
    .leftSpaceToView(_summaryTitleLB, 15)
    .topEqualToView(_summaryTitleLB)
    .widthIs(rightW)
    .heightIs(rightH);
    
    // 交易金额
    _amtTitleLB.sd_layout
    .leftSpaceToView(self.contentView, marginToSuper)
    .topSpaceToView(_summaryLB, marginToSuper)
    .widthIs(leftW)
    .heightIs(leftH);
    
    rightH = [_amtLB heightOfLabelMaxWidth:rightW];
    _amtLB.sd_layout
    .leftSpaceToView(_amtTitleLB, marginToSuper)
    .topEqualToView(_amtTitleLB)
    .widthIs(rightW)
    .heightIs(rightH);
    
    //***********************高度自适应cell设置步骤************************
    [self setupAutoHeightWithBottomView:_amtLB bottomMargin:marginToSuper];
    
}

/**
 左侧标题
 
 */
- (UILabel *)grayTitleLBWithTitle:(NSString *)title {
    UILabel *lb = [UILabel new];
    lb.font = Font15;
    lb.text = title;
//        lb.backgroundColor = RGB_red;
    lb.textAlignment = NSTextAlignmentRight;
    lb.textColor = RGB_grayNormalText;
    
    return lb;
}
/**
 右侧内容
 
 */
- (UILabel *)contentLB {
    UILabel *lb = [UILabel new];
    lb.font = Font15;
    lb.textAlignment = NSTextAlignmentLeft;
    lb.textColor = RGB_black;
    lb.numberOfLines = 0;
    lb.text = @"--";
//    lb.backgroundColor = RGB_red;
    return lb;
}

/**
 分割线
 
 */
- (UIView *)line {
    UIView *line = [UIView new];
    line.backgroundColor = RGB_grayLine;
    return line;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
