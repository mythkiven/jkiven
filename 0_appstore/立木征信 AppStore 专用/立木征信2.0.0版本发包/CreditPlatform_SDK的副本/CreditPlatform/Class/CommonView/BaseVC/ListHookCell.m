//
//  CitySelectCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/27.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "ListHookCell.h"
#import "ListHookModel.h"
//#import "citySearchModel.h"
#import "reportCreditBillModel.h"
@interface ListHookCell()
@property (weak, nonatomic) IBOutlet UIButton *cellClick;

@property (weak, nonatomic) IBOutlet UILabel *cityText;
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;
@end
@implementation ListHookCell

+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview {
    static NSString *ID = @"ListHookCell";
    ListHookCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ListHookCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectImg.hidden =YES;
    self.cityText.textColor = RGB_black;
    
}
- (void)dealloc {
    self.listHookModel = nil;
}


- (IBAction)tapCell:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.selectImg.hidden =NO;
        self.cityText.textColor = RGB(48, 113, 242);
    }else{
        self.selectImg.hidden =YES;
        self.cityText.textColor = RGB_black;
        
    }
    if (self.tapListHookCell) {
        self.listHookModel.selected = YES;
        self.tapListHookCell(_listHookModel);
    }
}



- (void)setListHookModel:(ListHookModel *)listHookModel {
    _listHookModel = listHookModel;
    
    if (listHookModel.selected ) {
        self.selectImg.hidden =NO;
        self.cityText.textColor = RGB(48, 113, 242);
    }
    
    if (_listHookModel.credit) {
        NSString *str = [_listHookModel.credit.cardInfo.cardNo CardWithFormatLastFourNum];
        self.cityText.text=[[NSString decodeCredit:_listHookModel.credit.cardInfo.bankCode] stringByAppendingString:[@" " stringByAppendingString:str]];
    }
    
    else if (_listHookModel.companyCarInsuranc){
        NSString *str = _listHookModel.companyCarInsuranc.val;
        self.cityText.text=str;
    }
    else if (_listHookModel.eBankListModel){
        NSString *str = _listHookModel.eBankListModel.val;
        self.cityText.text=str;
    }
    
    
}

- (void)drawRect:(CGRect)rect {
    if (self.highlighted) {
        self.backgroundColor = RGB_grayPlaceHoldText;
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
       self.backgroundColor = RGB_grayPlaceHoldText;
    }
    else {
    }
    [self setNeedsDisplay];
}


@end
