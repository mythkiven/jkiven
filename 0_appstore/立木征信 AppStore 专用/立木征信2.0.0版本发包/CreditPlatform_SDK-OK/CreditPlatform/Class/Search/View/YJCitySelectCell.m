//
//  YJCitySelectCell.m
//  CreditPlatform
//
//  Created by yj on 2016/11/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCitySelectCell.h"
#import "YJCityModel.h"

@interface YJCitySelectCell ()
@property (weak, nonatomic) IBOutlet UILabel *textLB;

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

@end
@implementation YJCitySelectCell

+ (instancetype)citySelectCellWithTableView:(UITableView *)tableView {
    
    YJCitySelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YJCitySelectCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJCitySelectCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
}
- (void)setCityInfoModel:(YJCityInfoModel *)cityInfoModel {
    _cityInfoModel = cityInfoModel;
    self.textLB.text = cityInfoModel.areaName;
    
    if (cityInfoModel.isSelected) {
        self.selectedBtn.selected = YES;
        self.textLB.textColor = RGB_navBar;
    } else {
        self.selectedBtn.selected = NO;
        self.textLB.textColor = RGB_black;
        
    }
    
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    
    self.textLB.text = title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (void)setCityModel:(YJCityModel *)cityModel {
//    _cityModel = cityModel;
//    
//    self.dateLB.text = cityModel.;
//    
//    if (reportDishonestyModel.isSelected) {
//        self.selectedBtn.selected = YES;
//        self.dateLB.textColor = RGB_navBar;
//    } else {
//        self.selectedBtn.selected = NO;
//        self.dateLB.textColor = RGB_black;
//        
//    }
//    
//}


@end
