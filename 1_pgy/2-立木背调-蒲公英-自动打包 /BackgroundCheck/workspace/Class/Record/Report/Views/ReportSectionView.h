//
//  ReportSectionHeaderView.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

// section 标题
#import <UIKit/UIKit.h>
static NSString *const ReportSectionViewIdentifier = @"ReportSectionView";

@interface ReportSectionView : UITableViewHeaderFooterView

@property (assign,nonatomic) NSInteger section;
@property (assign,nonatomic) NSInteger ReportType;
@property (strong,nonatomic) NSString* title;
+(instancetype)reportSectionView ;
 

-(void)configureSection: (NSInteger)section ReportType:(NSInteger)ReportType;
@end
