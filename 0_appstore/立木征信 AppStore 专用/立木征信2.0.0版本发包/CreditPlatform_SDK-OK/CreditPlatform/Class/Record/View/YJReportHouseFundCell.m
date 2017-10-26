//
//  YJReportHouseFundCell.m
//  CreditPlatform
//
//  Created by yj on 16/7/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJReportHouseFundCell.h"
#import "ReportFirstCommonModel.h"
@interface YJReportHouseFundCell ()
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLB;

/**
 *  账号
 */
@property (weak, nonatomic) IBOutlet UILabel *accountLB;
/**
 *  查询日期
 */
@property (weak, nonatomic) IBOutlet UILabel *searchDateLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line1Height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line2Height;

//手机号
@property (weak, nonatomic) IBOutlet UILabel *accountL;
// 3个detail，第一个
@property (weak, nonatomic) IBOutlet UILabel *FirstLabel;



@end

@implementation YJReportHouseFundCell


+ (instancetype)reportHouseFundCellWithTableView:(UITableView *)tableView  isShow:(NSInteger)show{
    
    YJReportHouseFundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reportHouseFundCell"];
    
    if (cell == nil) {// NO-3 YES -2
        if (show==1) {// 1行
            cell= [[[NSBundle mainBundle] loadNibNamed:@"YJReportHouseFundCell" owner:nil options:nil] firstObject];
        }else if (show==2) {//2行
            cell= [[NSBundle mainBundle] loadNibNamed:@"YJReportHouseFundCell" owner:nil options:nil][1];
        }else if (show==3) {//3行
             cell= [[[NSBundle mainBundle] loadNibNamed:@"YJReportHouseFundCell" owner:nil options:nil] lastObject];
        }
    }
    return cell;
    
    
}
-(void)setAccount:(NSString *)account{
    _account  = account ;
    _accountL.text = account;
}
-(void)setPosition:(NSString *)position{
    _position = position;
    _FirstLabel.text = position;
}


+ (instancetype)reportHouseFundCellWithTableView:(UITableView *)tableView  {
    
    
    YJReportHouseFundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reportHouseFundCell"];
    
    if (cell == nil) {
         cell= [[[NSBundle mainBundle] loadNibNamed:@"YJReportHouseFundCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
    
}
- (void)setFrame:(CGRect)frame {
    
//    frame.origin.y += 10;
//    frame.size.height -= 10;
//    frame.origin.y += 10;
    frame.size.height -= 10;
    [super setFrame:frame];
    
    
}
- (void)setModel:(ReportFirstCommonModel *)model{
    _model = model;
    _nameLB.text = @"--";
    if (model.realName.length>=1) {
        _nameLB.text= model.realName;
    }
    
    _cityLB.text = model.provinceName;
    if (self.position.length) {
        _cityLB.text = model.position;
    }
    
    
    if ([self.bizType isEqualToString:kBizType_shixin]) {
        _accountLB.text = model.idCard;
        _nameLB.text= model.accountName;
    }else if ([self.bizType isEqualToString:kBizType_ctrip]) {
        _accountLB.text = model.accountName;
        if (model.realName&&model.realName.length) {
            _nameLB.text= model.realName;
        }
    }else if ([self.bizType isEqualToString:kBizType_diditaxi]) {
        _accountLB.text = model.createDateApp;
//        if (model.realName&&model.realName.length) {
            _nameLB.text= model.accountName;
//        }
    } else {
        _accountLB.text = model.accountName;
    }
    

    _searchDateLB.text = model.createDateApp;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.line1Height.constant = 0.5;
    self.line2Height.constant = 0.5;
}

@end
