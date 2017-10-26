//
//  ORDetailTypeCallListCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "OperationModel.h"
#import "ORDetailTypeCallListCell.h"
@interface ORDetailTypeCallListCell ()
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *Long;
@property (weak, nonatomic) IBOutlet UILabel *adsress;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *Month;

@end
@implementation ORDetailTypeCallListCell
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview {
    static NSString *ID = @"ORDetailTypeCallListCell";
    ORDetailTypeCallListCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ORDetailTypeCallListCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(OperationCallSix *)model{
    _model = model;
    _time.text = [model.callDateTime substringFromIndex:10];
    _Month.text =[model.callDateTime substringToIndex:10];
    NSString *str;
    long long Long = [model.callTimeLength longLongValue];
    if ([model.callTimeLength rangeOfString:@":"].location == NSNotFound) {
        if (![NSString stringEndWith:model.callTimeLength]) {
            if (Long>60&&Long<(60*60)) {
                ;
                str = [NSString stringWithFormat:@"%lld分%lld秒",Long/60,Long%60];
            } else if (Long>(60*60)) {
                str = [NSString stringWithFormat:@"%lld时%lld分%lld秒",Long/(60*60),(Long%(60*60))/60,(Long%(60*60))%60];
            }else if ([model.callTimeLength integerValue]<=60) {
                str = [model.callTimeLength stringByAppendingString:@"秒"];
            }
        } else {
            str = [model.callTimeLength  stringByAppendingString:@"秒"];
        }
    } else {
        str = model.callTimeLength;
    }
    
    
    
    _Long.text =  str;
    _adsress.text =FillSpace( model.callAddress);
    _type.text = FillSpace(model.callType);
    _num.text = FillSpace(model.mobileNo);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
