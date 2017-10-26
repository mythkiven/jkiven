//
//  YJIntroHeaderView.m
//  BackgroundCheck
//
//  Created by yj on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "YJIntroHeaderView.h"
#import "YJHomeItemModel.h"
@interface YJIntroHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *imgBgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *desLB;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLB;

@property (weak, nonatomic) IBOutlet UILabel *contentLB;




@end




@implementation YJIntroHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)introHeaderView{
    return [[[NSBundle mainBundle] loadNibNamed:@"YJIntroHeaderView" owner:nil options:nil] firstObject];
}

- (void)setIntroModel:(YJHomeItemModel *)introModel {
    _introModel = introModel;
    self.imgBgView.image = [UIImage imageNamed:_introModel.introBgImg];
    _iconView.image = [UIImage imageNamed:_introModel.icon];
    _desLB.text = _introModel.des;
    _titleLB.text = _introModel.title;
    _subtitleLB.text = _introModel.subTitle;

    
    _contentLB.text = _introModel.content;

    [UILabel changeLineSpaceForLabel:_contentLB WithSpace:3];
    _contentLB.contentMode = UIViewContentModeCenter;
    _contentLB.textAlignment = NSTextAlignmentCenter;
}



@end
