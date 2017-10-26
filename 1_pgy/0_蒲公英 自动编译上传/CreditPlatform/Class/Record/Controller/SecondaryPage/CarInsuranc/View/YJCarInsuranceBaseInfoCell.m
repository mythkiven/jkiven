//
//  YJCarInsuranceOtherInfoCell.m
//  CreditPlatform
//
//  Created by yj on 2016/11/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCarInsurancePolicyInfoCell.h"
#import "YJCarInsuranceModel.h"

@interface YJCarInsuranceBaseInfoCell ()




@end
@implementation YJCarInsuranceBaseInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}



- (void)addSubViewToCell {
    
    _topLine = [UIView separationLine];
    _bottomLine = [UIView separationLine];
    
    _leftLbArray = [NSMutableArray arrayWithCapacity:6];
    _rightLbArray = [NSMutableArray arrayWithCapacity:6];
    
    //    _topLine = [self line];
    //    _bottomLine = [self line];
    
    [self.contentView sd_addSubviews:@[_topLine,_bottomLine]];
    
    
    for (NSString *title in _leftTitles) {
        // 左侧灰字
        UILabel *leftLB = [UILabel grayTitleLBWithTitle:title];
        [_leftLbArray addObject:leftLB];
        
        // 左侧内容
        UILabel *rightLB = [UILabel contentLB];
        [_rightLbArray addObject:rightLB];
        
        [self.contentView sd_addSubviews:@[leftLB, rightLB]];
    }
    
    
}

#pragma mark--布局
- (void)layoutSubview {
    
    _topLine.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .topSpaceToView(self.contentView, 0)
    .heightIs(.5);

    _bottomLine.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0)
    .heightIs(.5);
    
    int count = (int)_leftLbArray.count;
    
    _lastView = _topLine;
    
    for (int i = 0; i < count; i ++) {
        UILabel *leftLB = _leftLbArray[i];
        UILabel *rightLB = _rightLbArray[i];
        
        CGFloat leftH = [leftLB heightOfLabelMaxWidth:_leftLbWidth];
        CGFloat rightH = [rightLB heightOfLabelMaxWidth:_rightLbWidth];
        
        leftLB.sd_layout
        .topSpaceToView(_lastView,kMargin_15)
        .leftSpaceToView(self.contentView,kMargin_15)
        .widthIs(_leftLbWidth)
        .heightIs(leftH);
        
        rightLB.sd_layout
        .leftSpaceToView(leftLB, kMargin_15)
        .topEqualToView(leftLB)
        .widthIs(_rightLbWidth)
        .heightIs(rightH);
        
        // 控制同行的Label最高的作为下一个参考
        if (leftH > rightH) {
            _lastView = leftLB;
        } else {
            _lastView = rightLB;
        }
        
    }
    

    
    
    
    [self setupAutoHeightWithBottomView:_lastView bottomMargin:kMargin_15];

    
    for (UILabel *lb in _leftLbArray) {
        lb.textAlignment = NSTextAlignmentRight;
    }
    
}





@end
