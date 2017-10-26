//
//  YJECommerceCell.m
//  CreditPlatform
//
//  Created by yj on 16/8/13.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJECommerceCell.h"

@implementation YJECommerceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.contentView.backgroundColor =[UIColor clearColor];
//        self.backgroundColor =[UIColor clearColor];
    }
    return self;
}
- (void)setFrame:(CGRect)frame {
    
    //    frame.origin.y += 10;
    frame.size.height -= 10;
    
    [super setFrame:frame];
    
    
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [self setSelected:selected animated:YES];
//}
@end
