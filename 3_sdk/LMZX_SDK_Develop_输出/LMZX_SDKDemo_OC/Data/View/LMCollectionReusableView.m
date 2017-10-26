//
//  LMCollectionReusableView.m
//  LMZX_SDKDemo_OC
//
//  Created by yj on 2017/3/29.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import "LMCollectionReusableView.h"
#import "UIColor+Extension.h"

@interface LMCollectionReusableView ()
@property (weak, nonatomic) IBOutlet UIView *leftLine;

@property (weak, nonatomic) IBOutlet UILabel *groupTitleLB;


@end

@implementation LMCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitle:(NSString *)title {
    _groupTitleLB.text = title;
}
- (void)setLineColor:(NSString *)lineColor {
    _leftLine.backgroundColor = [UIColor colorWithHexString:lineColor];
}

+ (instancetype)collectionReusableView {
    return [[NSBundle mainBundle] loadNibNamed:@"LMCollectionReusableView" owner:nil options:nil].firstObject;
}


@end
