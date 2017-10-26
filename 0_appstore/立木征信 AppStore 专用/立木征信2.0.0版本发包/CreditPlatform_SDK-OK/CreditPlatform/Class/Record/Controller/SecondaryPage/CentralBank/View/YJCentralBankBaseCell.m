//
//  YJOperatorBaseCell.m
//  CreditPlatform
//
//  Created by yj on 16/8/13.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCentralBankBaseCell.h"

@implementation YJCentralBankBaseCell
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


@end
