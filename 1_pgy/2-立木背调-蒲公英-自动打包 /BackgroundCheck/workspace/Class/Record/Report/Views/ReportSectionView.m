//
//  ReportSectionHeaderView.m
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "ReportSectionView.h"


@interface ReportSectionView ()

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *sectionTitle;

@end


@implementation ReportSectionView


- (void)awakeFromNib  {
    [super awakeFromNib]; 
}


+(instancetype)reportSectionView {
    return [[[NSBundle mainBundle] loadNibNamed:@"ReportSectionView" owner:nil options:nil] lastObject];
}


-(void)configureSection: (NSInteger)section ReportType:(NSInteger)ReportType{
    _section = section; 
    if (section == 0) { // 基本信息
        _sectionTitle.text = @"基本信息";
    }else if(section == 1) { // 风险提示
        _sectionTitle.text = @"风险提示";
    }else if(section == 2  ) { // 个人履历   0:基础  1:标准
        _sectionTitle.text = ReportType ==0 ? @"个人风险信息" : @"个人履历信息";
    }else if(section == 3  ) { // 个人风险信息
        _sectionTitle.text = @"个人风险信息";
    } 
}

-(void)setTitle:(NSString *)title{
    _sectionTitle.text = title;
}


@end
