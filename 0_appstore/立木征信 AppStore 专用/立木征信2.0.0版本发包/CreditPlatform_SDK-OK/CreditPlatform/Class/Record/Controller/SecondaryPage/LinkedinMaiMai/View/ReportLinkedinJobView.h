//
//  ReportLinkedinJobView.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "LinkMMreportBaseCellTableViewCell.h"

@interface ReportLinkedinJobView : LinkMMreportBaseCellTableViewCell
@property(nonatomic,strong) workInfoMM *mmModel;
@property(nonatomic,strong) workInfoLY *linkModel;

+(CGFloat)cellHelight:(NSString*)str :(SearchItemType)type;
- (instancetype)reportLinkedinJobViewWith:(UITableView*)tableview;
@end
