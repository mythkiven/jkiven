//
//  ReportLinkedinFriendInfoView.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "LinkMMreportBaseCellTableViewCell.h"


@interface ReportLinkedinFriendInfoDetailCell : LinkMMreportBaseCellTableViewCell
@property(nonatomic,strong) friendInfoMM *mmModel;
@property(nonatomic,strong) friendInfoLY *linkModel;

- (instancetype)reportLinkedinFriendInfoDetailCell:(UITableView*)tableview;
@end
