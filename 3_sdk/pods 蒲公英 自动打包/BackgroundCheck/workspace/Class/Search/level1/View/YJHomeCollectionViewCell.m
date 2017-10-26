//
//  YJHomeCollectionViewCell.m
//  CreditPlatform
//
//  Created by yj on 16/10/9.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJHomeCollectionViewCell.h"

@interface YJHomeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLB;

@property (weak, nonatomic) IBOutlet UILabel *desLB;


@property (weak, nonatomic) IBOutlet UIButton *quickSearchBtn;
@property (weak, nonatomic) IBOutlet UIButton *guideBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation YJHomeCollectionViewCell

- (void)setHomeItemModel:(YJHomeItemModel *)homeItemModel {
    _homeItemModel = homeItemModel;
    
    self.iconView.image = [UIImage imageNamed:homeItemModel.icon];
    self.titleLB.text = homeItemModel.title;
    self.titleLB.adjustsFontSizeToFitWidth = YES;
    self.subTitleLB.text = homeItemModel.subTitle;
    self.desLB.text = homeItemModel.des;

    if (iPhone5 || iPhone4s) {
        self.subTitleLB.adjustsFontSizeToFitWidth =YES;
    }
    

   
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.guideBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_white] forState:(UIControlStateNormal)];
    [self.guideBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB(221,221,221)] forState:(UIControlStateHighlighted)];
    
    [self.quickSearchBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB_white] forState:(UIControlStateNormal)];
    [self.quickSearchBtn setBackgroundImage:[UIImage resizedImageWithColor:RGB(221,221,221)] forState:(UIControlStateHighlighted)];
    
//    self.layer.cornerRadius = 5;
//    self.layer.masksToBounds = YES;

    
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.shadowRadius = 5;
    self.bgView.layer.shadowOffset= CGSizeMake(0, 5);
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOpacity = 0.15f;
//    self.bgView.layer.masksToBounds = YES;
//    self.bgView.clipsToBounds = YES;

}


- (void)setupCorner {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.guideBtn.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.guideBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    self.guideBtn.layer.mask = maskLayer;
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.quickSearchBtn.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.quickSearchBtn.bounds;
    maskLayer1.path = maskPath1.CGPath;
    self.quickSearchBtn.layer.mask = maskLayer1;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupCorner];

    
}




- (IBAction)guideBtnClick:(UIButton *)sender {
    if (self.guideBlock) {
        self.guideBlock();
    }
    
}



- (IBAction)quickSearchBtnClick:(UIButton *)sender {
    if (self.quickSearchBlock) {
        self.quickSearchBlock();
    }
    
}



@end
