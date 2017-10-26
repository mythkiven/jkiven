//
//  ORDetailTypeTenMostCallCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "OperationModel.h"
#import "ORDetailTypeTenMostCallCell.h"
#import "OperationNewModel.h"

@interface ORDetailTypeTenMostCallCell ()
//@property (weak, nonatomic) IBOutlet UILabel *month;

@property (weak, nonatomic) IBOutlet UILabel *phone;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *adsress;
@property (weak, nonatomic) IBOutlet UILabel *Long;


@property (weak, nonatomic) IBOutlet UILabel *first;
@property (weak, nonatomic) IBOutlet UILabel *last;


@end
@implementation ORDetailTypeTenMostCallCell
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview {
    static NSString *ID = @"ORDetailTypeTenMostCallCell";
    ORDetailTypeTenMostCallCell*cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ORDetailTypeTenMostCallCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setModelNew:(OperationNewCallTen *)modelNew {
    _phone.text = modelNew.mobileNo;
    _time.text = modelNew.callCount;
    _adsress.text = modelNew.mobileArea;
    _Long.text = modelNew.callTotalTimeStr;
//    if ( modelNew.callTotalTime.length>=1) {
//        _Long.text = [NSString stringWithFormat:@"%@分",modelNew.callTotalTime];
//    }
    _first.text = modelNew.oldCallTime;
    _last.text = modelNew.nearCallTime;
    
}
//- (void)setModel:(OperationCallTen *)model{
//    _model = model;
////    _month.text =  @"";
//    _phone.text = FillSpace(model.mobileNo);
//    _time.text = FillSpace(model.callCount);
//}
@end
