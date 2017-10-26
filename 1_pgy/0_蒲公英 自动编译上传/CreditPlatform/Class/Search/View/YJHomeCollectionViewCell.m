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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconConstraint;

@property (weak, nonatomic) IBOutlet UIView *rightLine;


@end
@implementation YJHomeCollectionViewCell

- (void)setHomeItemModel:(YJHomeItemModel *)homeItemModel {
    _homeItemModel = homeItemModel;
    
    self.iconView.image = [UIImage imageNamed:homeItemModel.icon];
    self.titleLB.text = homeItemModel.title;
    self.titleLB.adjustsFontSizeToFitWidth = YES;
    self.subTitleLB.text = homeItemModel.subTitle;

    if (iPhone5 || iPhone4s) {
        self.subTitleLB.adjustsFontSizeToFitWidth =YES;
    }
    
    if (homeItemModel.searchItemType % 2 == 0) {
        self.rightLine.hidden = NO;
    } else {
        self.rightLine.hidden = YES;
    }
    
    ///////// 特殊 脉脉去掉 /////SDK 介入后在修
    if (homeItemModel.searchItemType == SearchItemTypeLinkedin) {
        self.rightLine.hidden = NO;
    }
    if (homeItemModel.searchItemType == SearchItemTypeCreditCardBill) {
        self.rightLine.hidden = NO;
    }if (homeItemModel.searchItemType == SearchItemTypeCarSafe) {
        self.rightLine.hidden = NO;
    }if (homeItemModel.searchItemType == SearchItemTypeCtrip) {
        self.rightLine.hidden = NO;
    }if (homeItemModel.searchItemType == SearchItemTypeOperators) {
        self.rightLine.hidden = NO;
    }if (homeItemModel.searchItemType == SearchItemTypeTaoBao) {
        self.rightLine.hidden = NO;
    }
    //////////////////////////
    
    if (homeItemModel.searchItemType == SearchItemTypeMore) {
        self.titleLB.textColor = RGB_grayNormalText;
    } else {
         self.titleLB.textColor = RGB_black;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:RGB_graySelected]];
    
    if (iPhone5 || iPhone4s) {
        self.iconConstraint.constant = 11;
    } else {
        self.iconConstraint.constant = 17;

    }
    
    
    // Initialization code
    
}

@end
