//
//  YJReportLinkedinEducationView.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "LinkMMreportBaseCellTableViewCell.h"
 

@interface ReportLinkedinEducationView : LinkMMreportBaseCellTableViewCell
@property(nonatomic,strong) educationInfoMM *mmModel;
@property(nonatomic,strong) educationInfoLY *linkModel;
+(CGFloat)cellHelight:(NSString*)str :(SearchItemType)type;
- (instancetype)reportLinkedinEducationCell:(UITableView*)tableview;

@end
