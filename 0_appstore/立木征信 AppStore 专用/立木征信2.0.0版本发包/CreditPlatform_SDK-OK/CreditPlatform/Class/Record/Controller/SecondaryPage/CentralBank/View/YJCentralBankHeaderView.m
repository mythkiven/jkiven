//
//  YJCentralBankHeaderView.m
//  CreditPlatform
//
//  Created by yj on 16/7/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCentralBankHeaderView.h"
#import "YJCentralBankModel.h"
@interface YJCentralBankHeaderView ()
/*********基本信息********/
/**
*  姓名
*/
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
/**
 *  身份证类型
 */
@property (weak, nonatomic) IBOutlet UILabel *idTypeLB;
/**
 *  身份证号
 */
@property (weak, nonatomic) IBOutlet UILabel *idLB;

/**
 *  婚姻状态
 */
@property (weak, nonatomic) IBOutlet UILabel *marriageLB;
/**
 *  报告编号
 */
@property (weak, nonatomic) IBOutlet UILabel *reportNumLB;
/**
 *  查询时间
 */
@property (weak, nonatomic) IBOutlet UILabel *searchDateLB;
/**
 *  报告时间
 */
@property (weak, nonatomic) IBOutlet UILabel *reportDateLB;


@end

@implementation YJCentralBankHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setBasicInfoModel:(YJCentralBankBasicInfoModel *)basicInfoModel {
    _basicInfoModel = basicInfoModel;
    
    if (basicInfoModel.name) {
        
        self.nameLB.text = [basicInfoModel.name stringByReplacingOccurrencesOfString:@" " withString:@"" options:(NSCaseInsensitiveSearch) range:NSMakeRange(0, 1)];
    }
    if (basicInfoModel.cardType) {
        self.idTypeLB.text = basicInfoModel.cardType;
    }
    if (basicInfoModel.cardNo) {
        self.idLB.text = basicInfoModel.cardNo;
    }
    if (basicInfoModel.maritalStatus) {
        self.marriageLB.text = basicInfoModel.maritalStatus;
    }
    
    if (basicInfoModel.no) {
        self.reportNumLB.text = [basicInfoModel.no stringByReplacingOccurrencesOfString:@" " withString:@"" options:(NSCaseInsensitiveSearch) range:NSMakeRange(0, 1)];
//        self.reportNumLB.text = basicInfoModel.no;
    }
    if (basicInfoModel.sTime) {
        self.searchDateLB.text = basicInfoModel.sTime;
    }
    if (basicInfoModel.time) {
        self.reportDateLB.text = basicInfoModel.time;
    }

    


}





+ (id)centralBankView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YJCentralBankHeaderView" owner:nil options:nil] firstObject];
}

@end
