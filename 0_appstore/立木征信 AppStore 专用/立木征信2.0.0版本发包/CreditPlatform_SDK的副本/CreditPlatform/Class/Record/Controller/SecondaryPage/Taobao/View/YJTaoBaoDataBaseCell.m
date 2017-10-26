//
//  YJTaoBaoDataBaseCell.m
//  CreditPlatform
//
//  Created by yj on 16/10/10.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTaoBaoDataBaseCell.h"

@implementation YJTaoBaoDataBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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


- (void)setFrame:(CGRect)frame {
    //    frame.origin.x = kMargin;
    //    frame.size.width -= kMargin * 2;
    //
    //    frame.origin.y += 10;
    frame.size.height -= 10;
    
    [super setFrame:frame];
    
    
}

@end
