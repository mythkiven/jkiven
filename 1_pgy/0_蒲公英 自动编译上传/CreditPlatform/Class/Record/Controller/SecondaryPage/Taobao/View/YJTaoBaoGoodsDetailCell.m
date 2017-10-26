//
//  YJTaoBaoGoodsDetailCell.m
//  CreditPlatform
//
//  Created by yj on 16/10/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTaoBaoGoodsDetailCell.h"

@interface YJTaoBaoGoodsDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *itemIdLB;

@property (weak, nonatomic) IBOutlet UILabel *itemNameLB;

@property (weak, nonatomic) IBOutlet UILabel *itemPriceLB;
@property (weak, nonatomic) IBOutlet UILabel *itemQuantityLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressContstraintH;

@end

@implementation YJTaoBaoGoodsDetailCell


+ (instancetype)taoBaoGoodsDetailCellWithTableView:(UITableView *)tableView {
    
    YJTaoBaoGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taoBaoGoodsDetailCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJTaoBaoGoodsDetailCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
    
    
}


- (void)setOrderItem:(yjTaoBaoOrderItem *)orderItem {
    _orderItem = orderItem;
    
    if (![orderItem.itemId isEqualToString:@""]) {
        self.itemIdLB.text = orderItem.itemId;

    } else {
        self.itemIdLB.text = @"--";
        
    }
    
    if (![orderItem.itemName isEqualToString:@""] && orderItem.itemName) {
        CGFloat height = [self heightOfLabel:self.itemNameLB content:orderItem.itemName maxWidth:SCREEN_WIDTH-105];
        
        self.addressContstraintH.constant = height;
        
    } else {
        self.itemNameLB.text = @"--";
        self.addressContstraintH.constant = 20;

    }
    
    if (![orderItem.itemPrice isEqualToString:@""]) {
        self.itemPriceLB.text = orderItem.itemPrice;
        
    } else {
        self.itemPriceLB.text = @"--";
        
    }
    
    if (![orderItem.itemQuantity isEqualToString:@""]) {
        self.itemQuantityLB.text = orderItem.itemQuantity;
        
    } else {
        self.itemQuantityLB.text = @"--";
        
    }
    
}


- (CGFloat)heightOfLabel:(UILabel *)contentLabel content:(NSString *)content maxWidth:(CGFloat)maxWidth{
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    
    contentLabel.attributedText = attributedString;
    CGSize size = CGSizeMake(maxWidth, 500000);
    CGSize labelSize = [contentLabel sizeThatFits:size];
    CGRect frame = contentLabel.frame;
    frame.size = labelSize;
    MYLog(@"-------高度%f",frame.size.height);
    
    if (frame.size.height <= 22.0) {
        return 20;
    }
    return frame.size.height;
    
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
