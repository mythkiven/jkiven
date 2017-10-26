//
//  ORDetailTypeNetworkCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "OperationModel.h"
#import "ORDetailTypeNetworkCell.h"
@interface ORDetailTypeNetworkCell()
@property (weak, nonatomic) IBOutlet UILabel *month;
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *type;
@end
@implementation ORDetailTypeNetworkCell
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview {
    static NSString *ID = @"ORDetailTypeNetworkCell";
    ORDetailTypeNetworkCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ORDetailTypeNetworkCell" owner:nil options:nil] firstObject];
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
-(void)setModel:(OperationNetworkSix *)model{
    _model = model;
    _month.text = [model.netTime substringToIndex:10];
    _address.text = model.place;
    NSString *str;
    long long Long = [model.onlineTime longLongValue];
    if ([model.onlineTime rangeOfString:@":"].location == NSNotFound) {
        if (![NSString stringEndWith:model.onlineTime]) {
            if (Long>60&&Long<(60*60)) {
                ;
                str = [NSString stringWithFormat:@"%lld分%lld秒",Long/60,Long%60];
            } else if (Long>(60*60)) {
                str = [NSString stringWithFormat:@"%lld时%lld分%lld秒",Long/(60*60),(Long%(60*60))/60,(Long%(60*60))%60];
            }else if ([model.onlineTime integerValue]<=60) {
                str = [model.onlineTime stringByAppendingString:@"秒"];
            }
        } else {
            str = model.onlineTime;
        }
    } else {
        str = model.onlineTime;
    }
    
    
    _time.text = str;
    _type.text = FillSpace(model.netType);
    
}

@end
