//
//  LMHomeCollectionViewCell.m
//  LMZX_SDKDemo_OC
//
//  Created by yj on 2017/3/29.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import "LMHomeCollectionViewCell.h"
#import "LMHomeTypeModel.h"

@interface LMHomeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLb;


@end
@implementation LMHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
}

- (void)setFunctionModel:(LMHomeTypefunction *)functionModel {
    _functionModel = functionModel;
    
    _iconView.image = [UIImage imageNamed:functionModel.icon];
    _titleLb.text = functionModel.title;
    
    
}

@end
