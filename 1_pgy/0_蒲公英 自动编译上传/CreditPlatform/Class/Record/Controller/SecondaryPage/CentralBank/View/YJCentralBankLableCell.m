//
//  YJCentralBankLableCell.m
//  CreditPlatform
//
//  Created by yj on 16/8/22.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCentralBankLableCell.h"

@interface YJCentralBankLableCell ()
{
    UILabel *_contentLB;
    
}

@end
@implementation YJCentralBankLableCell
+ (instancetype)centralBankLableCell:(UITableView *)tableview {
    static NSString *ID = @"centralBankLableCell";
    YJCentralBankLableCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[YJCentralBankLableCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 上分割线
        UIView *view0 = [UIView new];
        view0.backgroundColor = RGB_grayLine;
        
        UILabel *contentLB = [UILabel new];
        contentLB.numberOfLines = 0;
        contentLB.textAlignment = NSTextAlignmentLeft;
        contentLB.textColor = RGB_black;
        contentLB.font = Font13;
        contentLB.backgroundColor = [UIColor clearColor];
        _contentLB = contentLB;

        
        
        [self.contentView sd_addSubviews:@[contentLB, view0 ]];
        
        

        
        
        //描述
        contentLB.sd_layout
        .topSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.contentView, 15)
        ;
        
        //下分割线
        view0.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(0.5)
        .bottomSpaceToView(self.contentView, 0);
        
        
        //***********************高度自适应cell设置步骤************************
        
        
        
    }
    return self;
}

- (void)setContent:(NSString *)content {
    _content = [content copy];
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];

    _contentLB.attributedText = attributedString;
    CGSize size = CGSizeMake(SCREEN_WIDTH-30, 500000);
    CGSize labelSize = [_contentLB sizeThatFits:size];

    _contentLB.sd_layout.heightIs(labelSize.height);
    [self setupAutoHeightWithBottomView:_contentLB bottomMargin:15];
}

@end
