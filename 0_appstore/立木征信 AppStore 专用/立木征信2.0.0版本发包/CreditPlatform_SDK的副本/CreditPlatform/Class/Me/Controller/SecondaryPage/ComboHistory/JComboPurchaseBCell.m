//
//  JComboPurchaseBCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "JComboPurchaseBCell.h"

@interface JComboPurchaseBCell()
@property (weak, nonatomic) IBOutlet UILabel *No;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *queryNum;
@property (weak, nonatomic) IBOutlet UILabel *priceSingle;
@property (weak, nonatomic) IBOutlet UILabel *discount;

@end

@implementation JComboPurchaseBCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
   
}
-(void)drawRect:(CGRect)rect{
    [_No jSetAttributedStringRange:NSMakeRange(0, _No.text.length) Color:RGB_blueText Font:Font21];
    [_totalPrice jSetAttributedStringRange:NSMakeRange(0, _totalPrice.text.length) Color:RGB_redText Font:Font15];
    
}
+ (instancetype)jComboPurchaseBCellWithTableView:(UITableView *)tableView {
    
    JComboPurchaseBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JComboPurchaseBCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"JComboPurchaseBCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
  
}
- (void)setIndex:(NSInteger)index {
    _No.text = [NSString stringWithFormat:@"%ld",index+1];
}
-(void)setJComboPurchaseBModel:(JComboPurchaseBListModel *)jComboPurchaseBModel{
    if (jComboPurchaseBModel.amt.length) {
        _totalPrice.text = [@"￥" stringByAppendingString: jComboPurchaseBModel.amt];
    } else {
        _totalPrice.text = jComboPurchaseBModel.amt;
    }
    
    _name.text = jComboPurchaseBModel.apiTypeName;
    _queryNum.text = jComboPurchaseBModel.queryCount;
    
    if (jComboPurchaseBModel.price.length) {
        _priceSingle.text = [@"￥" stringByAppendingString: [NSString stringWithFormat:@"%.2f",[jComboPurchaseBModel.price floatValue]]];
    } else {
        _priceSingle.text = jComboPurchaseBModel.price;
    }
    
    if (jComboPurchaseBModel.discount.length) {
        _discount.text = [jComboPurchaseBModel.discount percentDdeciString];
    } else {
        _discount.text = jComboPurchaseBModel.discount;
    }
    
    
}
- (void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
