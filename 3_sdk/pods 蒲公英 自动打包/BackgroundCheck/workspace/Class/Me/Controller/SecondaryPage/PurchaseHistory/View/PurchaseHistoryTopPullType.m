//
//  PurchaseHistoryTopPullTime.m
//  CreditPlatform
//
//  Created by gyjrong on 16/9/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "PurchaseHistoryTopPullType.h"
#import "PurchaseHistoryTopPullTypeModel.h"
@interface PurchaseHistoryTopPullType ()
//左
@property (weak, nonatomic) IBOutlet UIButton *leftIcon;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
//右
@property (weak, nonatomic) IBOutlet UIButton *rightIcon;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
//顶部
@property (weak, nonatomic) IBOutlet UIButton *topIcon;
@property (weak, nonatomic) IBOutlet UIButton *topBtn;

// 全部的btn
@property (weak, nonatomic) IBOutlet UIView *hidView;
// 左右的view
@property (weak, nonatomic) IBOutlet UIView *firstView;
// 底部的线
@property (weak, nonatomic) IBOutlet UIView *bottomLine;



@end

@implementation PurchaseHistoryTopPullType

+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview {
    static NSString *ID = @"PurchaseHistoryTopPullType";
    PurchaseHistoryTopPullType *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PurchaseHistoryTopPullType" owner:nil options:nil] lastObject];
    }
    
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self clearData];
     self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_leftBtn setTitleColor:RGB_blueText forState:UIControlStateSelected];
    [_rightBtn setTitleColor:RGB_blueText forState:UIControlStateSelected];
    [_topBtn setTitleColor:RGB_blueText forState:UIControlStateSelected];
    [_topBtn setTitleColor:RGB_black forState:UIControlStateNormal];
    [_topBtn setTitle:@"全部" forState:UIControlStateSelected];
    _leftBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _rightBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}
-(void)drawRect:(CGRect)rect{
    _leftBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _rightBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}
-(void)clearData {
    _leftIcon.hidden = YES;
    _leftIcon.hidden = YES;
    _topIcon.hidden =YES;
    
    _leftBtn.selected = NO;
    _rightBtn.selected = NO;
    _topBtn.selected =NO;
    
//    _firstView.hidden = NO;
//    _hidView.hidden =YES;
    _bottomLine.hidden =NO;
    _rightBtn.enabled =YES;
    _rightIcon.enabled = YES;
}

//-(void)setIsSelected:(BOOL)isSelected{
//    _isSelected = isSelected;
//    if (isSelected == NO) {
//        _leftIcon.hidden = YES;
//        _leftIcon.hidden = YES;
//        _leftBtn.selected = NO;
//        _rightBtn.selected = NO;
//        
//    }
//}
-(void)setModel:(PurchaseHistoryTopPullTypeModel *)model{
    _model = model;
    [self clearData];
    
    if (model.nameT.length) {//顶部设置
        _firstView.hidden = YES;
        _hidView.hidden =NO;
        _hidView.userInteractionEnabled = YES;
        _topIcon.hidden = YES;
        
        [_topBtn setTitle:@"全部" forState:UIControlStateNormal];
        
        [self.contentView bringSubviewToFront:_hidView];
      
        if (model.selectedT) {
            _topIcon.hidden = NO;
            _topBtn.selected = YES;
        }else{
            _topIcon.hidden =YES;
            _topBtn.selected = NO;
        }
    }else{
        _firstView.hidden = NO;
        _hidView.hidden =YES;
        _topIcon.hidden =YES;
        [self.contentView bringSubviewToFront:_firstView];
        
        
        if (model.selectedT) {
            _topIcon.hidden = NO;
            _topBtn.selected = YES;
        }else{
            _topIcon.hidden =YES;
            _topBtn.selected = NO;
        }
        
        [_leftBtn setTitle:model.nameLeft forState:UIControlStateNormal];
        [_rightBtn setTitle:model.nameRight forState:UIControlStateNormal];
        if (!model.selectedR) {
            _rightIcon.hidden = YES;
            _rightBtn.selected = NO;
        }else{
            _rightIcon.hidden = NO;
            _rightBtn.selected = YES;
        }
        if (!model.selectedL) {
            _leftBtn.selected = NO;
            _leftIcon.hidden = YES;
        }else{
            _leftBtn.selected = YES;
            _leftIcon.hidden = NO;
        }
        
        if (!model.nameRight) {
            _bottomLine.hidden = YES;
            _rightBtn.enabled =NO;
            _rightIcon.enabled =NO;
        }else{
            _bottomLine.hidden =NO;
            _rightBtn.enabled =YES;
            _rightIcon.enabled = YES;
        }
        
    }
    
    
    
}
- (IBAction)touchFirst:(UIButton *)sender {
//    _topIcon.hidden = !_topIcon.hidden;
//    _topBtn.selected = !_topBtn.selected;
//    _model.selectedT = !_model.selectedT;
    _topIcon.hidden = NO;
    _topBtn.selected = YES;
    _model.selectedT = YES;

    if (_leftBtn.selected) {
        _leftBtn.selected = NO;
        _leftIcon.hidden = YES;
        _model.selectedL = !_model.selectedL;
    }
    if (_rightBtn.selected) {
        _rightIcon.hidden = YES;
        _rightBtn.selected = NO;
        _model.selectedR =!_model.selectedR;
    }
    
    if (_model.selectedT && [self.delegate respondsToSelector:@selector(didSelectedPurchaseHistoryTypeDidSelected:)]) {
        [self.delegate didSelectedPurchaseHistoryTypeDidSelected:_model];
    }
    
}

- (IBAction)clickedLeftBtn:(UIButton*)sender {
//    _leftIcon.hidden = !_leftIcon.hidden;
//    _leftBtn.selected = !_leftBtn.selected;
//    _model.selectedL = !_model.selectedL;
    _leftIcon.hidden = NO;
    _leftBtn.selected = YES;
    _model.selectedL = YES;
    if (_rightBtn.selected) {
        _rightIcon.hidden = YES;
        _rightBtn.selected = NO;
        _model.selectedR =!_model.selectedR;
    }
    if (_topIcon.hidden == NO) {
        _topIcon.hidden =YES;
        _model.selectedT = NO;
    }
    if (_leftBtn.selected && [self.delegate respondsToSelector:@selector(didSelectedPurchaseHistoryTypeDidSelected:)]) {
        [self.delegate didSelectedPurchaseHistoryTypeDidSelected:_model];
    }
}

- (IBAction)clickedRightBtn:(UIButton *)sender {
//    _rightIcon.hidden = !_rightIcon.hidden;
//    _rightBtn.selected = !_rightBtn.selected;
//    _model.selectedR =!_model.selectedR;
    _rightIcon.hidden = NO;
    _rightBtn.selected = YES;
    _model.selectedR =YES;
    if (_leftBtn.selected) {
        _leftBtn.selected = NO;
        _leftIcon.hidden = YES;
        _model.selectedL = !_model.selectedL;
    }
    if (_topIcon.hidden == NO) {
        _topIcon.hidden =YES;
        _model.selectedT = NO;
    }
    if (_rightBtn.selected && [self.delegate respondsToSelector:@selector(didSelectedPurchaseHistoryTypeDidSelected:)]) {
        [self.delegate didSelectedPurchaseHistoryTypeDidSelected:_model];
    }
    
    
}




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
//- (void)setFrame:(CGRect)frame {
//   [super setFrame:frame];
//}



@end

